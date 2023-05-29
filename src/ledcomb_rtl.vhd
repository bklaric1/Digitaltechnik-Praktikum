library ieee;
use ieee.std_logic_1164.all;

-- Combinational functions computed from switch values shown at the green leds
entity ledcomb is 
port ( SW   : in      std_ulogic_vector(9 downto 0);
       LEDG : out     std_ulogic_vector(7 downto 0);   -- green LEDs
       LEDR : out     std_ulogic_vector(9 downto 0));  -- red LEDs
end entity ledcomb;

architecture rtl of ledcomb is

  signal s0, s1, s3 : std_ulogic;

begin

  -- Show the switch state at the red leds
  LEDR <= SW; 

  ----------------------------------------------------------------------------
  -- Boolean expressions forming boolean functions
  ----------------------------------------------------------------------------
  -- Combinational functions from SW(4..0) shown at green leds
  LEDG(0) <= not SW(0) and SW(1) and SW(2) and SW(3) and not SW(4);
  -- Combinational functions from SW(1..0) shown at green leds          
  s0 <= SW(0) xor SW(1); 
  s1 <= SW(0) and SW(1); 
  LEDG(1) <= s0; 
  LEDG(2) <= s1; 
  LEDG(3) <= s0 or s1;

  ----------------------------------------------------------------------------
  -- Multiplexer via conditional signal assignment
  ----------------------------------------------------------------------------

  LEDG(4) <= s3 when SW(3) = '1' else s1;

  ----------------------------------------------------------------------------
  -- Truthtable direct method (if you have a truthtable...) as with ... select
  ----------------------------------------------------------------------------

  with SW(9 downto 5) select
    s3 <=
    '1' when "11111",
    '1' when "00000",
    '1' when "10101"|"01010",  -- select more than one condition
    '0' when others;           -- last line must be others

  -- This counts the number of ones on SW(9..6). 
  -- The result is computed as binary number.    
  with SW(9 downto 6) select
    LEDG(7 downto 5) <=
    "000" when "0000", 
    "001" when "0001"|"0010"|"0100"|"1000",
    "010" when "0011"|"0101"|"1001"|"0110"|"1010"|"1100",
    "011" when "0111"|"1011"|"1101"|"1110",
    "100" when "1111",
    "100" when others; -- required  

  -- One select value must be "others" because all possible 
  -- combinations must be listed and std_ulogic also has other possible values
  -- than '0' and '1', e.g. 'Z'. However, these values only exist in simulation

end architecture rtl;
