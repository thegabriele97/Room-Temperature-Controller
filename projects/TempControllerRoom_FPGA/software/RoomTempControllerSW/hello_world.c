#include <stdio.h>
#include <string.h>
#include "system.h"
#include "alt_types.h"
#include "sys/alt_irq.h"
#include "sys/alt_timestamp.h"

#include "drivers/uart.h"
#include "drivers/adc.h"
#include "drivers/pwm.h"

#define gabriuart_cmd_size			0x5
#define gabriuart_data_array_size	0xff

#define TIMER_INTERVAL(period, freq) (period * (freq / 1000))

enum {
	PING = 0x474e4950,
	CSET = 0x54455343,
	CGET = 0x54454743
} cmd_e;

typedef enum { false, true } bool;

typedef struct {
	unsigned char value;
	unsigned int duty0;
	unsigned int duty1;
} ths_t;

void _ISR_uart0(void *context, alt_u32 id);
alt_u8 gabriuart_checksum(alt_u32 crc);
alt_u32 gabriuart_cmd2_u32(char *v);
void gabriuart_send(char *cmd, alt_u8 length, alt_u8 *data);

static uart_t uart0;
static pwm_t pwm0, pwm1;

static unsigned int sampling_period_ms = 1000;
static unsigned int avg_each_count = 4;
static ths_t th0, th1, th2;

int main() {
	int *gpio_base_ptr = GPIO_0_BASE;
	alt_u8 avg_cnt = 0, data[16];
	int start, avg_sum = 0;
	adc_t adc0;

	th0.value = 32;		//10 °C
	th0.duty0 = 0;
	th0.duty1 = 0;

	th1.value = 64;		//20 °C
	th1.duty0 = 512;
	th1.duty1 = 0;

	th2.value = 96;		//30 °C
	th2.duty0 = 1023;
	th2.duty1 = 512;

	pwm0 = pwm_init(0x10000080, 0x100000a0);
	pwm_set_dutycycle(pwm0, th1.duty0);

	pwm1 = pwm_init(0x100000c0, 0x100000e0);
	pwm_set_dutycycle(pwm1, th1.duty1);

	*(gpio_base_ptr + 1) |= 0xf;

	uart0 = uart_begin(UART_0_BASE, BR_CALC(UART_0_FREQ, 19200));
	uprintf(uart0, "Hellooooooo maaaan!\r\n");
	uprintf(uart0, " :> %d\r\n", uart0->divisor);

	uart_register_irq(uart0, _ISR_uart0, NULL);
	uart0->control.fields.irrdy = 1;

	adc0 = adc_init(0x10000060);

	do {
		//uprintf(uart0, "Temp: %.1f °C\r\n", (adc_start_get(adc0) * 400.0) / 128.0 / 10);
		data[0] = (adc_start_get(adc0) & 0xff);
		gabriuart_send("CURR", 1, data);

		avg_sum += data[0];
		avg_cnt++;

		if (avg_cnt >= avg_each_count) {
			start = 0;
			data[start++] = ((avg_sum >> 0x00) & 0xff);
			data[start++] = ((avg_sum >> 0x08) & 0xff);
			data[start++] = ((avg_sum >> 0x16) & 0xff);
			data[start++] = ((avg_sum >> 0x18) & 0xff);
			gabriuart_send("CAVG", 4, data);

			if (avg_sum / (float)avg_cnt > th2.value) {
				pwm_set_dutycycle(pwm0, th2.duty0);
				pwm_set_dutycycle(pwm1, th2.duty1);
			} else if (avg_sum / (float)avg_cnt > th1.value) {
				pwm_set_dutycycle(pwm0, th1.duty0);
				pwm_set_dutycycle(pwm1, th1.duty1);
			} else if (avg_sum / (float)avg_cnt > th0.value) {
				pwm_set_dutycycle(pwm0, th0.duty0);
				pwm_set_dutycycle(pwm1, th0.duty1);
			}

			avg_cnt = 0;
			avg_sum = 0;
		}

		start = alt_timestamp_start();
		while(alt_timestamp() - start < TIMER_INTERVAL(sampling_period_ms, alt_timestamp_freq()));
	} while(1);

	do {
		*(gpio_base_ptr + 0) = 0x0;
		*(gpio_base_ptr + 0) = 0xf;
	} while(1);

	return 0;
}

