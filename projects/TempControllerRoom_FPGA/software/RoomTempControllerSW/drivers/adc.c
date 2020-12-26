#include "adc.h"
#include "system.h"

adc_t adc_init(int *gpio_adc_base) {
	adc_t adc;

	adc = (adc_t)gpio_adc_base;
	adc->direction.reg |= 0x1;
	adc->direction.reg &= ~0x3fa;
	adc->control.fields.soc = 0;

	return adc;
}

void adc_start(adc_t adc) {
	adc->control.fields.soc = 1;
}

void adc_stop(adc_t adc) {
	adc->control.fields.soc = 0;
}

int adc_get_last(adc_t adc) {
	return adc->control.fields.adc_value;
}

int adc_start_get(adc_t adc) {

	adc_start(adc);
	while(adc->control.fields.eoc != 1);

	adc_stop(adc);
	while(adc->control.fields.eoc == 1);

	return adc_get_last(adc);
}
