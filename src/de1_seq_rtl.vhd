library ieee;
use ieee.std_logic_1164.all;

entity de1_seq is 
  port ( CLOCK_50 : in  std_ulogic; 
         SW       : in  std_ulogic_vector(3 downto 0); 
         KEY0     : in  std_ulogic;
         EXP_PIN2 : out std_ulogic;
         EXP_PIN4 : out std_ulogic;
         EXP_PIN6 : out std_ulogic; 
         LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
end entity;

architecture rtl of de1_seq is
  
  component seqgen is 
    port ( clk         : in  std_ulogic;
           rst_n       : in  std_ulogic;
           ctrl_i      : in  std_ulogic_vector(3 downto 0);
           ser_o       : out std_ulogic);  
  end component;

  component seqdet is 
    port ( clk         : in   std_ulogic;
           rst_n       : in   std_ulogic;       
           ser_i       : in   std_ulogic;
           done_o      : out  std_ulogic);  
  end component;

  signal ser : std_ulogic;

begin

  seqgen_i0 : seqgen
    port map (
      clk    => CLOCK_50,
      rst_n  => KEY0,
      ctrl_i => SW,
      ser_o  => ser);
	
	seqdet_i0 : seqdet
	 port map (
		clk	=> CLOCK_50,
		rst_n	=> KEY0,
		ser_i	=> ser,
		done_o=> LEDR(9));
      
  EXP_PIN2 <= CLOCK_50;
  EXP_PIN4 <= ser;
  EXP_PIN6 <= '0'; 
  
  LEDR(3 downto 0) <= SW;
  LEDR(8 downto 4) <= "00000"; 

end architecture rtl;
