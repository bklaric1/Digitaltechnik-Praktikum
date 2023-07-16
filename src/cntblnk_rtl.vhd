library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cntblnk is 
port ( clk        : in      std_ulogic;
       rst_n      : in      std_ulogic; 
		 enable		: in		 std_ulogic;
		 gen			: in 		 std_ulogic;
		 falsch		: out		 std_ulogic;
       done_z_o     : out     std_ulogic;
		 out_bin		: out 	std_ulogic_vector(3 downto 0)); 
end entity;

architecture rtl of cntblnk is 

--signal d,q : integer;
	signal d,q	: unsigned(3 downto 0);
	
begin


	q <= "0000" when rst_n = '0' else d when rising_edge(clk);
	
	d <= q when enable = '0' else q + 1;

	out_bin <= std_ulogic_vector(d);
	
	
/*
	d <= 1 when enable = '0' else q + 1 when gen = '0' else 0;
	
	done_z_o <= '1' when d = 22 else '0';
	falsch <= '1' when d = 0 else '0';
*/	
end architecture rtl;





/*


entity cntblnk is 
port ( clk        : in      std_ulogic;
       rst_n      : in      std_ulogic; 
       ld_short_i : in      std_ulogic;
       ld_long_i  : in      std_ulogic; 
       done_o     : out     std_ulogic); 
end entity;

architecture rtl of cntblnk is 

signal d,q : integer;
--signal d,q	: unsigned(26 downto 0);
	
begin

--	q <= "000000000000000000000000000" when rst_n = '0' else d when rising_edge(clk);
	q <= 0 when rst_n = '0' else d when rising_edge(clk);

	d <= 25000000 when ld_short_i = '1' else 100000000 when ld_long_i = '1' else q when q = 0 else q-1;
--	d <= "001011111010111100001000000" when ld_short_i = '1' else "101111101011110000100000000" when ld_long_i = '1' else q when q = 0 else q-1;
	
	done_o <= '1' when q = 0 else '0';
		
end architecture rtl;
*/