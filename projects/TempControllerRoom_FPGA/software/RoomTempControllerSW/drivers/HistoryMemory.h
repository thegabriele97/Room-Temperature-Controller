/*
 * HistoryMemory.h
 *
 *  Created on: 28 Dec 2020
 *      Author: gabri
 */

#ifndef DRIVERS_HISTORYMEMORY_H_
#define DRIVERS_HISTORYMEMORY_H_

#include "alt_types.h"

#define MEMORY_CLKPERIOD_NS			500		// The frequency is 2MHz, so 0.5 us
#define TIMER50MHZ_EQUIVALENT		25		// At 50 MHz, a Timer should wait to reach 25 to have a 500 ns pause

typedef struct {
	struct {
		union {
			struct {
				unsigned wren 		: 1;
				unsigned wrdata		: 8;
				unsigned wraddr		: 11;
				unsigned reserved	: 12;
			} fields;

			alt_u32 reg;
		} control;
		union {
			struct {
				unsigned wren 		: 1;
				unsigned wrdata		: 8;
				unsigned wraddr		: 11;
				unsigned reserved	: 12;
			} fields;

			alt_u32 reg;
		} gpio_direction;
	} *write_port;

	struct {
		union {
			struct {
				unsigned rden 		: 1;
				unsigned rddata		: 8;
				unsigned rdaddr		: 11;
				unsigned reserved	: 12;
			} fields;

			alt_u32 reg;
		} control;

		union {
			struct {
				unsigned rden 		: 1;
				unsigned rddata		: 8;
				unsigned rdaddr		: 11;
				unsigned reserved	: 12;
			} fields;

			alt_u32 reg;
		} gpio_direction;
	} *read_port;
} historymem_t;

historymem_t historymem_init(int *gpio_wrport_addr, int *gpio_rdport_addr);
void historymem_write(historymem_t history, alt_u16 address, alt_u8 data);
alt_u8 historymem_wr_check(historymem_t history, alt_u16 address, alt_u8 data);
alt_u8 historymem_read(historymem_t history, alt_u16 address);

#endif /* DRIVERS_HISTORYMEMORY_H_ */
