library ieee;
use ieee.std_logic_1164.all;
 
entity de1_bin2seg is 
port ( SW   : in      std_ulogic_vector(9 downto 0);
		 HEX0 : out		 std_ulogic_vector(6 downto 0);
		 HEX1 : out		 std_ulogic_vector(6 downto 0);
       LEDR : out     std_ulogic_vector(9 downto 0));  -- red LEDs
		 
end entity de1_bin2seg;

architecture rtl of de1_bin2seg is

  --signal bin2seg0, bin2seg1 : std_ulogic_vector(2 downto 0); 

  -- Component declaration for the countones module
  component bin2seg is 
  port ( bin_i   : in      std_ulogic_vector(3 downto 0);
         seg_o   : out     std_ulogic_vector(6 downto 0));  
  end component bin2seg;

begin

  -- Show the switch state at the red leds
  LEDR <= SW; 

  ----------------------------------------------------------------------------
  -- Instantiate the bin2seg module two times with different input and output signals
  ----------------------------------------------------------------------------
  bin2seg_i0 : bin2seg
  port map (
    bin_i => SW(3 downto 0),
    seg_o => HEX0(6 downto 0)); 
 
  bin2seg_i1 : bin2seg
  port map (
    bin_i => SW(9 downto 6),
    seg_o => HEX1(6 downto 0));
 
end architecture rtl;
