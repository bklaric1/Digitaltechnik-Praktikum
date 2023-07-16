library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--Haufigkeitszahler

entity cntblnk is 
port ( clk        : in      std_ulogic;
       rst_n      : in      std_ulogic; 
		 enable		: in		 std_ulogic;
		 out_bin		: out 	std_ulogic_vector(15 downto 0)); 
end entity;

architecture rtl of cntblnk is 

	signal d,q	: unsigned(15 downto 0);
	
begin


	q <= "0000000000000000" when rst_n = '0' else d when rising_edge(clk);
	
	d <= q when enable = '0' else q + 1;

	out_bin <= std_ulogic_vector(d);
	
end architecture rtl;

/* Lange sequenz zahler (muss man Sachen in top level unkommentieren)
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

  signal d,q : integer;
	
begin

	d <= 1 when enable = '0' else q + 1 when gen = '0' else 0;
	
	done_z_o <= '1' when d = 23 else '0';
	falsch <= '1' when d = 0 else '0';

end architecture rtl;
*/