-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "12/22/2020 17:27:35"

-- 
-- Device: Altera EP4CE6E22C8 Package TQFP144
-- 

-- 
-- This VHDL file should be used for ModelSim (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	TempControllerRoom IS
    PORT (
	clk_in : IN std_logic;
	rst_n : IN std_logic;
	beep : OUT std_logic;
	soc_n : IN std_logic;
	comp_in : IN std_logic;
	DAC_data : OUT std_logic_vector(6 DOWNTO 0)
	);
END TempControllerRoom;

-- Design Ports Information
-- beep	=>  Location: PIN_110,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- DAC_data[0]	=>  Location: PIN_128,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- DAC_data[1]	=>  Location: PIN_121,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- DAC_data[2]	=>  Location: PIN_125,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- DAC_data[3]	=>  Location: PIN_129,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- DAC_data[4]	=>  Location: PIN_132,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- DAC_data[5]	=>  Location: PIN_126,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- DAC_data[6]	=>  Location: PIN_124,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- comp_in	=>  Location: PIN_127,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- rst_n	=>  Location: PIN_25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- soc_n	=>  Location: PIN_88,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- clk_in	=>  Location: PIN_23,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF TempControllerRoom IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk_in : std_logic;
SIGNAL ww_rst_n : std_logic;
SIGNAL ww_beep : std_logic;
SIGNAL ww_soc_n : std_logic;
SIGNAL ww_comp_in : std_logic;
SIGNAL ww_DAC_data : std_logic_vector(6 DOWNTO 0);
SIGNAL \u0|altpll_0|sd1|pll7_INCLK_bus\ : std_logic_vector(1 DOWNTO 0);
SIGNAL \u0|altpll_0|sd1|pll7_CLK_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \rtl~0clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \rst_n~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~ALTERA_ASDO_DATA1~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_ASDO_DATA1~~padout\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_FLASH_nCE_nCSO~~padout\ : std_logic;
SIGNAL \~ALTERA_DCLK~~padout\ : std_logic;
SIGNAL \~ALTERA_DATA0~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_DATA0~~padout\ : std_logic;
SIGNAL \~ALTERA_nCEO~~padout\ : std_logic;
SIGNAL \~ALTERA_DCLK~~obuf_o\ : std_logic;
SIGNAL \~ALTERA_nCEO~~obuf_o\ : std_logic;
SIGNAL \clk_in~input_o\ : std_logic;
SIGNAL \u0|altpll_0|sd1|wire_pll7_fbout\ : std_logic;
SIGNAL \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\ : std_logic;
SIGNAL \curr_cnt[0]~32_combout\ : std_logic;
SIGNAL \rst_n~input_o\ : std_logic;
SIGNAL \rst_n~inputclkctrl_outclk\ : std_logic;
SIGNAL \curr_cnt[0]~33\ : std_logic;
SIGNAL \curr_cnt[1]~34_combout\ : std_logic;
SIGNAL \curr_cnt[1]~35\ : std_logic;
SIGNAL \curr_cnt[2]~36_combout\ : std_logic;
SIGNAL \curr_cnt[2]~37\ : std_logic;
SIGNAL \curr_cnt[3]~38_combout\ : std_logic;
SIGNAL \curr_cnt[3]~39\ : std_logic;
SIGNAL \curr_cnt[4]~40_combout\ : std_logic;
SIGNAL \curr_cnt[4]~41\ : std_logic;
SIGNAL \curr_cnt[5]~42_combout\ : std_logic;
SIGNAL \curr_cnt[5]~43\ : std_logic;
SIGNAL \curr_cnt[6]~44_combout\ : std_logic;
SIGNAL \curr_cnt[6]~45\ : std_logic;
SIGNAL \curr_cnt[7]~46_combout\ : std_logic;
SIGNAL \Equal0~1_combout\ : std_logic;
SIGNAL \curr_cnt[7]~47\ : std_logic;
SIGNAL \curr_cnt[8]~48_combout\ : std_logic;
SIGNAL \curr_cnt[8]~49\ : std_logic;
SIGNAL \curr_cnt[9]~50_combout\ : std_logic;
SIGNAL \curr_cnt[9]~51\ : std_logic;
SIGNAL \curr_cnt[10]~52_combout\ : std_logic;
SIGNAL \curr_cnt[10]~53\ : std_logic;
SIGNAL \curr_cnt[11]~54_combout\ : std_logic;
SIGNAL \curr_cnt[11]~55\ : std_logic;
SIGNAL \curr_cnt[12]~56_combout\ : std_logic;
SIGNAL \curr_cnt[12]~57\ : std_logic;
SIGNAL \curr_cnt[13]~58_combout\ : std_logic;
SIGNAL \curr_cnt[13]~59\ : std_logic;
SIGNAL \curr_cnt[14]~60_combout\ : std_logic;
SIGNAL \curr_cnt[14]~61\ : std_logic;
SIGNAL \curr_cnt[15]~62_combout\ : std_logic;
SIGNAL \Equal0~3_combout\ : std_logic;
SIGNAL \Equal0~2_combout\ : std_logic;
SIGNAL \Equal0~0_combout\ : std_logic;
SIGNAL \Equal0~4_combout\ : std_logic;
SIGNAL \curr_cnt[15]~63\ : std_logic;
SIGNAL \curr_cnt[16]~64_combout\ : std_logic;
SIGNAL \curr_cnt[16]~65\ : std_logic;
SIGNAL \curr_cnt[17]~66_combout\ : std_logic;
SIGNAL \curr_cnt[17]~67\ : std_logic;
SIGNAL \curr_cnt[18]~68_combout\ : std_logic;
SIGNAL \curr_cnt[18]~69\ : std_logic;
SIGNAL \curr_cnt[19]~70_combout\ : std_logic;
SIGNAL \curr_cnt[19]~71\ : std_logic;
SIGNAL \curr_cnt[20]~72_combout\ : std_logic;
SIGNAL \curr_cnt[20]~73\ : std_logic;
SIGNAL \curr_cnt[21]~74_combout\ : std_logic;
SIGNAL \curr_cnt[21]~75\ : std_logic;
SIGNAL \curr_cnt[22]~76_combout\ : std_logic;
SIGNAL \curr_cnt[22]~77\ : std_logic;
SIGNAL \curr_cnt[23]~78_combout\ : std_logic;
SIGNAL \curr_cnt[23]~79\ : std_logic;
SIGNAL \curr_cnt[24]~80_combout\ : std_logic;
SIGNAL \curr_cnt[24]~81\ : std_logic;
SIGNAL \curr_cnt[25]~82_combout\ : std_logic;
SIGNAL \curr_cnt[25]~83\ : std_logic;
SIGNAL \curr_cnt[26]~84_combout\ : std_logic;
SIGNAL \curr_cnt[26]~85\ : std_logic;
SIGNAL \curr_cnt[27]~86_combout\ : std_logic;
SIGNAL \Equal0~8_combout\ : std_logic;
SIGNAL \Equal0~5_combout\ : std_logic;
SIGNAL \Equal0~6_combout\ : std_logic;
SIGNAL \Equal0~7_combout\ : std_logic;
SIGNAL \curr_cnt[27]~87\ : std_logic;
SIGNAL \curr_cnt[28]~88_combout\ : std_logic;
SIGNAL \curr_cnt[28]~89\ : std_logic;
SIGNAL \curr_cnt[29]~90_combout\ : std_logic;
SIGNAL \curr_cnt[29]~91\ : std_logic;
SIGNAL \curr_cnt[30]~92_combout\ : std_logic;
SIGNAL \curr_cnt[30]~93\ : std_logic;
SIGNAL \curr_cnt[31]~94_combout\ : std_logic;
SIGNAL \Equal0~9_combout\ : std_logic;
SIGNAL \rtl~0_combout\ : std_logic;
SIGNAL \rtl~0clkctrl_outclk\ : std_logic;
SIGNAL \comp_in~input_o\ : std_logic;
SIGNAL \soc_n~input_o\ : std_logic;
SIGNAL \ADC0|curr_state.wait_soc~0_combout\ : std_logic;
SIGNAL \ADC0|curr_state.wait_soc~1_combout\ : std_logic;
SIGNAL \ADC0|curr_state.wait_soc~q\ : std_logic;
SIGNAL \ADC0|Decoder0~0_combout\ : std_logic;
SIGNAL \ADC0|Selector11~0_combout\ : std_logic;
SIGNAL \ADC0|curr_state.try_1~q\ : std_logic;
SIGNAL \ADC0|Selector2~0_combout\ : std_logic;
SIGNAL \ADC0|Add0~1_combout\ : std_logic;
SIGNAL \ADC0|next_iter~0_combout\ : std_logic;
SIGNAL \ADC0|Add0~0_combout\ : std_logic;
SIGNAL \ADC0|Selector13~0_combout\ : std_logic;
SIGNAL \ADC0|curr_state.done~q\ : std_logic;
SIGNAL \ADC0|Selector12~0_combout\ : std_logic;
SIGNAL \ADC0|curr_state.confirm_bit~q\ : std_logic;
SIGNAL \ADC0|Selector8~0_combout\ : std_logic;
SIGNAL \ADC0|Selector9~0_combout\ : std_logic;
SIGNAL \ADC0|Selector9~1_combout\ : std_logic;
SIGNAL \ADC0|Selector8~2_combout\ : std_logic;
SIGNAL \ADC0|Selector8~1_combout\ : std_logic;
SIGNAL \ADC0|Selector8~3_combout\ : std_logic;
SIGNAL \ADC0|Selector7~1_combout\ : std_logic;
SIGNAL \ADC0|Selector7~0_combout\ : std_logic;
SIGNAL \ADC0|Selector7~2_combout\ : std_logic;
SIGNAL \ADC0|Selector6~1_combout\ : std_logic;
SIGNAL \ADC0|Selector6~0_combout\ : std_logic;
SIGNAL \ADC0|Selector6~2_combout\ : std_logic;
SIGNAL \ADC0|Selector5~1_combout\ : std_logic;
SIGNAL \ADC0|Selector5~0_combout\ : std_logic;
SIGNAL \ADC0|Selector5~2_combout\ : std_logic;
SIGNAL \ADC0|Selector4~1_combout\ : std_logic;
SIGNAL \ADC0|Selector4~0_combout\ : std_logic;
SIGNAL \ADC0|Selector4~2_combout\ : std_logic;
SIGNAL \ADC0|Selector3~1_combout\ : std_logic;
SIGNAL \ADC0|Selector3~0_combout\ : std_logic;
SIGNAL \ADC0|Selector3~2_combout\ : std_logic;
SIGNAL curr_cnt : std_logic_vector(31 DOWNTO 0);
SIGNAL \ADC0|curr_iter\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \u0|altpll_0|sd1|wire_pll7_clk\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ADC0|curr_dac\ : std_logic_vector(6 DOWNTO 0);
SIGNAL \ADC0|ALT_INV_curr_state.confirm_bit~q\ : std_logic;

BEGIN

ww_clk_in <= clk_in;
ww_rst_n <= rst_n;
beep <= ww_beep;
ww_soc_n <= soc_n;
ww_comp_in <= comp_in;
DAC_data <= ww_DAC_data;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\u0|altpll_0|sd1|pll7_INCLK_bus\ <= (gnd & \clk_in~input_o\);

\u0|altpll_0|sd1|wire_pll7_clk\(0) <= \u0|altpll_0|sd1|pll7_CLK_bus\(0);
\u0|altpll_0|sd1|wire_pll7_clk\(1) <= \u0|altpll_0|sd1|pll7_CLK_bus\(1);
\u0|altpll_0|sd1|wire_pll7_clk\(2) <= \u0|altpll_0|sd1|pll7_CLK_bus\(2);
\u0|altpll_0|sd1|wire_pll7_clk\(3) <= \u0|altpll_0|sd1|pll7_CLK_bus\(3);
\u0|altpll_0|sd1|wire_pll7_clk\(4) <= \u0|altpll_0|sd1|pll7_CLK_bus\(4);

\rtl~0clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \rtl~0_combout\);

