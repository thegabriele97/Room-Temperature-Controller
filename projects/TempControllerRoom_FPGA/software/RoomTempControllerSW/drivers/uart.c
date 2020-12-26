#include <stdio.h>
#include <stdarg.h>
#include "uart.h"
#include "system.h"

uart_t uart_begin(int *base_address, alt_u16 baudrate_divisor) {
	uart_t uart;

	uart = (uart_t)base_address;
	uart->divisor = baudrate_divisor;

	return uart;
}

void uprintf(uart_t uart, const char *template, ...) {
	char buf[BUFSIZE];
	va_list arg_ptr;
	alt_u8 i;

	va_start(arg_ptr, template);
	sprintf(buf, template);

	for (i = 0; buf[i] != '\0'; i++) {
		while (uart->status.fields.trdy != 1);
		uart->txdata = buf[i];
	}

	va_end(arg_ptr);
}

void uputc(uart_t uart, char ch) {
	while (uart->status.fields.trdy != 1);
	uart->txdata = ch;
}

void ugets(char *s, int count, uart_t uart) {
	char ch;
	int i, old_irrdy;

	//Temporary disable of irdy interrupt
	old_irrdy = uart->control.fields.irrdy;
	uart->control.fields.irrdy = 0;

	for (i = 1; i < count && !(ch == '\n' || ch == '\r'); i++) {
		while (uart->status.fields.rrdy != 1);

		ch = (char)uart->rxdata;
		s[i - 1] = ch;
	}

	uart->control.fields.irrdy = old_irrdy;
	s[i - 1] = '\0';
}

int ugetc(uart_t uart) {
	int old_irrdy, ch;

	//Temporary disable of irdy interrupt
	old_irrdy = uart->control.fields.irrdy;
	uart->control.fields.irrdy = 0;

	while (uart->status.fields.rrdy != 1);
	ch = uart->rxdata;

	uart->control.fields.irrdy = old_irrdy;
	return ch;
}

void uart_register_irq(uart_t uart, alt_isr_func isr, void *isr_context) {
	alt_ic_isr_register(UART_0_IRQ_INTERRUPT_CONTROLLER_ID, UART_0_IRQ, isr, isr_context, NULL);
}
