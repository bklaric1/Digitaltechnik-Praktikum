library ieee;
use ieee.std_logic_1164.all;

entity de1_blnkauto is 
  port ( CLOCK_50 : in  std_ulogic; 
         SW0      : in  std_ulogic; 
         KEY0     : in  std_ulogic; 
         LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
end entity;

architecture rtl of de1_blnkauto is

  component blnkctr is 
    port ( clk         : in  std_ulogic;
           rst_n       : in  std_ulogic;       
           schalter_i  : in  std_ulogic;
           ld_short_o  : out std_ulogic;
           ld_long_o   : out std_ulogic;
           done_i      : in  std_ulogic;
           led_o       : out std_ulogic_vector(9 downto 0));  
  end component;

  component cntblnk is 
    port ( clk        : in      std_ulogic;
           rst_n      : in      std_ulogic; 
           ld_short_i : in      std_ulogic;
           ld_long_i  : in      std_ulogic; 
           done_o     : out     std_ulogic); 
  end component;

begin

end architecture rtl;
