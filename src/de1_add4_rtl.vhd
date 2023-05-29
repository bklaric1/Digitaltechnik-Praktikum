library ieee;
use ieee.std_logic_1164.all;

entity de1_add4 is 
port ( SW   : in      std_ulogic_vector(9 downto 0);
       HEX0 : out     std_ulogic_vector(6 downto 0);
       HEX1 : out     std_ulogic_vector(6 downto 0);
       HEX2 : out     std_ulogic_vector(6 downto 0);
       LEDG : out     std_ulogic_vector(7 downto 0);
       LEDR : out     std_ulogic_vector(9 downto 0));
end entity;

architecture rtl of de1_add4 is
  
  component bin2seg is 
  port ( bin_i   : in      std_ulogic_vector(3 downto 0);
         seg_o   : out     std_ulogic_vector(6 downto 0));  
  end component;

  component add4 is 
  port ( a_i   : in      std_ulogic_vector(3 downto 0);
         b_i   : in      std_ulogic_vector(3 downto 0);
         y_o   : out     std_ulogic_vector(3 downto 0));    
  end component;
  
  signal res : std_ulogic_vector(3 downto 0);

begin

 LEDR <= SW;

  a : bin2seg
  port map (
		bin_i => SW(3 downto 0),
		seg_o => HEX0(6 downto 0)); 
 
  b : bin2seg
  port map (
		bin_i => SW(9 downto 6),
		seg_o => HEX1(6 downto 0));
 
	y : add4
	port map (
		a_i => SW(3 downto 0),
		b_i => SW(9 downto 6),
		y_o => res);
	
   res_0 : bin2seg
  port map (
		bin_i => res,
		seg_o => HEX2(6 downto 0));
		
	LEDG(3 downto 0) <= res;
	LEDG(7 downto 4) <= "0000";

  
end architecture rtl;