/*
 *
 * Serial Protocol "gabriuart"
 * Developed by La Greca Salvatore Gabriele (23/12/2020)
 * Current revision: 1.0 (23/12/2020)
 *
 * Comunication Frame details
 *
 * version 1.0
 * STX|CMD|LENGTH|DATA|CHECKSUM|ETX
 *
 *	- CMD: max 4 chars + \0
 *	- LENGTH: max 1 byte
 *	- DATA: data contains "length" bytes
 *	- CHECKSUM: computed on CMD + Data
 *
 */
void _ISR_uart0(void *context, alt_u32 id) {
	static char buffer[1024] = { '\x0' };
	static alt_u8 buffer_post = 0;
	static bool is_stx = false;
	static int i;
	int checksum_val;
	char ch, *ptr;
	bool is_check_ok = false;

	ch = ugetc(uart0);
	buffer[buffer_post++] = ch;
	buffer_post %= 1024;

	if (buffer_post == 6) {
		i = buffer[buffer_post - 1]; // this is the expected length
	} else if (buffer_post > 6) {
		i--; //counting remaining expected data
	}

	is_stx = is_stx || (ch == '\x2');
	if (is_stx && (ch == '\x3' && i == -2)) { // The check on expected data count is done in order to exploit a "\x3" that is a data and not ETX
											  // -2 because after data I expect checksum + ETX
		checksum_val = gabriuart_checksum(gabriuart_cmd2_u32(buffer + 1));
		for (i = 0; i < buffer[5]; i++) {
			checksum_val += gabriuart_checksum((alt_u32)buffer[i + 6] & 0xff);
		}
		checksum_val &= 0x7f;

		//sending ack or nack based on checksum check
		is_check_ok = (checksum_val == (alt_u8)buffer[buffer_post - 2]);
		uprintf(uart0, "\x2%c\x1d\x1d\x1d\x3\r\n", (is_check_ok) ? '\x06' : '\x0f');

		if (is_check_ok) {
			i = gabriuart_cmd2_u32(buffer + 1);
			switch(i) {
			case PING:
				buffer[buffer_post] = ~buffer[i+6];
				gabriuart_send("PONG", 0x1, (alt_u8 *)(buffer + buffer_post));
				break;

			case CSET:
				ptr = buffer + buffer_post - 22;
				sampling_period_ms = (((alt_u32)ptr[0] << 0x00) & 0xff) 	  |
									 (((alt_u32)ptr[1] << 0x08) & 0xff00) 	  |
									 (((alt_u32)ptr[2] << 0x10) & 0xff0000)   |
									 (((alt_u32)ptr[3] << 0x18) & 0xff000000);

				avg_each_count = ptr[4];

				th0.value = ptr[05];
				th1.value = ptr[10];
				th2.value = ptr[15];

				th0.duty0 = (((alt_u32)ptr[6] << 0x00) & 0xff) 	  |
						 	(((alt_u32)ptr[7] << 0x08) & 0xff00);

				th0.duty1 = (((alt_u32)ptr[8] << 0x00) & 0xff) 	  |
						 	(((alt_u32)ptr[9] << 0x08) & 0xff00);

				th1.duty0 = (((alt_u32)ptr[11] << 0x00) & 0xff) 	  |
						 	(((alt_u32)ptr[12] << 0x08) & 0xff00);

				th1.duty1 = (((alt_u32)ptr[13] << 0x00) & 0xff) 	  |
						 	(((alt_u32)ptr[14] << 0x08) & 0xff00);

				th2.duty0 = (((alt_u32)ptr[16] << 0x00) & 0xff) 	  |
						 	(((alt_u32)ptr[17] << 0x08) & 0xff00);

				th2.duty1 = (((alt_u32)ptr[18] << 0x00) & 0xff) 	  |
						 	(((alt_u32)ptr[19] << 0x08) & 0xff00);

				break;

			case CGET:
				i = buffer_post;

				buffer[i++] = ((sampling_period_ms >> 0x00) & 0xff);
				buffer[i++] = ((sampling_period_ms >> 0x08) & 0xff);
				buffer[i++] = ((sampling_period_ms >> 0x16) & 0xff);
				buffer[i++] = ((sampling_period_ms >> 0x18) & 0xff);

				buffer[i++] = (avg_each_count & 0xff);

				buffer[i++] = (th0.value & 0xff);
				buffer[i++] = ((th0.duty0 >> 0x00) & 0xff);
				buffer[i++] = ((th0.duty0 >> 0x08) & 0xff);
				buffer[i++] = ((th0.duty1 >> 0x00) & 0xff);
				buffer[i++] = ((th0.duty1 >> 0x08) & 0xff);

				buffer[i++] = (th1.value & 0xff);
				buffer[i++] = ((th1.duty0 >> 0x00) & 0xff);
				buffer[i++] = ((th1.duty0 >> 0x08) & 0xff);
				buffer[i++] = ((th1.duty1 >> 0x00) & 0xff);
				buffer[i++] = ((th1.duty1 >> 0x08) & 0xff);

				buffer[i++] = (th2.value & 0xff);
				buffer[i++] = ((th2.duty0 >> 0x00) & 0xff);
				buffer[i++] = ((th2.duty0 >> 0x08) & 0xff);
				buffer[i++] = ((th2.duty1 >> 0x00) & 0xff);
				buffer[i++] = ((th2.duty1 >> 0x08) & 0xff);

				gabriuart_send("CSEN", (i - buffer_post), (alt_u8 *)(buffer + buffer_post));
				break;
			}
		}

		buffer_post = 0;
		is_stx = false;
	} else if (!is_stx) {
		while ((((*((int *)UART_0_BASE + 2)) >> 6) & 0x1) != 1);
		*((int *)UART_0_BASE + 1) = (ch & 0xff);

		buffer_post = 0;
	}
}

