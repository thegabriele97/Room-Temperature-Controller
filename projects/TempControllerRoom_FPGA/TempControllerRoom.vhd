library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TempControllerRoom is
	port(
		clk_in			: in std_logic;
		rst_n				: in std_logic;
		
		beep				: out std_logic;
		
		--ADC/SAR Converter
		soc_n				: in std_logic;
		comp_in			: in std_logic;
		DAC_data			: out std_logic_vector(6 downto 0)
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


    component soc is
        port (
            clk_clk         : in  std_logic := 'X'; -- clk
            reset_reset_n   : in  std_logic := 'X'; -- reset_n
            altpll_0_c0_clk : out std_logic         -- clk
        );
    end component soc;


	signal clk_1hz, clk_5khz: std_logic;
	signal rst: std_logic;
	signal soc_s: std_logic;
	
	signal trash: std_logic;
	signal trash_enl: std_logic_vector(6 downto 0);
	
	signal curr_cnt, next_cnt: std_logic_vector(31 downto 0);
	
begin

	u0 : component soc
	  port map (
			clk_clk         => clk_in,         --         clk.clk
			reset_reset_n   => rst_n,   --       reset.reset_n
			altpll_0_c0_clk => clk_5khz  -- altpll_0_c0.clk
	  );

	ADC0:	SAR generic map(7, 3) port map(
		clk => clk_1hz,
		rst => rst,
		soc=> soc_s,
		eoc => trash,
		comp_in => comp_in,
		data => trash_enl,
		dac_data => DAC_data
	);
	
	rst <= not rst_n;
	soc_s <= not soc_n;
	beep <= clk_1hz;
	
	next_cnt <= (others => '0') when (unsigned(curr_cnt) = 5000) else
					std_logic_vector(unsigned(curr_cnt) + 1);
	
	clk_1hz <= '1' when (unsigned(curr_cnt) = 5000) else '0';
	
	process(clk_5khz, rst)
	begin
	
		if (rst = '1') then
			curr_cnt <= (others => '0');
		elsif (rising_edge(clk_5khz)) then
			curr_cnt <= next_cnt;
		end if;
	
	end process;

end mixture;
