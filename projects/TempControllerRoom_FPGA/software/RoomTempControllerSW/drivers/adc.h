/*
 * adc.h
 *
 *  Created on: 23 Dec 2020
 *      Author: gabri
 */

#ifndef DRIVERS_ADC_H_
#define DRIVERS_ADC_H_

#include "alt_types.h"

typedef struct {
	union {
		struct {
			unsigned soc		: 1;
			unsigned eoc		: 1;
			unsigned reserved0	: 1;
			unsigned adc_value	: 7;
			unsigned reserved1	: 22;
		} fields;
		alt_u32 data;
	} control;

	union {
		struct {
			unsigned soc		: 1;
			unsigned eoc		: 1;
			unsigned reserved0	: 1;
			unsigned data0		: 1;
			unsigned data1		: 1;
			unsigned data2		: 1;
			unsigned data3		: 1;
			unsigned data4		: 1;
			unsigned data5		: 1;
			unsigned data6		: 1;
			unsigned reserved1	: 22;
		} fields;
		alt_u32 reg;
	} direction;
} *adc_t;

adc_t adc_init(int *gpio_adc_base);
void adc_start(adc_t adc);
void adc_stop(adc_t adc);
int adc_get_last(adc_t adc);
int adc_start_get(adc_t adc);

#endif /* DRIVERS_ADC_H_ */
