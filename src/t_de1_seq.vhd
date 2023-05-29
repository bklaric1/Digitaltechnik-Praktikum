library ieee;
use ieee.std_logic_1164.all;

entity t_de1_seq is
end; 

architecture tbench of t_de1_seq is

  component de1_seq is 
  port ( CLOCK_50 : in  std_ulogic; 
         SW       : in  std_ulogic_vector(3 downto 0); 
         KEY0     : in  std_ulogic;
         EXP_PIN2 : out std_ulogic;
         EXP_PIN4 : out std_ulogic;
         EXP_PIN6 : out std_ulogic; 
         LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
  end component;

  signal redleds                : std_ulogic_vector(9 downto 0);
  signal clk, rst_n             : std_ulogic;
  signal simstop                : boolean := false;
  signal exp2, exp4, exp6       : std_ulogic;
  signal schalter               : std_ulogic_vector(3 downto 0) := "0000";

begin

  de1_seq_i0 : de1_seq
    port map (
      CLOCK_50            => clk,
      SW                  => schalter,
      KEY0                => rst_n,
      EXP_PIN2            => exp2,
      EXP_PIN4            => exp4,
      EXP_PIN6            => exp6,
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
    wait for 100 us;
    simstop <= true; 
    wait; 
  end process schalter_p;

end; -- architecture
