	library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cntblnk1 is 
port ( clk        : in      std_ulogic;
       rst_n      : in      std_ulogic; 
       ld_short_i : in      std_ulogic;
       ld_long_i  : in      std_ulogic; 
       done_o     : out     std_ulogic); 
end entity;

architecture rtl of cntblnk1 is 

signal d,q : integer;
--signal d,q	: unsigned(26 downto 0);
	
begin

--	q <= "000000000000000000000000000" when rst_n = '0' else d when rising_edge(clk);
	q <= 0 when rst_n = '0' else d when rising_edge(clk);

	d <= 25000000 when ld_short_i = '1' else 100000000 when ld_long_i = '1' else q when q = 1 else q-1;
--	d <= "001011111010111100001000000" when ld_short_i = '1' else "101111101011110000100000000" when ld_long_i = '1' else q when q = 0 else q-1;
	
	done_o <= '1' when q =  1 else '0';
		
end architecture rtl;


--two variants, integer or unsigned, both work exactly the same