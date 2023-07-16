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

  component cntblnk1 is 
    port ( clk        : in      std_ulogic;
           rst_n      : in      std_ulogic; 
           ld_short_i : in      std_ulogic;
           ld_long_i  : in      std_ulogic; 
           done_o     : out     std_ulogic); 
  end component;
  
  signal ld_short, ld_long, done : std_ulogic;

begin

	Zaehler : cntblnk1
		port map (
			clk => CLOCK_50,
			rst_n => KEY0,
			ld_short_i => ld_short,
			ld_long_i => ld_long,
			done_o => done);
			
	Automat : blnkctr
		port map (
		clk => CLOCK_50,
		rst_n => KEY0,
		schalter_i => SW0,
		ld_short_o => ld_short,
		ld_long_o => ld_long,
		done_i => done,
		led_o => LEDR);
		

end architecture rtl;
