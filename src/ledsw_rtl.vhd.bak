library ieee;
use ieee.std_logic_1164.all;

-- Simple module that connects the SW switches to the LEDR lights
entity ledsw is 
port ( SW   : in      std_ulogic_vector(9 downto 0);
       LEDR : out     std_ulogic_vector(9 downto 0));  -- red LEDs
end entity ledsw;

architecture rtl of ledsw is
begin
  LEDR <= SW;
end architecture rtl;
