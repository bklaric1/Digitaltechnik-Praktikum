library ieee;
use ieee.std_logic_1164.all;

-- Count the number of '1' in the switches_i signal
-- Example: "1011" should give "011" at cnt_o as there are 3 ones active.
entity bin2seg is 
port ( bin_i   : in      std_ulogic_vector(3 downto 0);
       seg_o   : out     std_ulogic_vector(6 downto 0));  
end entity bin2seg;

architecture rtl of bin2seg is 

begin

  -- This counts the number of ones in switches_i. 
  -- The result is computed as binary number.    
  with bin_i select
    seg_o <=
    "1000000" when "0000", 
    "1111001" when "0001",
    "0100100" when "0010",
    "0110000" when "0011",
    "0011001" when "0100",
 	 "0010010" when "0101",
    "0000010" when "0110",
    "1111000" when "0111",
 	 "0000000" when "1000",
    "0010000" when "1001",
    "0001000" when "1010",
 	 "0000011" when "1011",
    "1000110" when "1100",
    "0100001" when "1101",
 	 "0000110" when "1110",
    "0001110" when "1111",
    "1111111" when others; -- required  
 
end architecture rtl;
