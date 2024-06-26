library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_majority_messen is
port ( SW	: in		std_ulogic_vector(9 downto 0);
		 HEX0	: out		std_ulogic_vector(6 downto 0);
		 HEX1	: out		std_ulogic_vector(6 downto 0);
		 HEX2	: out		std_ulogic_vector(6 downto 0);
		 HEX3 : out		std_ulogic_vector(6 downto 0);
		 LEDR : out		std_ulogic_vector(9 downto 0);
		 LEDG	: out		std_ulogic_vector(7 downto 0);
		 CLOCK_50 : in		std_ulogic;
		 CLOCK_50_OUT : out		std_ulogic;
		 CLK_IN	: in		std_ulogic;
		 MAJ : out		std_ulogic);
end entity;

architecture rtl of de1_majority_messen is

component bin2seg is 
  port ( bin_i   : in      std_ulogic_vector(3 downto 0);
         seg_o   : out     std_ulogic_vector(6 downto 0));  
  end component;

component cntones is
	port ( switches_i		: in  std_ulogic_vector(3 downto 0);
			 cnt_o			: out std_ulogic_vector(2 downto 0));
  end component;
  
  signal zaehler0, zaehler1, zaehler2 : std_ulogic_vector(2 downto 0);
  signal sum0, sum1, sum2 : unsigned(2 downto 0);
  signal res : unsigned(3 downto 0);
  
begin

	LEDR <= SW;
	CLOCK_50_OUT <= CLOCK_50; --Ausgang auf GPIO Block, mit CLK_IN mit einer Brucke verbunden

	zaehler_0 : cntones
	port map (
		switches_i(3 downto 1) => SW(3 downto 1),
		switches_i(0) => CLK_IN, --Langste Pfad, d.h. grosste Verzogerung
		cnt_o		  => zaehler0);
		
	zaehler_1 : cntones
	port map (
		switches_i => SW(7 downto 4),
		cnt_o		  => zaehler1);
		
	zaehler_2 : cntones
	port map (
		switches_i(1 downto 0) => SW(9 downto 8),
		switches_i(3 downto 2) => "00",
		cnt_o		  => zaehler2);
		
	sum0 <= unsigned(zaehler0);
	sum1 <= unsigned(zaehler1);
	sum2 <= unsigned(zaehler2);
	
	res <= resize(sum0,4) + resize(sum1,4) + resize(sum2, 4);

	MAJ <= '1' when res > 5 else '0';
	LEDG(6 downto 4) <= "000";
	LEDG(3 downto 0) <= std_ulogic_vector(res);
	
	seg_z0 : bin2seg
	port map(
	 bin_i(2 downto 0) => zaehler0,
	 bin_i(3) => '0',
	 seg_o => HEX0(6 downto 0));
	 
	 seg_z1 : bin2seg
	port map(
	 bin_i(2 downto 0) => zaehler1,
	 bin_i(3) => '0',
	 seg_o => HEX1(6 downto 0));
	 
	 seg_z2 : bin2seg
	port map(
	 bin_i(2 downto 0) => zaehler2,
	 bin_i(3) => '0',
	 seg_o => HEX2(6 downto 0));
	 
	 ergebnis : bin2seg
	port map(
	 bin_i(3 downto 0) => std_ulogic_vector(res),
	 seg_o => HEX3(6 downto 0));

end architecture rtl;
