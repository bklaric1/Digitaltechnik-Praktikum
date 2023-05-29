library ieee;
use ieee.std_logic_1164.all;

entity t_de1_blnkauto is
end; 

architecture tbench of t_de1_blnkauto is

  component de1_blnkauto is 
  port ( CLOCK_50 : in  std_ulogic; 
         SW0      : in  std_ulogic; 
         KEY0     : in  std_ulogic; 
         LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
  end component;


  signal redleds                : std_ulogic_vector(9 downto 0);
  signal clk, rst_n             : std_ulogic;
  signal simstop                : boolean := false;
  signal schalter               : std_ulogic;

begin

  de1_blnkauto_i0 : de1_blnkauto
    port map (
      CLOCK_50            => clk,
      SW0                 => schalter,
      KEY0                => rst_n,
      LEDR                => redleds);

  rst_n <= '1', '0' after 20 ns, '1' after 40 ns;

  clk_p : process
    begin
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
      if simstop then
        wait;
      end if;
    end process clk_p;

  -- This is the process where the switches are switched.
  schalter_p : process
  begin
    schalter <= '0';
    wait until rising_edge(rst_n);
    wait until falling_edge(clk);
    schalter <= '1';
    wait for 300 ns;
    schalter <= '0';
    wait for 300 ns;
    schalter <= '1';
    wait for 300 ns;
    schalter <= '0';
    wait for 400 ns;
    simstop <= true; 
    wait; 
  end process schalter_p;

end; -- architecture
