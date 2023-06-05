library ieee;
use ieee.std_logic_1164.all;

entity de1_cnt15_messen is 
port ( SW       : in  std_ulogic_vector(9 downto 0);
       KEY      : in  std_ulogic_vector(3 downto 0);
       HEX0     : out std_ulogic_vector(6 downto 0); 
       LEDG     : out std_ulogic_vector(7 downto 0);   -- green LEDs
       LEDR     : out std_ulogic_vector(9 downto 0);	 -- red LEDs
		 CLOCK_50 : in		std_ulogic;
		 CLOCK_50_OUT : out		std_ulogic;
		 DONE_O	: out		std_ulogic;
		 LD_I		: out		std_ulogic;
		 CNT_O	: out		std_ulogic_vector(3 downto 0);
		 RST_N	: out 	std_ulogic);
		
end entity;

architecture rtl of de1_cnt15_messen is

  component bin2seg is
    port (bin_i  : in  std_ulogic_vector(3 downto 0);
           seg_o : out std_ulogic_vector(6 downto 0));  
  end component;

  component cnt15 is
    port (clk     : in  std_ulogic;
           rst_n  : in  std_ulogic;
           ld_i   : in  std_ulogic;
           done_o : out std_ulogic;
           cnt_o  : out std_ulogic_vector(3 downto 0)); 
  end component;

  signal cnt : std_ulogic_vector(3 downto 0);
  signal done1 : std_ulogic;
  
begin

	CLOCK_50_OUT <= CLOCK_50;
	RST_N <= KEY(0);
	LD_I <= SW(0);
	DONE_O <= done1;
	CNT_O <= cnt;
	
  cnt15_i0 : cnt15
    port map (
      --clk    => KEY(1),
	   clk => CLOCK_50,
      rst_n  => KEY(0),
      ld_i   => SW(0),
      done_o => done1,
      cnt_o  => cnt);

  bin2seg_i0 : bin2seg
    port map (
      bin_i => cnt,
      seg_o => HEX0);

  LEDR <= SW;
  LEDG(0) <= KEY(0);
  LEDG(2) <= done1;
  LEDG(7 downto 4) <= cnt;
  LEDG(3) <= '0'; 
    
end architecture rtl;
