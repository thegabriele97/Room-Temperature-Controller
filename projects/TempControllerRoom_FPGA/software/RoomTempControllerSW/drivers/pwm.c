#include "pwm.h"
#include "alt_types.h"

pwm_t pwm_init(int *pwm_main_base_addr, int *pwm_prescaler_base_addr) {
	pwm_t pwm;

	pwm.pwm_config = pwm_main_base_addr;
	pwm.pwm_prescaler = pwm_prescaler_base_addr;

	pwm.pwm_config->gpio_direction = 0x3ff5; //bit 0, 2, [4, 13] as output
	pwm.pwm_config->gpio_direction &= ~0xa; //bit 1, 3 as input

	//pwm_set_prescaler(pwm, 0x1); //Setting default prescaler at 1 -> 2 MHz clock, 1 KHz PWM

	return pwm;
}

void pwm_set_prescaler(pwm_t pwm, int divisor) {
	pwm.pwm_prescaler = 1;

	pwm.pwm_config->control.fields.load_prescaler = 1;
	while(pwm.pwm_config->control.fields.done_prescaler != 1);
	pwm.pwm_config->control.fields.load_prescaler = 0;
}

void pwm_set_dutycycle(pwm_t pwm, int dutycycle) {
	pwm.pwm_config->control.reg = (dutycycle << 4) | (1 << 2);
	while(pwm.pwm_config->control.fields.done_duty != 0);
	while(pwm.pwm_config->control.fields.done_duty != 1);
	//pwm.pwm_config->control.fields.load_duty = 0;
}
