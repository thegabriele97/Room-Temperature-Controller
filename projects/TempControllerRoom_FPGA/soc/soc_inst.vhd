	component soc is
		port (
			clk_clk                                         : in    std_logic                     := 'X';             -- clk
			core0_cpu_resetrequest_conduit_cpu_resetrequest : in    std_logic                     := 'X';             -- cpu_resetrequest
			core0_cpu_resetrequest_conduit_cpu_resettaken   : out   std_logic;                                        -- cpu_resettaken
			gpio_0_external_connection_export               : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			pll_5khz_clk                                    : out   std_logic;                                        -- clk
			sdram_clk_clk                                   : out   std_logic;                                        -- clk
			sdram_controller_0_wire_addr                    : out   std_logic_vector(11 downto 0);                    -- addr
			sdram_controller_0_wire_ba                      : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_controller_0_wire_cas_n                   : out   std_logic;                                        -- cas_n
			sdram_controller_0_wire_cke                     : out   std_logic;                                        -- cke
			sdram_controller_0_wire_cs_n                    : out   std_logic;                                        -- cs_n
			sdram_controller_0_wire_dq                      : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_controller_0_wire_dqm                     : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_controller_0_wire_ras_n                   : out   std_logic;                                        -- ras_n
			sdram_controller_0_wire_we_n                    : out   std_logic;                                        -- we_n
			uart_0_external_connection_rxd                  : in    std_logic                     := 'X';             -- rxd
			uart_0_external_connection_txd                  : out   std_logic;                                        -- txd
			gpio_1_adc_external_connection_in_port          : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- in_port
			gpio_1_adc_external_connection_out_port         : out   std_logic_vector(9 downto 0)                      -- out_port
		);
	end component soc;

	u0 : component soc
		port map (
			clk_clk                                         => CONNECTED_TO_clk_clk,                                         --                            clk.clk
			core0_cpu_resetrequest_conduit_cpu_resetrequest => CONNECTED_TO_core0_cpu_resetrequest_conduit_cpu_resetrequest, -- core0_cpu_resetrequest_conduit.cpu_resetrequest
			core0_cpu_resetrequest_conduit_cpu_resettaken   => CONNECTED_TO_core0_cpu_resetrequest_conduit_cpu_resettaken,   --                               .cpu_resettaken
			gpio_0_external_connection_export               => CONNECTED_TO_gpio_0_external_connection_export,               --     gpio_0_external_connection.export
			pll_5khz_clk                                    => CONNECTED_TO_pll_5khz_clk,                                    --                       pll_5khz.clk
			sdram_clk_clk                                   => CONNECTED_TO_sdram_clk_clk,                                   --                      sdram_clk.clk
			sdram_controller_0_wire_addr                    => CONNECTED_TO_sdram_controller_0_wire_addr,                    --        sdram_controller_0_wire.addr
			sdram_controller_0_wire_ba                      => CONNECTED_TO_sdram_controller_0_wire_ba,                      --                               .ba
			sdram_controller_0_wire_cas_n                   => CONNECTED_TO_sdram_controller_0_wire_cas_n,                   --                               .cas_n
			sdram_controller_0_wire_cke                     => CONNECTED_TO_sdram_controller_0_wire_cke,                     --                               .cke
			sdram_controller_0_wire_cs_n                    => CONNECTED_TO_sdram_controller_0_wire_cs_n,                    --                               .cs_n
			sdram_controller_0_wire_dq                      => CONNECTED_TO_sdram_controller_0_wire_dq,                      --                               .dq
			sdram_controller_0_wire_dqm                     => CONNECTED_TO_sdram_controller_0_wire_dqm,                     --                               .dqm
			sdram_controller_0_wire_ras_n                   => CONNECTED_TO_sdram_controller_0_wire_ras_n,                   --                               .ras_n
			sdram_controller_0_wire_we_n                    => CONNECTED_TO_sdram_controller_0_wire_we_n,                    --                               .we_n
			uart_0_external_connection_rxd                  => CONNECTED_TO_uart_0_external_connection_rxd,                  --     uart_0_external_connection.rxd
			uart_0_external_connection_txd                  => CONNECTED_TO_uart_0_external_connection_txd,                  --                               .txd
			gpio_1_adc_external_connection_in_port          => CONNECTED_TO_gpio_1_adc_external_connection_in_port,          -- gpio_1_adc_external_connection.in_port
			gpio_1_adc_external_connection_out_port         => CONNECTED_TO_gpio_1_adc_external_connection_out_port          --                               .out_port
		);