\rst_n~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \rst_n~input_o\);

\u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \u0|altpll_0|sd1|wire_pll7_clk\(0));
\ADC0|ALT_INV_curr_state.confirm_bit~q\ <= NOT \ADC0|curr_state.confirm_bit~q\;

-- Location: IOOBUF_X30_Y24_N2
\beep~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \rtl~0_combout\,
	devoe => ww_devoe,
	o => ww_beep);

-- Location: IOOBUF_X16_Y24_N16
\DAC_data[0]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ADC0|curr_dac\(0),
	devoe => ww_devoe,
	o => ww_DAC_data(0));

-- Location: IOOBUF_X23_Y24_N16
\DAC_data[1]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ADC0|curr_dac\(1),
	devoe => ww_devoe,
	o => ww_DAC_data(1));

-- Location: IOOBUF_X18_Y24_N23
\DAC_data[2]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ADC0|curr_dac\(2),
	devoe => ww_devoe,
	o => ww_DAC_data(2));

-- Location: IOOBUF_X16_Y24_N23
\DAC_data[3]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ADC0|curr_dac\(3),
	devoe => ww_devoe,
	o => ww_DAC_data(3));

-- Location: IOOBUF_X13_Y24_N16
\DAC_data[4]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ADC0|curr_dac\(4),
	devoe => ww_devoe,
	o => ww_DAC_data(4));

-- Location: IOOBUF_X16_Y24_N2
\DAC_data[5]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ADC0|curr_dac\(5),
	devoe => ww_devoe,
	o => ww_DAC_data(5));

-- Location: IOOBUF_X18_Y24_N16
\DAC_data[6]~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ADC0|curr_dac\(6),
	devoe => ww_devoe,
	o => ww_DAC_data(6));

-- Location: IOIBUF_X0_Y11_N8
\clk_in~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_in,
	o => \clk_in~input_o\);

