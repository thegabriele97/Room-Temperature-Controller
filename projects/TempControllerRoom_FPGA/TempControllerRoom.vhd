library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TempControllerRoom is
	port(
		clk_in								: in std_logic;
		rst_n									: in std_logic;
		
		beep									: out std_logic;
		
		--ADC/SAR Converter
		comp_in								: in std_logic;
		DAC_data								: out std_logic_vector(6 downto 0);
		
		--SDRAM
		sdram_clk                 		: out   std_logic;                                        
		sdram_addr                    : out   std_logic_vector(11 downto 0);
		sdram_ba                      : out   std_logic_vector(1 downto 0);
		sdram_cas_n                   : out   std_logic;
		sdram_cke                     : out   std_logic;
		sdram_cs_n                    : out   std_logic;
		sdram_dq                      : inout std_logic_vector(15 downto 0) := (others => 'X');
		sdram_dqm                     : out   std_logic_vector(1 downto 0);
		sdram_ras_n                   : out   std_logic;
		sdram_we_n                    : out   std_logic;
		
		--UART0
		uart0_rx								: in std_logic;
		uart0_tx								: out std_logic;
		
		--PWM
		pwm0									: out std_logic;
		pwm1									: out std_logic;
		
		--Temporary GPIO0
		gpio0									: inout std_logic_vector(3 downto 0)
		
	);
end entity;

architecture mixture of TempControllerRoom is

	component SAR is
		generic(
			nbits			: integer := 2;
			reg_siz		: integer := 2
		);
		
		port(
			clk			: in std_logic;
			rst			: in std_logic;
			
			--Start of conversion
			soc			: in std_logic;
			
			--End of conversion
			eoc			: out std_logic;
			
			--Comparator input
			comp_in		: in std_logic;
			
			--Data output: last conversion
			data			: out std_logic_vector((nbits-1) downto 0);
			
			--Data output: to DAC
			DAC_data		: out std_logic_vector((nbits-1) downto 0)
			
		);
	end component;
	
	component pwm is
		 generic(
			  nbits_pwm, nbits_divisor: integer
		 );    
		 port(
			  clk, rst: in std_logic;
			  
			  divisor: in std_logic_vector((nbits_divisor-1) downto 0);
			  ld_divisor: in std_logic;
			  done_divisor: out std_logic;
			  
			  duty: in std_logic_vector((nbits_pwm-1) downto 0);
			  ld_duty: in std_logic;
			  done_duty: out std_logic;
			  
			  pwm_out: out std_logic
		 );
	end component;

    component soc is
        port (
            pll_5khz_clk                                    : out   std_logic;                                        -- clk
            pll_2mhz_clk                                    : out   std_logic;
				clk_clk                                         : in    std_logic                     := 'X';             -- clk
            sdram_clk_clk                                   : out   std_logic;                                        -- clk
            core0_cpu_resetrequest_conduit_cpu_resetrequest : in    std_logic                     := 'X';             -- cpu_resetrequest
            core0_cpu_resetrequest_conduit_cpu_resettaken   : out   std_logic;                                        -- cpu_resettaken
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
            gpio_0_external_connection_export               : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- export
				gpio_1_adc_external_connection_in_port          : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- in_port
            gpio_1_adc_external_connection_out_port         : out   std_logic_vector(9 downto 0);                     -- out_port
				gpio_2_pwm0_main_external_connection_in_port     : in    std_logic_vector(13 downto 0) := (others => 'X'); -- in_port
            gpio_2_pwm0_main_external_connection_out_port    : out   std_logic_vector(13 downto 0);                    -- out_port
            gpio_2_pwm0_prescaler_external_connection_export : out   std_logic_vector(31 downto 0);                    -- export
            gpio_2_pwm1_main_external_connection_in_port     : in    std_logic_vector(13 downto 0) := (others => 'X'); -- in_port
            gpio_2_pwm1_main_external_connection_out_port    : out   std_logic_vector(13 downto 0);                    -- out_port
            gpio_2_pwm1_prescaler_external_connection_export : out   std_logic_vector(31 downto 0)                     -- export
		  );
    end component soc;

	for ADC0: SAR use entity work.SAR(hlsm2);
	
	 
	signal clk_1hz, clk_5khz, clk_2mhz: std_logic;
	signal rst: std_logic;
	
	signal igpio0: std_logic_vector(3 downto 0);
	signal igpio1_adc_in, igpio1_adc_out: std_logic_vector(9 downto 0);		-- 	 0: soc
																									-- 	 1: eoc
																									-- 	 2: reserved
																									-- [3-9]: ADC data
	
	signal igpio2_pwm0_main_in, igpio2_pwm0_main_out, igpio2_pwm1_main_in, igpio2_pwm1_main_out: std_logic_vector(13 downto 0);
	signal igpio2_pwm0_prescaler, igpio2_pwm1_prescaler: std_logic_vector(31 downto 0);
	
	signal curr_cnt, next_cnt: std_logic_vector(31 downto 0);
	
	signal done_div, done_d: std_logic;
	
