#include "HistoryMemory.h"
#include "sys/alt_timestamp.h"

historymem_t historymem_init(int *gpio_wrport_addr, int *gpio_rdport_addr) {
	historymem_t mem;

	mem.write_port = gpio_wrport_addr;
	mem.read_port = gpio_rdport_addr;

	mem.read_port->gpio_direction.fields.rdaddr = 0x7ff;
	mem.read_port->gpio_direction.fields.rddata = 0x000;

	return mem;
}

void historymem_write(historymem_t history, alt_u16 address, alt_u8 data) {
	int start;

	history.write_port->control.fields.wraddr = address;
	history.write_port->control.fields.wrdata = data;

	start = alt_timestamp_start();
	while(alt_timestamp() - start < TIMER50MHZ_EQUIVALENT);		// Waiting for a memory's clock period

	history.write_port->control.fields.wren = 1;
	start = alt_timestamp_start();
	while(alt_timestamp() - start < TIMER50MHZ_EQUIVALENT);		// Waiting for a memory's clock period

	history.write_port->control.fields.wren = 0;
}

alt_u8 historymem_wr_check(historymem_t history, alt_u16 address, alt_u8 data) {
	historymem_write(history, address, data);
	return (address == historymem_read(history, address));
}

alt_u8 historymem_read(historymem_t history, alt_u16 address) {
	int start;

	history.read_port->control.fields.rdaddr = address;

	start = alt_timestamp_start();
	while(alt_timestamp() - start < TIMER50MHZ_EQUIVALENT);		// Waiting for a memory's clock period

	return history.read_port->control.fields.rddata;
}
