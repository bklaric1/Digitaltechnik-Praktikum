library ieee;
use ieee.std_logic_1164.all;

-- Count the number of '1' in the switches_i signal
-- Example: "1011" should give "011" at cnt_o as there are 3 ones active.
entity cntones is 
port ( switches_i   : in      std_ulogic_vector(3 downto 0);
       cnt_o        : out     std_ulogic_vector(2 downto 0));  
end entity cntones;

architecture rtl of cntones is 

begin

  -- This counts the number of ones in switches_i. 
  -- The result is computed as binary number.    
  with switches_i select
    cnt_o <=
    "000" when "0000", 
    "001" when "0001"|"0010"|"0100"|"1000",
    "010" when "0011"|"0101"|"1001"|"0110"|"1010"|"1100",
    "011" when "0111"|"1011"|"1101"|"1110",
    "100" when "1111",
    "100" when others; -- required  
 
end architecture rtl;