void gabriuart_send(char *cmd, alt_u8 length, alt_u8 *data) {
	int checksum, i;

	checksum = gabriuart_checksum(gabriuart_cmd2_u32(cmd));
	for (i = 0; i < length; i++) {
		checksum += gabriuart_checksum((alt_u32)data[i] & 0xff);
	}
	checksum &= 0x7f;

	uprintf(uart0, "\x2\%s%c", cmd, length);
	for (i = 0; i < length; i++) {
		uputc(uart0, data[i]);
	}

	uprintf(uart0, "%c\x3\r\n", checksum);
}

/*void _ISR_uart0(void *context, alt_u32 id) {
	static bool is_stx = false;
	static bool is_cmd = false;
	static bool is_length = false;
	static bool is_data = false;
	static bool is_checksum = false;
	static bool is_frame_ready = false;

	static int ch, length;
	static alt_u8 checksum;
	static cmd[gabriuart_cmd_size];

	static char sent_data[gabriuart_data_array_size];
	static int data_pos = 0;

	static int failed_attempts_etx = 0;

	alt_u8 data, i, checksum_val;

	ch = ugetc(uart0);
	if (is_frame_ready) {

		checksum_val = gabriuart_checksum((alt_u32)cmd);
		for (i = 0; i < data_pos; i++) {
			checksum_val += gabriuart_checksum(sent_data[i]);
		}
		checksum_val &= 0x7f;

		//sending ack or nack based on checksum check
		uprintf(uart0, "%c\n", (checksum_val == checksum) ? '\x06' : '\x0f');

		if (strcmp(cmd, "PING")) {
			data = ~sent_data[0];
			uprintf(uart0, "\x02\nPONG\n\1\n%d\n%d\n\x03\n", data, gabriuart_checksum(data));
		}

		data_pos = 0;
	} else if (!is_stx && ch == '\x02') {
		is_stx = true;
	} else if (is_stx) {
		cmd[0] = ch;
		cmd[4] = '\0';
		for (i = 1; i < 4; i++) {
			cmd[i] = ugetc(uart0);
		}

		is_stx = false;
		is_cmd = true;
	} else if (is_cmd) {
		length = ch;

		is_cmd = false;
		is_length = true;
	} else if (is_length) {
		sent_data[data_pos++] = ch;

		is_length = (!(strcmp(cmd, "READ") == 0) || (data_pos >= length));
		is_data = !is_length;
	} else if (is_data) {
		checksum = ch;

		is_data = false;
		is_checksum = true;
	} else if (is_checksum) {
		if (ch == '\x03') {
			is_checksum = false;
			is_frame_ready = true;
		}

		failed_attempts_etx += (ch == '\x03') ? 1 : -failed_attempts_etx;
	} else {
		while ((((*((int *)UART_0_BASE + 2)) >> 6) & 0x1) != 1);
		*((int *)UART_0_BASE + 1) = (ch & 0xff);
	}

	//Ack irq
	*((int *)UART_0_BASE + 2) = 0;
}*/

alt_u8 gabriuart_checksum(alt_u32 crc) {
	crc ^= crc >> 16;
	crc ^= crc >> 8;

	return (alt_u8)crc;
}

alt_u32 gabriuart_cmd2_u32(char *v) {
	return (alt_u32)v[3] << 24 |
		   (alt_u32)v[2] << 16 |
		   (alt_u32)v[1] << 8  |
		   (alt_u32)v[0] << 0;
}
