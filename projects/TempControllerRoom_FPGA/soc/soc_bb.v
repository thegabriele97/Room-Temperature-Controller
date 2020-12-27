
module soc (
	clk_clk,
	core0_cpu_resetrequest_conduit_cpu_resetrequest,
	core0_cpu_resetrequest_conduit_cpu_resettaken,
	gpio_0_external_connection_export,
	gpio_1_adc_external_connection_in_port,
	gpio_1_adc_external_connection_out_port,
	pll_2mhz_clk,
	pll_5khz_clk,
	sdram_clk_clk,
	sdram_controller_0_wire_addr,
	sdram_controller_0_wire_ba,
	sdram_controller_0_wire_cas_n,
	sdram_controller_0_wire_cke,
	sdram_controller_0_wire_cs_n,
	sdram_controller_0_wire_dq,
	sdram_controller_0_wire_dqm,
	sdram_controller_0_wire_ras_n,
	sdram_controller_0_wire_we_n,
	uart_0_external_connection_rxd,
	uart_0_external_connection_txd,
	gpio_2_pwm0_main_external_connection_in_port,
	gpio_2_pwm0_main_external_connection_out_port,
	gpio_2_pwm0_prescaler_external_connection_export,
	gpio_2_pwm1_main_external_connection_in_port,
	gpio_2_pwm1_main_external_connection_out_port,
	gpio_2_pwm1_prescaler_external_connection_export);	

	input		clk_clk;
	input		core0_cpu_resetrequest_conduit_cpu_resetrequest;
	output		core0_cpu_resetrequest_conduit_cpu_resettaken;
	inout	[3:0]	gpio_0_external_connection_export;
	input	[9:0]	gpio_1_adc_external_connection_in_port;
	output	[9:0]	gpio_1_adc_external_connection_out_port;
	output		pll_2mhz_clk;
	output		pll_5khz_clk;
	output		sdram_clk_clk;
	output	[11:0]	sdram_controller_0_wire_addr;
	output	[1:0]	sdram_controller_0_wire_ba;
	output		sdram_controller_0_wire_cas_n;
	output		sdram_controller_0_wire_cke;
	output		sdram_controller_0_wire_cs_n;
	inout	[15:0]	sdram_controller_0_wire_dq;
	output	[1:0]	sdram_controller_0_wire_dqm;
	output		sdram_controller_0_wire_ras_n;
	output		sdram_controller_0_wire_we_n;
	input		uart_0_external_connection_rxd;
	output		uart_0_external_connection_txd;
	input	[13:0]	gpio_2_pwm0_main_external_connection_in_port;
	output	[13:0]	gpio_2_pwm0_main_external_connection_out_port;
	output	[31:0]	gpio_2_pwm0_prescaler_external_connection_export;
	input	[13:0]	gpio_2_pwm1_main_external_connection_in_port;
	output	[13:0]	gpio_2_pwm1_main_external_connection_out_port;
	output	[31:0]	gpio_2_pwm1_prescaler_external_connection_export;
endmodule
