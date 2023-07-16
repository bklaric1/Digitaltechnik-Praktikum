library ieee;
use ieee.std_logic_1164.all;

entity de1_seq is 
  port ( CLOCK_50 : in  std_ulogic; 
         SW       : in  std_ulogic_vector(3 downto 0); 
         KEY0     : in  std_ulogic;
			KEY2     : in  std_ulogic;
         EXP_PIN2 : out std_ulogic;
         EXP_PIN4 : out std_ulogic;
         EXP_PIN6 : out std_ulogic; 
			HEX0		: out std_ulogic_vector(6 downto 0);
			HEX1		: out std_ulogic_vector(6 downto 0);
			HEX2		: out std_ulogic_vector(6 downto 0);
			HEX3		: out std_ulogic_vector(6 downto 0);
         LEDR     : out std_ulogic_vector(9 downto 0));
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
			  --done_z		  : in   std_ulogic; --nur fur lange sequenz
			  --falsch_i	  : in   std_ulogic; --nur fur lange sequenz
			  --enable_o	  : out  std_ulogic; --nur fur lange sequenz
           done_o      : out  std_ulogic);  
  end component;

  component cntblnk is 
    port (  clk        : in      std_ulogic;
				rst_n      : in      std_ulogic; 
				enable	  : in		std_ulogic;
				--gen		  : in 		std_ulogic; --nur fur lange sequenz
				--falsch	  : out	   std_ulogic; --nur fur lange sequenz
				--done_z_o   : out     std_ulogic); --nur fur lange sequenz
				out_bin	  : out 		std_ulogic_vector(15 downto 0)); 
  end component;
  
  component bin2seg is
   port (   bin_i   : in      std_ulogic_vector(3 downto 0);
            seg_o   : out     std_ulogic_vector(6 downto 0));
	end component;		
  
  signal ser, done : std_ulogic;
  --signal enable_i, falsch_i1, done_i : std_ulogic;  --nur fur lange sequenz
  signal bin : std_ulogic_vector(15 downto 0);

begin

  seqgen_i0 : seqgen
    port map (
      clk    => CLOCK_50,
      rst_n  => KEY2,
      ctrl_i => SW,
      ser_o  => ser);
	
	seqdet_i0 : seqdet
	 port map (
		clk	=> CLOCK_50,
		rst_n	=> KEY2,
		ser_i	=> ser,
		--done_z => done_i, --nur fur lange sequenz
		--falsch_i => falsch_i1, --nur fur lange sequenz
		--enable_o => enable_i, --nur fur lange sequenz
		done_o=> done);
		
	zaehler_i0 : cntblnk
	 port map (
	  clk    => CLOCK_50,
     rst_n  => KEY2,
	  enable => done,
	--  gen    => ser, --nur fur lange sequenz
	--  falsch => falsch_i1, --nur fur lange sequenz
	--  done_z_o => done_i, --nur fur lange sequenz
	  out_bin=> bin);

	  
	 bin2seg_i0 : bin2seg
	  port map (
	   bin_i => bin(3 downto 0),
		seg_o => HEX0);
		
	 bin2seg_i1 : bin2seg
	  port map (
	   bin_i => bin(7 downto 4),
		seg_o => HEX1);
		
	 bin2seg_i2 : bin2seg
	  port map (
	   bin_i => bin(11 downto 8),
		seg_o => HEX2);
		
	 bin2seg_i3 : bin2seg
	  port map (
	   bin_i => bin(15 downto 12),
		seg_o => HEX3);
  
  EXP_PIN2 <= CLOCK_50;
  EXP_PIN4 <= ser;
  EXP_PIN6 <= done; 
  
  LEDR(3 downto 0) <= SW;
  LEDR(8 downto 4) <= "00000"; 
  LEDR(9) <= done;

end architecture rtl;
