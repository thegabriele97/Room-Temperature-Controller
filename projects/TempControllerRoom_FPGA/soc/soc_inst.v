	soc u0 (
		.clk_clk                                          (<connected-to-clk_clk>),                                          //                                       clk.clk
		.core0_cpu_resetrequest_conduit_cpu_resetrequest  (<connected-to-core0_cpu_resetrequest_conduit_cpu_resetrequest>),  //            core0_cpu_resetrequest_conduit.cpu_resetrequest
		.core0_cpu_resetrequest_conduit_cpu_resettaken    (<connected-to-core0_cpu_resetrequest_conduit_cpu_resettaken>),    //                                          .cpu_resettaken
		.gpio_0_external_connection_export                (<connected-to-gpio_0_external_connection_export>),                //                gpio_0_external_connection.export
		.gpio_1_adc_external_connection_in_port           (<connected-to-gpio_1_adc_external_connection_in_port>),           //            gpio_1_adc_external_connection.in_port
		.gpio_1_adc_external_connection_out_port          (<connected-to-gpio_1_adc_external_connection_out_port>),          //                                          .out_port
		.gpio_2_pwm0_main_external_connection_in_port     (<connected-to-gpio_2_pwm0_main_external_connection_in_port>),     //      gpio_2_pwm0_main_external_connection.in_port
		.gpio_2_pwm0_main_external_connection_out_port    (<connected-to-gpio_2_pwm0_main_external_connection_out_port>),    //                                          .out_port
		.gpio_2_pwm0_prescaler_external_connection_export (<connected-to-gpio_2_pwm0_prescaler_external_connection_export>), // gpio_2_pwm0_prescaler_external_connection.export
		.gpio_2_pwm1_main_external_connection_in_port     (<connected-to-gpio_2_pwm1_main_external_connection_in_port>),     //      gpio_2_pwm1_main_external_connection.in_port
		.gpio_2_pwm1_main_external_connection_out_port    (<connected-to-gpio_2_pwm1_main_external_connection_out_port>),    //                                          .out_port
		.gpio_2_pwm1_prescaler_external_connection_export (<connected-to-gpio_2_pwm1_prescaler_external_connection_export>), // gpio_2_pwm1_prescaler_external_connection.export
		.gpio_3_mem_readport_external_connection_in_port  (<connected-to-gpio_3_mem_readport_external_connection_in_port>),  //   gpio_3_mem_readport_external_connection.in_port
		.gpio_3_mem_readport_external_connection_out_port (<connected-to-gpio_3_mem_readport_external_connection_out_port>), //                                          .out_port
		.gpio_3_mem_writeport_external_connection_export  (<connected-to-gpio_3_mem_writeport_external_connection_export>),  //  gpio_3_mem_writeport_external_connection.export
		.pll_2mhz_clk                                     (<connected-to-pll_2mhz_clk>),                                     //                                  pll_2mhz.clk
		.pll_5khz_clk                                     (<connected-to-pll_5khz_clk>),                                     //                                  pll_5khz.clk
		.sdram_clk_clk                                    (<connected-to-sdram_clk_clk>),                                    //                                 sdram_clk.clk
		.sdram_controller_0_wire_addr                     (<connected-to-sdram_controller_0_wire_addr>),                     //                   sdram_controller_0_wire.addr
		.sdram_controller_0_wire_ba                       (<connected-to-sdram_controller_0_wire_ba>),                       //                                          .ba
		.sdram_controller_0_wire_cas_n                    (<connected-to-sdram_controller_0_wire_cas_n>),                    //                                          .cas_n
		.sdram_controller_0_wire_cke                      (<connected-to-sdram_controller_0_wire_cke>),                      //                                          .cke
		.sdram_controller_0_wire_cs_n                     (<connected-to-sdram_controller_0_wire_cs_n>),                     //                                          .cs_n
		.sdram_controller_0_wire_dq                       (<connected-to-sdram_controller_0_wire_dq>),                       //                                          .dq
		.sdram_controller_0_wire_dqm                      (<connected-to-sdram_controller_0_wire_dqm>),                      //                                          .dqm
		.sdram_controller_0_wire_ras_n                    (<connected-to-sdram_controller_0_wire_ras_n>),                    //                                          .ras_n
		.sdram_controller_0_wire_we_n                     (<connected-to-sdram_controller_0_wire_we_n>),                     //                                          .we_n
		.uart_0_external_connection_rxd                   (<connected-to-uart_0_external_connection_rxd>),                   //                uart_0_external_connection.rxd
		.uart_0_external_connection_txd                   (<connected-to-uart_0_external_connection_txd>)                    //                                          .txd
	);

