/*
 * pwm.h
 *
 *  Created on: 26 Dec 2020
 *      Author: gabri
 */

#ifndef DRIVERS_PWM_H_
#define DRIVERS_PWM_H_

#include "alt_types.h"

typedef struct {
	struct {
		union {
			struct {
				unsigned load_prescaler : 1;
				unsigned done_prescaler : 1;
				unsigned load_duty		: 1;
				unsigned done_duty		: 1;
				unsigned duty_cycle		: 10;
				unsigned reserved 		: 18;
			} fields;
			int reg;
		} control;

		int gpio_direction;
	} *pwm_config;

	struct {
		int value;
	} *pwm_prescaler;
} pwm_t;

pwm_t pwm_init(int *pwm_main_base_addr, int *pwm_prescaler_base_addr);
void pwm_set_prescaler(pwm_t pwm, int divisor);
void pwm_set_dutycycle(pwm_t pwm, int dutycycle);

#endif /* DRIVERS_PWM_H_ */