-- Location: PLL_1
\u0|altpll_0|sd1|pll7\ : cycloneive_pll
-- pragma translate_off
GENERIC MAP (
	auto_settings => "false",
	bandwidth_type => "medium",
	c0_high => 120,
	c0_initial => 1,
	c0_low => 120,
	c0_mode => "even",
	c0_ph => 0,
	c1_high => 250,
	c1_initial => 1,
	c1_low => 250,
	c1_mode => "even",
	c1_ph => 0,
	c1_use_casc_in => "on",
	c2_high => 0,
	c2_initial => 0,
	c2_low => 0,
	c2_mode => "bypass",
	c2_ph => 0,
	c2_use_casc_in => "off",
	c3_high => 0,
	c3_initial => 0,
	c3_low => 0,
	c3_mode => "bypass",
	c3_ph => 0,
	c3_use_casc_in => "off",
	c4_high => 0,
	c4_initial => 0,
	c4_low => 0,
	c4_mode => "bypass",
	c4_ph => 0,
	c4_use_casc_in => "off",
	charge_pump_current_bits => 1,
	clk0_counter => "c1",
	clk0_divide_by => 10000,
	clk0_duty_cycle => 50,
	clk0_multiply_by => 1,
	clk0_phase_shift => "0",
	clk1_counter => "unused",
	clk1_divide_by => 0,
	clk1_duty_cycle => 50,
	clk1_multiply_by => 0,
	clk1_phase_shift => "0",
	clk2_counter => "unused",
	clk2_divide_by => 0,
	clk2_duty_cycle => 50,
	clk2_multiply_by => 0,
	clk2_phase_shift => "0",
	clk3_counter => "unused",
	clk3_divide_by => 0,
	clk3_duty_cycle => 50,
	clk3_multiply_by => 0,
	clk3_phase_shift => "0",
	clk4_counter => "unused",
	clk4_divide_by => 0,
	clk4_duty_cycle => 50,
	clk4_multiply_by => 0,
	clk4_phase_shift => "0",
	compensate_clock => "clock0",
	inclk0_input_frequency => 20000,
	inclk1_input_frequency => 0,
	loop_filter_c_bits => 0,
	loop_filter_r_bits => 27,
	m => 12,
	m_initial => 1,
	m_ph => 0,
	n => 1,
	operation_mode => "normal",
	pfd_max => 200000,
	pfd_min => 3076,
	self_reset_on_loss_lock => "off",
	simulation_type => "functional",
	switch_over_type => "auto",
	vco_center => 1538,
	vco_divide_by => 0,
	vco_frequency_control => "auto",
	vco_max => 3333,
	vco_min => 1538,
	vco_multiply_by => 0,
	vco_phase_shift_step => 208,
	vco_post_scale => 2)
-- pragma translate_on
PORT MAP (
	areset => GND,
	fbin => \u0|altpll_0|sd1|wire_pll7_fbout\,
	inclk => \u0|altpll_0|sd1|pll7_INCLK_bus\,
	fbout => \u0|altpll_0|sd1|wire_pll7_fbout\,
	clk => \u0|altpll_0|sd1|pll7_CLK_bus\);

-- Location: CLKCTRL_G4
\u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\);

-- Location: LCCOMB_X25_Y15_N0
\curr_cnt[0]~32\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[0]~32_combout\ = curr_cnt(0) $ (VCC)
-- \curr_cnt[0]~33\ = CARRY(curr_cnt(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(0),
	datad => VCC,
	combout => \curr_cnt[0]~32_combout\,
	cout => \curr_cnt[0]~33\);

-- Location: IOIBUF_X0_Y11_N22
\rst_n~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst_n,
	o => \rst_n~input_o\);

-- Location: CLKCTRL_G0
\rst_n~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \rst_n~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \rst_n~inputclkctrl_outclk\);

-- Location: FF_X25_Y15_N1
\curr_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[0]~32_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(0));

-- Location: LCCOMB_X25_Y15_N2
\curr_cnt[1]~34\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[1]~34_combout\ = (curr_cnt(1) & (!\curr_cnt[0]~33\)) # (!curr_cnt(1) & ((\curr_cnt[0]~33\) # (GND)))
-- \curr_cnt[1]~35\ = CARRY((!\curr_cnt[0]~33\) # (!curr_cnt(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(1),
	datad => VCC,
	cin => \curr_cnt[0]~33\,
	combout => \curr_cnt[1]~34_combout\,
	cout => \curr_cnt[1]~35\);

-- Location: FF_X25_Y15_N3
\curr_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[1]~34_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(1));

-- Location: LCCOMB_X25_Y15_N4
\curr_cnt[2]~36\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[2]~36_combout\ = (curr_cnt(2) & (\curr_cnt[1]~35\ $ (GND))) # (!curr_cnt(2) & (!\curr_cnt[1]~35\ & VCC))
-- \curr_cnt[2]~37\ = CARRY((curr_cnt(2) & !\curr_cnt[1]~35\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(2),
	datad => VCC,
	cin => \curr_cnt[1]~35\,
	combout => \curr_cnt[2]~36_combout\,
	cout => \curr_cnt[2]~37\);

-- Location: FF_X25_Y15_N5
\curr_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[2]~36_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(2));

-- Location: LCCOMB_X25_Y15_N6
\curr_cnt[3]~38\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[3]~38_combout\ = (curr_cnt(3) & (!\curr_cnt[2]~37\)) # (!curr_cnt(3) & ((\curr_cnt[2]~37\) # (GND)))
-- \curr_cnt[3]~39\ = CARRY((!\curr_cnt[2]~37\) # (!curr_cnt(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(3),
	datad => VCC,
	cin => \curr_cnt[2]~37\,
	combout => \curr_cnt[3]~38_combout\,
	cout => \curr_cnt[3]~39\);

-- Location: FF_X25_Y15_N7
\curr_cnt[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[3]~38_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(3));

