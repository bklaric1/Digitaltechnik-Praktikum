library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cnt14 is 
port ( clk    : in      std_ulogic;
       rst_n  : in      std_ulogic; 
       done_o : out     std_ulogic;
       cnt_o  : out     std_ulogic_vector(3 downto 0)); 
end entity;

architecture rtl of cnt14 is 

signal d, q		: unsigned(3 downto 0); 


begin

q <= "0000" when rst_n = '0' else d when rising_edge(clk);

d <= "0000" when q = "1110" else q + 1; 

done_o <= '1' when q = 14 else '0';	
cnt_o <= std_ulogic_vector(q);

end architecture rtl;