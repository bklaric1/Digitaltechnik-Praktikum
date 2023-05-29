library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_majority is
port ( SW	: in		std_ulogic_vector(9 downto 0);
		 HEX0	: out		std_ulogic_vector(6 downto 0);
		 HEX1	: out		std_ulogic_vector(6 downto 0);
		 HEX2	: out		std_ulogic_vector(6 downto 0);
		 HEX3 : out		std_ulogic_vector(6 downto 0);
		 LEDR : out		std_ulogic_vector(9 downto 0);
		 LEDG	: out		std_ulogic_vector(7 downto 0));
end entity;

architecture rtl of de1_majority is

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

	zaehler_0 : cntones
	port map (
		switches_i => SW(3 downto 0),
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
	
	res <= resize(sum0,4) + sum1 + sum2;

	LEDG(7) <= '1' when res > 5 else '0';
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
