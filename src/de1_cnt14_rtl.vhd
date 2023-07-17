library ieee;
use ieee.std_logic_1164.all;

entity de1_cnt14 is 
port ( KEY0      			: in  	std_ulogic; --dient als rst_n
		 CLOCK_50 			: in		std_ulogic; --interne 50MHz Clock
		 LEDG  			   : out 	std_ulogic_vector(7 downto 0);   -- green LEDs
		 CLOCK_50_OUT 		: out		std_ulogic; --clock50 Ausgang auf GPIO1
		 DONE_O				: out		std_ulogic; --done_o Ausgang auf GPIO1
		 CNT_O				: out		std_ulogic_vector(3 downto 0)); --cnt_o Ausgang auf GPIO1
		
end entity;

architecture rtl of de1_cnt14 is

  component cnt14 is
    port ( clk     : in  std_ulogic;
           rst_n  : in  std_ulogic;
           done_o : out std_ulogic;
           cnt_o  : out std_ulogic_vector(3 downto 0)); 
  end component;

  signal cnt : std_ulogic_vector(3 downto 0);
  signal done1 : std_ulogic;
  
begin

	DONE_O <= done1;
	CNT_O <= cnt;
	
  cnt14_i0 : cnt14
    port map (
	   clk => CLOCK_50,
      rst_n  => KEY0,
      done_o => done1,
      cnt_o  => cnt);
		
	LEDG(0) <= KEY0;
	LEDG(7 downto 1) <= "0000000";
    
end architecture rtl;