-- Location: LCCOMB_X25_Y15_N8
\curr_cnt[4]~40\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[4]~40_combout\ = (curr_cnt(4) & (\curr_cnt[3]~39\ $ (GND))) # (!curr_cnt(4) & (!\curr_cnt[3]~39\ & VCC))
-- \curr_cnt[4]~41\ = CARRY((curr_cnt(4) & !\curr_cnt[3]~39\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(4),
	datad => VCC,
	cin => \curr_cnt[3]~39\,
	combout => \curr_cnt[4]~40_combout\,
	cout => \curr_cnt[4]~41\);

-- Location: FF_X25_Y15_N9
\curr_cnt[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[4]~40_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(4));

-- Location: LCCOMB_X25_Y15_N10
\curr_cnt[5]~42\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[5]~42_combout\ = (curr_cnt(5) & (!\curr_cnt[4]~41\)) # (!curr_cnt(5) & ((\curr_cnt[4]~41\) # (GND)))
-- \curr_cnt[5]~43\ = CARRY((!\curr_cnt[4]~41\) # (!curr_cnt(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(5),
	datad => VCC,
	cin => \curr_cnt[4]~41\,
	combout => \curr_cnt[5]~42_combout\,
	cout => \curr_cnt[5]~43\);

-- Location: FF_X25_Y15_N11
\curr_cnt[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[5]~42_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(5));

-- Location: LCCOMB_X25_Y15_N12
\curr_cnt[6]~44\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[6]~44_combout\ = (curr_cnt(6) & (\curr_cnt[5]~43\ $ (GND))) # (!curr_cnt(6) & (!\curr_cnt[5]~43\ & VCC))
-- \curr_cnt[6]~45\ = CARRY((curr_cnt(6) & !\curr_cnt[5]~43\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(6),
	datad => VCC,
	cin => \curr_cnt[5]~43\,
	combout => \curr_cnt[6]~44_combout\,
	cout => \curr_cnt[6]~45\);

-- Location: FF_X25_Y15_N13
\curr_cnt[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[6]~44_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(6));

-- Location: LCCOMB_X25_Y15_N14
\curr_cnt[7]~46\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[7]~46_combout\ = (curr_cnt(7) & (!\curr_cnt[6]~45\)) # (!curr_cnt(7) & ((\curr_cnt[6]~45\) # (GND)))
-- \curr_cnt[7]~47\ = CARRY((!\curr_cnt[6]~45\) # (!curr_cnt(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(7),
	datad => VCC,
	cin => \curr_cnt[6]~45\,
	combout => \curr_cnt[7]~46_combout\,
	cout => \curr_cnt[7]~47\);

-- Location: FF_X25_Y15_N15
\curr_cnt[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[7]~46_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(7));

-- Location: LCCOMB_X26_Y15_N6
\Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~1_combout\ = (!curr_cnt(5) & (!curr_cnt(6) & (curr_cnt(7) & !curr_cnt(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(5),
	datab => curr_cnt(6),
	datac => curr_cnt(7),
	datad => curr_cnt(4),
	combout => \Equal0~1_combout\);

-- Location: LCCOMB_X25_Y15_N16
\curr_cnt[8]~48\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[8]~48_combout\ = (curr_cnt(8) & (\curr_cnt[7]~47\ $ (GND))) # (!curr_cnt(8) & (!\curr_cnt[7]~47\ & VCC))
-- \curr_cnt[8]~49\ = CARRY((curr_cnt(8) & !\curr_cnt[7]~47\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(8),
	datad => VCC,
	cin => \curr_cnt[7]~47\,
	combout => \curr_cnt[8]~48_combout\,
	cout => \curr_cnt[8]~49\);

-- Location: FF_X25_Y15_N17
\curr_cnt[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[8]~48_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(8));

-- Location: LCCOMB_X25_Y15_N18
\curr_cnt[9]~50\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[9]~50_combout\ = (curr_cnt(9) & (!\curr_cnt[8]~49\)) # (!curr_cnt(9) & ((\curr_cnt[8]~49\) # (GND)))
-- \curr_cnt[9]~51\ = CARRY((!\curr_cnt[8]~49\) # (!curr_cnt(9)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(9),
	datad => VCC,
	cin => \curr_cnt[8]~49\,
	combout => \curr_cnt[9]~50_combout\,
	cout => \curr_cnt[9]~51\);

-- Location: FF_X25_Y15_N19
\curr_cnt[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[9]~50_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(9));

-- Location: LCCOMB_X25_Y15_N20
\curr_cnt[10]~52\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[10]~52_combout\ = (curr_cnt(10) & (\curr_cnt[9]~51\ $ (GND))) # (!curr_cnt(10) & (!\curr_cnt[9]~51\ & VCC))
-- \curr_cnt[10]~53\ = CARRY((curr_cnt(10) & !\curr_cnt[9]~51\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(10),
	datad => VCC,
	cin => \curr_cnt[9]~51\,
	combout => \curr_cnt[10]~52_combout\,
	cout => \curr_cnt[10]~53\);

-- Location: FF_X25_Y15_N21
\curr_cnt[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[10]~52_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(10));

-- Location: LCCOMB_X25_Y15_N22
\curr_cnt[11]~54\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[11]~54_combout\ = (curr_cnt(11) & (!\curr_cnt[10]~53\)) # (!curr_cnt(11) & ((\curr_cnt[10]~53\) # (GND)))
-- \curr_cnt[11]~55\ = CARRY((!\curr_cnt[10]~53\) # (!curr_cnt(11)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(11),
	datad => VCC,
	cin => \curr_cnt[10]~53\,
	combout => \curr_cnt[11]~54_combout\,
	cout => \curr_cnt[11]~55\);

-- Location: FF_X25_Y15_N23
\curr_cnt[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[11]~54_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(11));

-- Location: LCCOMB_X25_Y15_N24
\curr_cnt[12]~56\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[12]~56_combout\ = (curr_cnt(12) & (\curr_cnt[11]~55\ $ (GND))) # (!curr_cnt(12) & (!\curr_cnt[11]~55\ & VCC))
-- \curr_cnt[12]~57\ = CARRY((curr_cnt(12) & !\curr_cnt[11]~55\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(12),
	datad => VCC,
	cin => \curr_cnt[11]~55\,
	combout => \curr_cnt[12]~56_combout\,
	cout => \curr_cnt[12]~57\);

-- Location: FF_X25_Y15_N25
\curr_cnt[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[12]~56_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(12));

-- Location: LCCOMB_X25_Y15_N26
\curr_cnt[13]~58\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[13]~58_combout\ = (curr_cnt(13) & (!\curr_cnt[12]~57\)) # (!curr_cnt(13) & ((\curr_cnt[12]~57\) # (GND)))
-- \curr_cnt[13]~59\ = CARRY((!\curr_cnt[12]~57\) # (!curr_cnt(13)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(13),
	datad => VCC,
	cin => \curr_cnt[12]~57\,
	combout => \curr_cnt[13]~58_combout\,
	cout => \curr_cnt[13]~59\);

-- Location: FF_X25_Y15_N27
\curr_cnt[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[13]~58_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(13));

-- Location: LCCOMB_X25_Y15_N28
\curr_cnt[14]~60\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[14]~60_combout\ = (curr_cnt(14) & (\curr_cnt[13]~59\ $ (GND))) # (!curr_cnt(14) & (!\curr_cnt[13]~59\ & VCC))
-- \curr_cnt[14]~61\ = CARRY((curr_cnt(14) & !\curr_cnt[13]~59\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(14),
	datad => VCC,
	cin => \curr_cnt[13]~59\,
	combout => \curr_cnt[14]~60_combout\,
	cout => \curr_cnt[14]~61\);

-- Location: FF_X25_Y15_N29
\curr_cnt[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[14]~60_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(14));

-- Location: LCCOMB_X25_Y15_N30
\curr_cnt[15]~62\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[15]~62_combout\ = (curr_cnt(15) & (!\curr_cnt[14]~61\)) # (!curr_cnt(15) & ((\curr_cnt[14]~61\) # (GND)))
-- \curr_cnt[15]~63\ = CARRY((!\curr_cnt[14]~61\) # (!curr_cnt(15)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(15),
	datad => VCC,
	cin => \curr_cnt[14]~61\,
	combout => \curr_cnt[15]~62_combout\,
	cout => \curr_cnt[15]~63\);

-- Location: FF_X25_Y15_N31
\curr_cnt[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[15]~62_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(15));

-- Location: LCCOMB_X26_Y15_N4
\Equal0~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~3_combout\ = (!curr_cnt(13) & (!curr_cnt(14) & (!curr_cnt(15) & curr_cnt(12))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(13),
	datab => curr_cnt(14),
	datac => curr_cnt(15),
	datad => curr_cnt(12),
	combout => \Equal0~3_combout\);

-- Location: LCCOMB_X26_Y15_N22
\Equal0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~2_combout\ = (curr_cnt(8) & (!curr_cnt(10) & (!curr_cnt(11) & curr_cnt(9))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(8),
	datab => curr_cnt(10),
	datac => curr_cnt(11),
	datad => curr_cnt(9),
	combout => \Equal0~2_combout\);

-- Location: LCCOMB_X26_Y15_N10
\Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~0_combout\ = (!curr_cnt(0) & (curr_cnt(3) & (!curr_cnt(2) & !curr_cnt(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(0),
	datab => curr_cnt(3),
	datac => curr_cnt(2),
	datad => curr_cnt(1),
	combout => \Equal0~0_combout\);

-- Location: LCCOMB_X26_Y15_N30
\Equal0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~4_combout\ = (\Equal0~1_combout\ & (\Equal0~3_combout\ & (\Equal0~2_combout\ & \Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~1_combout\,
	datab => \Equal0~3_combout\,
	datac => \Equal0~2_combout\,
	datad => \Equal0~0_combout\,
	combout => \Equal0~4_combout\);

-- Location: LCCOMB_X25_Y14_N0
\curr_cnt[16]~64\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[16]~64_combout\ = (curr_cnt(16) & (\curr_cnt[15]~63\ $ (GND))) # (!curr_cnt(16) & (!\curr_cnt[15]~63\ & VCC))
-- \curr_cnt[16]~65\ = CARRY((curr_cnt(16) & !\curr_cnt[15]~63\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(16),
	datad => VCC,
	cin => \curr_cnt[15]~63\,
	combout => \curr_cnt[16]~64_combout\,
	cout => \curr_cnt[16]~65\);

-- Location: FF_X25_Y14_N1
\curr_cnt[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[16]~64_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(16));

-- Location: LCCOMB_X25_Y14_N2
\curr_cnt[17]~66\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[17]~66_combout\ = (curr_cnt(17) & (!\curr_cnt[16]~65\)) # (!curr_cnt(17) & ((\curr_cnt[16]~65\) # (GND)))
-- \curr_cnt[17]~67\ = CARRY((!\curr_cnt[16]~65\) # (!curr_cnt(17)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(17),
	datad => VCC,
	cin => \curr_cnt[16]~65\,
	combout => \curr_cnt[17]~66_combout\,
	cout => \curr_cnt[17]~67\);

-- Location: FF_X25_Y14_N3
\curr_cnt[17]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[17]~66_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(17));

-- Location: LCCOMB_X25_Y14_N4
\curr_cnt[18]~68\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[18]~68_combout\ = (curr_cnt(18) & (\curr_cnt[17]~67\ $ (GND))) # (!curr_cnt(18) & (!\curr_cnt[17]~67\ & VCC))
-- \curr_cnt[18]~69\ = CARRY((curr_cnt(18) & !\curr_cnt[17]~67\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(18),
	datad => VCC,
	cin => \curr_cnt[17]~67\,
	combout => \curr_cnt[18]~68_combout\,
	cout => \curr_cnt[18]~69\);

-- Location: FF_X25_Y14_N5
\curr_cnt[18]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[18]~68_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(18));

-- Location: LCCOMB_X25_Y14_N6
\curr_cnt[19]~70\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[19]~70_combout\ = (curr_cnt(19) & (!\curr_cnt[18]~69\)) # (!curr_cnt(19) & ((\curr_cnt[18]~69\) # (GND)))
-- \curr_cnt[19]~71\ = CARRY((!\curr_cnt[18]~69\) # (!curr_cnt(19)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(19),
	datad => VCC,
	cin => \curr_cnt[18]~69\,
	combout => \curr_cnt[19]~70_combout\,
	cout => \curr_cnt[19]~71\);

-- Location: FF_X25_Y14_N7
\curr_cnt[19]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[19]~70_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(19));

-- Location: LCCOMB_X25_Y14_N8
\curr_cnt[20]~72\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[20]~72_combout\ = (curr_cnt(20) & (\curr_cnt[19]~71\ $ (GND))) # (!curr_cnt(20) & (!\curr_cnt[19]~71\ & VCC))
-- \curr_cnt[20]~73\ = CARRY((curr_cnt(20) & !\curr_cnt[19]~71\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(20),
	datad => VCC,
	cin => \curr_cnt[19]~71\,
	combout => \curr_cnt[20]~72_combout\,
	cout => \curr_cnt[20]~73\);

-- Location: FF_X25_Y14_N9
\curr_cnt[20]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[20]~72_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(20));

-- Location: LCCOMB_X25_Y14_N10
\curr_cnt[21]~74\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[21]~74_combout\ = (curr_cnt(21) & (!\curr_cnt[20]~73\)) # (!curr_cnt(21) & ((\curr_cnt[20]~73\) # (GND)))
-- \curr_cnt[21]~75\ = CARRY((!\curr_cnt[20]~73\) # (!curr_cnt(21)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(21),
	datad => VCC,
	cin => \curr_cnt[20]~73\,
	combout => \curr_cnt[21]~74_combout\,
	cout => \curr_cnt[21]~75\);

-- Location: FF_X25_Y14_N11
\curr_cnt[21]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[21]~74_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(21));

-- Location: LCCOMB_X25_Y14_N12
\curr_cnt[22]~76\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[22]~76_combout\ = (curr_cnt(22) & (\curr_cnt[21]~75\ $ (GND))) # (!curr_cnt(22) & (!\curr_cnt[21]~75\ & VCC))
-- \curr_cnt[22]~77\ = CARRY((curr_cnt(22) & !\curr_cnt[21]~75\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(22),
	datad => VCC,
	cin => \curr_cnt[21]~75\,
	combout => \curr_cnt[22]~76_combout\,
	cout => \curr_cnt[22]~77\);

-- Location: FF_X25_Y14_N13
\curr_cnt[22]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[22]~76_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(22));

-- Location: LCCOMB_X25_Y14_N14
\curr_cnt[23]~78\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[23]~78_combout\ = (curr_cnt(23) & (!\curr_cnt[22]~77\)) # (!curr_cnt(23) & ((\curr_cnt[22]~77\) # (GND)))
-- \curr_cnt[23]~79\ = CARRY((!\curr_cnt[22]~77\) # (!curr_cnt(23)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(23),
	datad => VCC,
	cin => \curr_cnt[22]~77\,
	combout => \curr_cnt[23]~78_combout\,
	cout => \curr_cnt[23]~79\);

-- Location: FF_X25_Y14_N15
\curr_cnt[23]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[23]~78_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(23));

-- Location: LCCOMB_X25_Y14_N16
\curr_cnt[24]~80\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[24]~80_combout\ = (curr_cnt(24) & (\curr_cnt[23]~79\ $ (GND))) # (!curr_cnt(24) & (!\curr_cnt[23]~79\ & VCC))
-- \curr_cnt[24]~81\ = CARRY((curr_cnt(24) & !\curr_cnt[23]~79\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(24),
	datad => VCC,
	cin => \curr_cnt[23]~79\,
	combout => \curr_cnt[24]~80_combout\,
	cout => \curr_cnt[24]~81\);

-- Location: FF_X25_Y14_N17
\curr_cnt[24]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[24]~80_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(24));

-- Location: LCCOMB_X25_Y14_N18
\curr_cnt[25]~82\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[25]~82_combout\ = (curr_cnt(25) & (!\curr_cnt[24]~81\)) # (!curr_cnt(25) & ((\curr_cnt[24]~81\) # (GND)))
-- \curr_cnt[25]~83\ = CARRY((!\curr_cnt[24]~81\) # (!curr_cnt(25)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(25),
	datad => VCC,
	cin => \curr_cnt[24]~81\,
	combout => \curr_cnt[25]~82_combout\,
	cout => \curr_cnt[25]~83\);

-- Location: FF_X25_Y14_N19
\curr_cnt[25]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[25]~82_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(25));

-- Location: LCCOMB_X25_Y14_N20
\curr_cnt[26]~84\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[26]~84_combout\ = (curr_cnt(26) & (\curr_cnt[25]~83\ $ (GND))) # (!curr_cnt(26) & (!\curr_cnt[25]~83\ & VCC))
-- \curr_cnt[26]~85\ = CARRY((curr_cnt(26) & !\curr_cnt[25]~83\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(26),
	datad => VCC,
	cin => \curr_cnt[25]~83\,
	combout => \curr_cnt[26]~84_combout\,
	cout => \curr_cnt[26]~85\);

-- Location: FF_X25_Y14_N21
\curr_cnt[26]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[26]~84_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(26));

-- Location: LCCOMB_X25_Y14_N22
\curr_cnt[27]~86\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[27]~86_combout\ = (curr_cnt(27) & (!\curr_cnt[26]~85\)) # (!curr_cnt(27) & ((\curr_cnt[26]~85\) # (GND)))
-- \curr_cnt[27]~87\ = CARRY((!\curr_cnt[26]~85\) # (!curr_cnt(27)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(27),
	datad => VCC,
	cin => \curr_cnt[26]~85\,
	combout => \curr_cnt[27]~86_combout\,
	cout => \curr_cnt[27]~87\);

-- Location: FF_X25_Y14_N23
\curr_cnt[27]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[27]~86_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(27));

-- Location: LCCOMB_X26_Y14_N0
\Equal0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~8_combout\ = (!curr_cnt(24) & (!curr_cnt(27) & (!curr_cnt(25) & !curr_cnt(26))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(24),
	datab => curr_cnt(27),
	datac => curr_cnt(25),
	datad => curr_cnt(26),
	combout => \Equal0~8_combout\);

-- Location: LCCOMB_X26_Y14_N4
\Equal0~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~5_combout\ = (!curr_cnt(16) & (!curr_cnt(18) & (!curr_cnt(19) & !curr_cnt(17))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(16),
	datab => curr_cnt(18),
	datac => curr_cnt(19),
	datad => curr_cnt(17),
	combout => \Equal0~5_combout\);

-- Location: LCCOMB_X26_Y14_N8
\Equal0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~6_combout\ = (!curr_cnt(20) & !curr_cnt(21))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(20),
	datad => curr_cnt(21),
	combout => \Equal0~6_combout\);

-- Location: LCCOMB_X26_Y14_N24
\Equal0~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~7_combout\ = (!curr_cnt(23) & (\Equal0~5_combout\ & (\Equal0~6_combout\ & !curr_cnt(22))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(23),
	datab => \Equal0~5_combout\,
	datac => \Equal0~6_combout\,
	datad => curr_cnt(22),
	combout => \Equal0~7_combout\);

-- Location: LCCOMB_X25_Y14_N24
\curr_cnt[28]~88\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[28]~88_combout\ = (curr_cnt(28) & (\curr_cnt[27]~87\ $ (GND))) # (!curr_cnt(28) & (!\curr_cnt[27]~87\ & VCC))
-- \curr_cnt[28]~89\ = CARRY((curr_cnt(28) & !\curr_cnt[27]~87\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(28),
	datad => VCC,
	cin => \curr_cnt[27]~87\,
	combout => \curr_cnt[28]~88_combout\,
	cout => \curr_cnt[28]~89\);

-- Location: FF_X25_Y14_N25
\curr_cnt[28]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[28]~88_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(28));

-- Location: LCCOMB_X25_Y14_N26
\curr_cnt[29]~90\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[29]~90_combout\ = (curr_cnt(29) & (!\curr_cnt[28]~89\)) # (!curr_cnt(29) & ((\curr_cnt[28]~89\) # (GND)))
-- \curr_cnt[29]~91\ = CARRY((!\curr_cnt[28]~89\) # (!curr_cnt(29)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(29),
	datad => VCC,
	cin => \curr_cnt[28]~89\,
	combout => \curr_cnt[29]~90_combout\,
	cout => \curr_cnt[29]~91\);

-- Location: FF_X25_Y14_N27
\curr_cnt[29]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[29]~90_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(29));

-- Location: LCCOMB_X25_Y14_N28
\curr_cnt[30]~92\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[30]~92_combout\ = (curr_cnt(30) & (\curr_cnt[29]~91\ $ (GND))) # (!curr_cnt(30) & (!\curr_cnt[29]~91\ & VCC))
-- \curr_cnt[30]~93\ = CARRY((curr_cnt(30) & !\curr_cnt[29]~91\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => curr_cnt(30),
	datad => VCC,
	cin => \curr_cnt[29]~91\,
	combout => \curr_cnt[30]~92_combout\,
	cout => \curr_cnt[30]~93\);

-- Location: FF_X25_Y14_N29
\curr_cnt[30]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[30]~92_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(30));

-- Location: LCCOMB_X25_Y14_N30
\curr_cnt[31]~94\ : cycloneive_lcell_comb
-- Equation(s):
-- \curr_cnt[31]~94_combout\ = curr_cnt(31) $ (\curr_cnt[30]~93\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(31),
	cin => \curr_cnt[30]~93\,
	combout => \curr_cnt[31]~94_combout\);

-- Location: FF_X25_Y14_N31
\curr_cnt[31]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \u0|altpll_0|sd1|wire_pll7_clk[0]~clkctrl_outclk\,
	d => \curr_cnt[31]~94_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	sclr => \rtl~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => curr_cnt(31));

-- Location: LCCOMB_X26_Y14_N2
\Equal0~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \Equal0~9_combout\ = (!curr_cnt(29) & (!curr_cnt(31) & (!curr_cnt(30) & !curr_cnt(28))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => curr_cnt(29),
	datab => curr_cnt(31),
	datac => curr_cnt(30),
	datad => curr_cnt(28),
	combout => \Equal0~9_combout\);

-- Location: LCCOMB_X26_Y15_N8
\rtl~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \rtl~0_combout\ = LCELL((\Equal0~4_combout\ & (\Equal0~8_combout\ & (\Equal0~7_combout\ & \Equal0~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Equal0~4_combout\,
	datab => \Equal0~8_combout\,
	datac => \Equal0~7_combout\,
	datad => \Equal0~9_combout\,
	combout => \rtl~0_combout\);

-- Location: CLKCTRL_G9
\rtl~0clkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \rtl~0clkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \rtl~0clkctrl_outclk\);

-- Location: IOIBUF_X16_Y24_N8
\comp_in~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_comp_in,
	o => \comp_in~input_o\);

-- Location: IOIBUF_X34_Y12_N22
\soc_n~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_soc_n,
	o => \soc_n~input_o\);

-- Location: LCCOMB_X16_Y22_N2
\ADC0|curr_state.wait_soc~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|curr_state.wait_soc~0_combout\ = ((\ADC0|curr_state.wait_soc~q\) # ((\ADC0|curr_state.try_1~q\) # (\ADC0|curr_state.confirm_bit~q\))) # (!\soc_n~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \soc_n~input_o\,
	datab => \ADC0|curr_state.wait_soc~q\,
	datac => \ADC0|curr_state.try_1~q\,
	datad => \ADC0|curr_state.confirm_bit~q\,
	combout => \ADC0|curr_state.wait_soc~0_combout\);

-- Location: LCCOMB_X16_Y22_N0
\ADC0|curr_state.wait_soc~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|curr_state.wait_soc~1_combout\ = (!\ADC0|curr_state.done~q\ & \ADC0|curr_state.wait_soc~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ADC0|curr_state.done~q\,
	datad => \ADC0|curr_state.wait_soc~0_combout\,
	combout => \ADC0|curr_state.wait_soc~1_combout\);

-- Location: FF_X16_Y22_N1
\ADC0|curr_state.wait_soc\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|curr_state.wait_soc~1_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_state.wait_soc~q\);

-- Location: LCCOMB_X17_Y22_N30
\ADC0|Decoder0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Decoder0~0_combout\ = (!\ADC0|curr_iter\(2) & (!\ADC0|curr_iter\(1) & !\ADC0|curr_iter\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \ADC0|curr_iter\(2),
	datac => \ADC0|curr_iter\(1),
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Decoder0~0_combout\);

-- Location: LCCOMB_X16_Y22_N4
\ADC0|Selector11~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector11~0_combout\ = (\soc_n~input_o\ & (((!\ADC0|Decoder0~0_combout\ & \ADC0|curr_state.confirm_bit~q\)))) # (!\soc_n~input_o\ & (((!\ADC0|Decoder0~0_combout\ & \ADC0|curr_state.confirm_bit~q\)) # (!\ADC0|curr_state.wait_soc~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111100010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \soc_n~input_o\,
	datab => \ADC0|curr_state.wait_soc~q\,
	datac => \ADC0|Decoder0~0_combout\,
	datad => \ADC0|curr_state.confirm_bit~q\,
	combout => \ADC0|Selector11~0_combout\);

-- Location: FF_X16_Y22_N5
\ADC0|curr_state.try_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector11~0_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_state.try_1~q\);

-- Location: LCCOMB_X17_Y22_N24
\ADC0|Selector2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector2~0_combout\ = (\ADC0|curr_iter\(0) & ((\ADC0|curr_state.done~q\) # ((\ADC0|curr_state.try_1~q\)))) # (!\ADC0|curr_iter\(0) & (((\ADC0|curr_state.confirm_bit~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_state.done~q\,
	datab => \ADC0|curr_state.try_1~q\,
	datac => \ADC0|curr_iter\(0),
	datad => \ADC0|curr_state.confirm_bit~q\,
	combout => \ADC0|Selector2~0_combout\);

-- Location: FF_X17_Y22_N25
\ADC0|curr_iter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector2~0_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_iter\(0));

-- Location: LCCOMB_X17_Y22_N22
\ADC0|Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Add0~1_combout\ = \ADC0|curr_iter\(1) $ (!\ADC0|curr_iter\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \ADC0|curr_iter\(1),
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Add0~1_combout\);

-- Location: LCCOMB_X16_Y22_N16
\ADC0|next_iter~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|next_iter~0_combout\ = (!\ADC0|curr_state.try_1~q\ & !\ADC0|curr_state.done~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \ADC0|curr_state.try_1~q\,
	datad => \ADC0|curr_state.done~q\,
	combout => \ADC0|next_iter~0_combout\);

-- Location: FF_X17_Y22_N23
\ADC0|curr_iter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Add0~1_combout\,
	asdata => VCC,
	clrn => \rst_n~inputclkctrl_outclk\,
	sload => \ADC0|ALT_INV_curr_state.confirm_bit~q\,
	ena => \ADC0|next_iter~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_iter\(1));

-- Location: LCCOMB_X17_Y22_N4
\ADC0|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Add0~0_combout\ = \ADC0|curr_iter\(2) $ (((!\ADC0|curr_iter\(1) & !\ADC0|curr_iter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010100101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(1),
	datac => \ADC0|curr_iter\(2),
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Add0~0_combout\);

-- Location: FF_X17_Y22_N5
\ADC0|curr_iter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Add0~0_combout\,
	asdata => VCC,
	clrn => \rst_n~inputclkctrl_outclk\,
	sload => \ADC0|ALT_INV_curr_state.confirm_bit~q\,
	ena => \ADC0|next_iter~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_iter\(2));

-- Location: LCCOMB_X16_Y22_N6
\ADC0|Selector13~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector13~0_combout\ = (!\ADC0|curr_iter\(2) & (!\ADC0|curr_iter\(1) & (\ADC0|curr_state.confirm_bit~q\ & !\ADC0|curr_iter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(2),
	datab => \ADC0|curr_iter\(1),
	datac => \ADC0|curr_state.confirm_bit~q\,
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Selector13~0_combout\);

-- Location: FF_X16_Y22_N7
\ADC0|curr_state.done\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector13~0_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_state.done~q\);

-- Location: LCCOMB_X16_Y22_N22
\ADC0|Selector12~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector12~0_combout\ = (!\ADC0|curr_state.done~q\ & \ADC0|curr_state.try_1~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \ADC0|curr_state.done~q\,
	datad => \ADC0|curr_state.try_1~q\,
	combout => \ADC0|Selector12~0_combout\);

-- Location: FF_X16_Y22_N23
\ADC0|curr_state.confirm_bit\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector12~0_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_state.confirm_bit~q\);

-- Location: LCCOMB_X16_Y22_N14
\ADC0|Selector8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector8~0_combout\ = (\ADC0|curr_state.try_1~q\) # ((\comp_in~input_o\ & \ADC0|curr_state.confirm_bit~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \comp_in~input_o\,
	datac => \ADC0|curr_state.confirm_bit~q\,
	datad => \ADC0|curr_state.try_1~q\,
	combout => \ADC0|Selector8~0_combout\);

-- Location: LCCOMB_X17_Y22_N12
\ADC0|Selector9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector9~0_combout\ = (\ADC0|curr_dac\(0) & (((\ADC0|curr_state.confirm_bit~q\ & !\ADC0|Decoder0~0_combout\)) # (!\ADC0|next_iter~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101010001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_dac\(0),
	datab => \ADC0|curr_state.confirm_bit~q\,
	datac => \ADC0|next_iter~0_combout\,
	datad => \ADC0|Decoder0~0_combout\,
	combout => \ADC0|Selector9~0_combout\);

-- Location: LCCOMB_X17_Y22_N8
\ADC0|Selector9~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector9~1_combout\ = (\ADC0|Selector9~0_combout\) # ((\ADC0|Selector8~0_combout\ & \ADC0|Decoder0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|Selector8~0_combout\,
	datac => \ADC0|Decoder0~0_combout\,
	datad => \ADC0|Selector9~0_combout\,
	combout => \ADC0|Selector9~1_combout\);

-- Location: FF_X17_Y22_N9
\ADC0|curr_dac[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector9~1_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_dac\(0));

-- Location: LCCOMB_X16_Y22_N26
\ADC0|Selector8~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector8~2_combout\ = (\ADC0|curr_state.confirm_bit~q\ & ((\ADC0|curr_iter\(2)) # ((\ADC0|curr_iter\(1)) # (!\ADC0|curr_iter\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(2),
	datab => \ADC0|curr_iter\(1),
	datac => \ADC0|curr_state.confirm_bit~q\,
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Selector8~2_combout\);

-- Location: LCCOMB_X16_Y22_N24
\ADC0|Selector8~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector8~1_combout\ = (!\ADC0|curr_iter\(2) & (!\ADC0|curr_iter\(1) & (\ADC0|Selector8~0_combout\ & \ADC0|curr_iter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(2),
	datab => \ADC0|curr_iter\(1),
	datac => \ADC0|Selector8~0_combout\,
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Selector8~1_combout\);

-- Location: LCCOMB_X16_Y22_N12
\ADC0|Selector8~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector8~3_combout\ = (\ADC0|Selector8~1_combout\) # ((\ADC0|curr_dac\(1) & ((\ADC0|Selector8~2_combout\) # (!\ADC0|next_iter~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|Selector8~2_combout\,
	datab => \ADC0|next_iter~0_combout\,
	datac => \ADC0|curr_dac\(1),
	datad => \ADC0|Selector8~1_combout\,
	combout => \ADC0|Selector8~3_combout\);

-- Location: FF_X16_Y22_N13
\ADC0|curr_dac[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector8~3_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_dac\(1));

-- Location: LCCOMB_X16_Y22_N30
\ADC0|Selector7~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector7~1_combout\ = (\ADC0|curr_state.confirm_bit~q\ & ((\ADC0|curr_iter\(2)) # ((\ADC0|curr_iter\(0)) # (!\ADC0|curr_iter\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(2),
	datab => \ADC0|curr_iter\(1),
	datac => \ADC0|curr_state.confirm_bit~q\,
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Selector7~1_combout\);

-- Location: LCCOMB_X16_Y22_N28
\ADC0|Selector7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector7~0_combout\ = (!\ADC0|curr_iter\(2) & (\ADC0|curr_iter\(1) & (\ADC0|Selector8~0_combout\ & !\ADC0|curr_iter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(2),
	datab => \ADC0|curr_iter\(1),
	datac => \ADC0|Selector8~0_combout\,
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Selector7~0_combout\);

-- Location: LCCOMB_X16_Y22_N18
\ADC0|Selector7~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector7~2_combout\ = (\ADC0|Selector7~0_combout\) # ((\ADC0|curr_dac\(2) & ((\ADC0|Selector7~1_combout\) # (!\ADC0|next_iter~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|Selector7~1_combout\,
	datab => \ADC0|next_iter~0_combout\,
	datac => \ADC0|curr_dac\(2),
	datad => \ADC0|Selector7~0_combout\,
	combout => \ADC0|Selector7~2_combout\);

-- Location: FF_X16_Y22_N19
\ADC0|curr_dac[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector7~2_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_dac\(2));

-- Location: LCCOMB_X17_Y22_N28
\ADC0|Selector6~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector6~1_combout\ = (\ADC0|curr_state.confirm_bit~q\ & (((\ADC0|curr_iter\(2)) # (!\ADC0|curr_iter\(0))) # (!\ADC0|curr_iter\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(1),
	datab => \ADC0|curr_iter\(0),
	datac => \ADC0|curr_iter\(2),
	datad => \ADC0|curr_state.confirm_bit~q\,
	combout => \ADC0|Selector6~1_combout\);

-- Location: LCCOMB_X17_Y22_N6
\ADC0|Selector6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector6~0_combout\ = (\ADC0|curr_iter\(1) & (\ADC0|curr_iter\(0) & (!\ADC0|curr_iter\(2) & \ADC0|Selector8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(1),
	datab => \ADC0|curr_iter\(0),
	datac => \ADC0|curr_iter\(2),
	datad => \ADC0|Selector8~0_combout\,
	combout => \ADC0|Selector6~0_combout\);

-- Location: LCCOMB_X17_Y22_N26
\ADC0|Selector6~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector6~2_combout\ = (\ADC0|Selector6~0_combout\) # ((\ADC0|curr_dac\(3) & ((\ADC0|Selector6~1_combout\) # (!\ADC0|next_iter~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|next_iter~0_combout\,
	datab => \ADC0|Selector6~1_combout\,
	datac => \ADC0|curr_dac\(3),
	datad => \ADC0|Selector6~0_combout\,
	combout => \ADC0|Selector6~2_combout\);

-- Location: FF_X17_Y22_N27
\ADC0|curr_dac[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector6~2_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_dac\(3));

-- Location: LCCOMB_X17_Y22_N0
\ADC0|Selector5~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector5~1_combout\ = (\ADC0|curr_state.confirm_bit~q\ & ((\ADC0|curr_iter\(1)) # ((\ADC0|curr_iter\(0)) # (!\ADC0|curr_iter\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(1),
	datab => \ADC0|curr_iter\(0),
	datac => \ADC0|curr_iter\(2),
	datad => \ADC0|curr_state.confirm_bit~q\,
	combout => \ADC0|Selector5~1_combout\);

-- Location: LCCOMB_X17_Y22_N10
\ADC0|Selector5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector5~0_combout\ = (!\ADC0|curr_iter\(1) & (!\ADC0|curr_iter\(0) & (\ADC0|curr_iter\(2) & \ADC0|Selector8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(1),
	datab => \ADC0|curr_iter\(0),
	datac => \ADC0|curr_iter\(2),
	datad => \ADC0|Selector8~0_combout\,
	combout => \ADC0|Selector5~0_combout\);

-- Location: LCCOMB_X17_Y22_N16
\ADC0|Selector5~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector5~2_combout\ = (\ADC0|Selector5~0_combout\) # ((\ADC0|curr_dac\(4) & ((\ADC0|Selector5~1_combout\) # (!\ADC0|next_iter~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|next_iter~0_combout\,
	datab => \ADC0|Selector5~1_combout\,
	datac => \ADC0|curr_dac\(4),
	datad => \ADC0|Selector5~0_combout\,
	combout => \ADC0|Selector5~2_combout\);

-- Location: FF_X17_Y22_N17
\ADC0|curr_dac[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector5~2_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_dac\(4));

-- Location: LCCOMB_X16_Y22_N10
\ADC0|Selector4~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector4~1_combout\ = (\ADC0|curr_state.confirm_bit~q\ & (((\ADC0|curr_iter\(1)) # (!\ADC0|curr_iter\(0))) # (!\ADC0|curr_iter\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(2),
	datab => \ADC0|curr_iter\(1),
	datac => \ADC0|curr_state.confirm_bit~q\,
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Selector4~1_combout\);

-- Location: LCCOMB_X16_Y22_N20
\ADC0|Selector4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector4~0_combout\ = (\ADC0|curr_iter\(2) & (!\ADC0|curr_iter\(1) & (\ADC0|Selector8~0_combout\ & \ADC0|curr_iter\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(2),
	datab => \ADC0|curr_iter\(1),
	datac => \ADC0|Selector8~0_combout\,
	datad => \ADC0|curr_iter\(0),
	combout => \ADC0|Selector4~0_combout\);

-- Location: LCCOMB_X16_Y22_N8
\ADC0|Selector4~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector4~2_combout\ = (\ADC0|Selector4~0_combout\) # ((\ADC0|curr_dac\(5) & ((\ADC0|Selector4~1_combout\) # (!\ADC0|next_iter~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|Selector4~1_combout\,
	datab => \ADC0|next_iter~0_combout\,
	datac => \ADC0|curr_dac\(5),
	datad => \ADC0|Selector4~0_combout\,
	combout => \ADC0|Selector4~2_combout\);

-- Location: FF_X16_Y22_N9
\ADC0|curr_dac[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector4~2_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_dac\(5));

-- Location: LCCOMB_X17_Y22_N20
\ADC0|Selector3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector3~1_combout\ = (\ADC0|curr_state.confirm_bit~q\ & (((\ADC0|curr_iter\(0)) # (!\ADC0|curr_iter\(2))) # (!\ADC0|curr_iter\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(1),
	datab => \ADC0|curr_iter\(0),
	datac => \ADC0|curr_iter\(2),
	datad => \ADC0|curr_state.confirm_bit~q\,
	combout => \ADC0|Selector3~1_combout\);

-- Location: LCCOMB_X17_Y22_N18
\ADC0|Selector3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector3~0_combout\ = (\ADC0|curr_iter\(1) & (!\ADC0|curr_iter\(0) & (\ADC0|curr_iter\(2) & \ADC0|Selector8~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|curr_iter\(1),
	datab => \ADC0|curr_iter\(0),
	datac => \ADC0|curr_iter\(2),
	datad => \ADC0|Selector8~0_combout\,
	combout => \ADC0|Selector3~0_combout\);

-- Location: LCCOMB_X17_Y22_N14
\ADC0|Selector3~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \ADC0|Selector3~2_combout\ = (\ADC0|Selector3~0_combout\) # ((\ADC0|curr_dac\(6) & ((\ADC0|Selector3~1_combout\) # (!\ADC0|next_iter~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ADC0|next_iter~0_combout\,
	datab => \ADC0|Selector3~1_combout\,
	datac => \ADC0|curr_dac\(6),
	datad => \ADC0|Selector3~0_combout\,
	combout => \ADC0|Selector3~2_combout\);

-- Location: FF_X17_Y22_N15
\ADC0|curr_dac[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \rtl~0clkctrl_outclk\,
	d => \ADC0|Selector3~2_combout\,
	clrn => \rst_n~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \ADC0|curr_dac\(6));
END structure;


