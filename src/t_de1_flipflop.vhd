library ieee;
use ieee.std_logic_1164.all;

entity t_de1_flipflop is
end; 

architecture tbench of t_de1_flipflop is

  component de1_flipflop is 
    port ( SW       : in  std_ulogic_vector(9 downto 0);
           KEY      : in  std_ulogic_vector(3 downto 0); 
           LEDG     : out std_ulogic_vector(7 downto 0);   -- green LEDs
           LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
  end component;

  signal redleds                : std_ulogic_vector(9 downto 0);
  signal greenleds              : std_ulogic_vector(7 downto 0);
  signal clk, rst_n             : std_ulogic;
  signal simstop                : boolean := false;
  signal d                      : std_ulogic;

begin

  de1_flipflop_i0 : de1_flipflop
    port map (
      SW(0)               => d,
      SW(9 downto 1)      => "000000000",
      KEY(0)              => rst_n,
      KEY(1)              => clk,
      KEY(3 downto 2)     => "00",
      LEDG                => greenleds, 
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
  schalter : process
  begin
    d <= '0';
    wait until rising_edge(rst_n);
    wait until falling_edge(clk);
    d <= '1';
    wait for 40 ns;
    d <= '0';
    wait for 80 ns;
    simstop <= true; 
    wait; 
  end process schalter;

end; -- architecture
