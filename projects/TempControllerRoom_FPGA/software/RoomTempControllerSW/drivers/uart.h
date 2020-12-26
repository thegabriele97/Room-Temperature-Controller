/*
 * uart.h
 *
 *  Created on: 23 Dec 2020
 *      Author: gabri
 */

#ifndef DRIVERS_UART_H_
#define DRIVERS_UART_H_

#include "alt_types.h"
#include "sys/alt_irq.h"

#define BUFSIZE 				0x800

#define BR_CALC(freq, br)		((freq/br) - 1)

typedef struct {
	alt_u32 rxdata;
	alt_u32 txdata;

	union {
		struct {
			unsigned pe	  	  : 1;
			unsigned fe	  	  : 1;
			unsigned brk  	  : 1;
			unsigned roe  	  : 1;
			unsigned toe      : 1;
			unsigned tmt      : 1;
			unsigned trdy     : 1;
			unsigned rrdy     : 1;
			unsigned e	      : 1;
			unsigned dw	      : 1;
			unsigned dcts 	  : 1;
			unsigned cts  	  : 1;
			unsigned eop  	  : 1;
			unsigned reserved : 19;
		} fields;
		alt_u32 reg;
	} status;

	union {
		struct {
			unsigned ipe	  : 1;
			unsigned ife	  : 1;
			unsigned ibrk  	  : 1;
			unsigned iroe  	  : 1;
			unsigned itoe     : 1;
			unsigned itmt     : 1;
			unsigned itrdy    : 1;
			unsigned irrdy    : 1;
			unsigned ie	      : 1;
			unsigned trbk     : 1;
			unsigned idcts 	  : 1;
			unsigned rts      : 1;
			unsigned ieop  	  : 1;
			unsigned reserved : 19;
		} fields;
		alt_u32 reg;
	} control;

	alt_u32 divisor;
	alt_u32 eop;
} *uart_t;

uart_t uart_begin(int *base_address, alt_u16 baudrate_divisor);
void uprintf(uart_t uart, const char *template, ...);
void uputc(uart_t uart, char ch);
void ugets(char *s, int count, uart_t uart);
int ugetc(uart_t uart);
void uart_register_irq(uart_t uart, alt_isr_func isr, void *isr_context);

#endif /* DRIVERS_UART_H_ */