begin

    u0 : component soc
        port map (
            pll_5khz_clk                                    => clk_5khz,
				pll_2mhz_clk                                    => clk_2mhz,
            clk_clk                                         => clk_in,
            sdram_clk_clk                                   => sdram_clk,
            
				core0_cpu_resetrequest_conduit_cpu_resetrequest => rst,
            core0_cpu_resetrequest_conduit_cpu_resettaken   => beep,
            
				sdram_controller_0_wire_addr                    => sdram_addr,
            sdram_controller_0_wire_ba                      => sdram_ba,
            sdram_controller_0_wire_cas_n                   => sdram_cas_n,
            sdram_controller_0_wire_cke                     => sdram_cke,
            sdram_controller_0_wire_cs_n                    => sdram_cs_n,
            sdram_controller_0_wire_dq                      => sdram_dq,
            sdram_controller_0_wire_dqm                     => sdram_dqm,
            sdram_controller_0_wire_ras_n                   => sdram_ras_n,
            sdram_controller_0_wire_we_n                    => sdram_we_n,
            
				uart_0_external_connection_rxd                  => uart0_rx,
            uart_0_external_connection_txd                  => uart0_tx,
            
				gpio_0_external_connection_export               => igpio0,
				gpio_1_adc_external_connection_in_port          => igpio1_adc_in,
            gpio_1_adc_external_connection_out_port         => igpio1_adc_out,
				
				gpio_2_pwm0_main_external_connection_in_port    => igpio2_pwm0_main_in,
            gpio_2_pwm0_main_external_connection_out_port   => igpio2_pwm0_main_out,
            gpio_2_pwm0_prescaler_external_connection_export => igpio2_pwm0_prescaler,
            gpio_2_pwm1_main_external_connection_in_port    => igpio2_pwm1_main_in,
            gpio_2_pwm1_main_external_connection_out_port   => igpio2_pwm1_main_out,
            gpio_2_pwm1_prescaler_external_connection_export => igpio2_pwm1_prescaler
        );

	ADC0:	SAR generic map(7, 3) 
			port map(
				clk => clk_1hz,
				rst => rst,
				soc=> igpio1_adc_out(0),
				eoc => igpio1_adc_in(1),
				comp_in => comp_in,
				data => igpio1_adc_in(9 downto 3),
				dac_data => DAC_data
			);
			
	PWM0_dev: pwm generic map(10, 32)
			port map(
				clk => clk_2mhz,
				rst => rst,
				divisor => x"00000001",
				ld_divisor => '0',
				done_divisor => done_div,
				duty => igpio2_pwm0_main_out(13 downto 4),
				ld_duty => igpio2_pwm0_main_out(2),
				done_duty => igpio2_pwm0_main_in(3),
				pwm_out => pwm0
			);

	PWM1_dev: pwm generic map(10, 32)
			port map(
				clk => clk_2mhz,
				rst => rst,
				divisor => x"00000001",
				ld_divisor => '0',
				done_divisor => done_div,
				duty => igpio2_pwm1_main_out(13 downto 4),
				ld_duty => igpio2_pwm1_main_out(2),
				done_duty => igpio2_pwm1_main_in(3),
				pwm_out => pwm1
			);
		
	rst <= not rst_n;
	gpio0 <= not igpio0;
	
	next_cnt <= (others => '0') when (unsigned(curr_cnt) = 1) else
					std_logic_vector(unsigned(curr_cnt) + 1);
	
	clk_1hz <= '1' when (unsigned(curr_cnt) = 1) else '0';
	
	process(clk_5khz, rst)
	begin
	
		if (rst = '1') then
			curr_cnt <= (others => '0');
		elsif (rising_edge(clk_5khz)) then
			curr_cnt <= next_cnt;
		end if;
	
	end process;

end mixture;
