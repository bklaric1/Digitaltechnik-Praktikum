library ieee;
use ieee.std_logic_1164.all;

-- Two switchcounters count the number of active ones. 
entity de1_ledcntsw is 
port ( SW   : in      std_ulogic_vector(9 downto 0);
       LEDG : out     std_ulogic_vector(7 downto 0);   -- green LEDs
       LEDR : out     std_ulogic_vector(9 downto 0));  -- red LEDs
end entity de1_ledcntsw;

architecture rtl of de1_ledcntsw is

  signal cnt0, cnt1 : std_ulogic_vector(2 downto 0); 

  -- Component declaration for the countones module
  component cntones is 
  port ( switches_i   : in      std_ulogic_vector(3 downto 0);
         cnt_o        : out     std_ulogic_vector(2 downto 0));  
  end component cntones;

begin

  -- Show the switch state at the red leds
  LEDR <= SW; 

  ----------------------------------------------------------------------------
  -- Instantiate the cntones module two times with different input and output signals
  ----------------------------------------------------------------------------
  cntones_i0 : cntones
  port map (
    switches_i => SW(3 downto 0),
    cnt_o      => LEDG(2 downto 0)); 

  cntones_i1 : cntones
  port map (
    switches_i => SW(9 downto 6),
    cnt_o      => LEDG(7 downto 5));

  -- Switch off the unused green leds
  LEDG(4 downto 3) <= "00"; 
 
end architecture rtl;
