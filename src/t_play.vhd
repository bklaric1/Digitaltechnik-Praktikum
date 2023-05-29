-------------------------------------------------------------------------------
-- module     : de1_play
-------------------------------------------------------------------------------
-- author     : Friedrich Beckmann
-- company    : university of applied sciences augsburg
-------------------------------------------------------------------------------
-- description: test the module play on a de1 prototype board
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity t_play is
end t_play;

architecture tbench of t_play is

  component play is
  port (clk        : in  std_ulogic;
        rst_n      : in  std_ulogic;
        onesec_i   : in  std_ulogic;
        key_i      : in  std_ulogic;
        led_o      : out std_ulogic_vector(4 downto 0));
  end component;
  
  -- definition of a clock period
  constant period : time    := 10 ns;
  -- switch for clock generator
  signal clken_p  : boolean := true;


  signal clk_i    : std_ulogic;
  signal rst_ni   : std_ulogic;
  signal key_edge : std_ulogic;
  signal one_second_period : std_ulogic;
  signal ledr : std_ulogic_vector(4 downto 0);

begin

  -- clock generation
  clock_proc : process
  begin
    while clken_p loop
      clk_i <= '0'; wait for period/2;
      clk_i <= '1'; wait for period/2;
    end loop;
    wait;
  end process;
  
  onesec_p : process
  begin
    one_second_period <= '0';
    wait until falling_edge(clk_i);
    wait until falling_edge(clk_i);
    one_second_period <= '1';
    wait until falling_edge(clk_i);
  end process; 

  -- initial reset, always necessary at the beginning of a simulation
  reset : rst_ni <= '0', '1' AFTER period;

  stimuli_p : process
    begin
      key_edge <= '0';     
      wait until rst_ni = '1';      
      wait for 15*period;
      wait until falling_edge(clk_i) and ledr = "00010"; 
      key_edge <= '1';
      wait until falling_edge(clk_i) and ledr = "00100"; 
      wait for period;
      key_edge <= '0'; 
      wait for 5*period;
      wait until falling_edge(clk_i) and ledr = "00001"; 
      key_edge <= '1';
      wait for 5*period;
      wait until falling_edge(clk_i) and ledr = "00100"; 
      key_edge <= '0';  
      wait for 15*period; 
      clken_p <= false;
      wait;    
  end process stimuli_p;


  play_i0 : play
    port map (
      clk      => clk_i,
      rst_n    => rst_ni,
      onesec_i => one_second_period,
      key_i    => key_edge,
      led_o    => ledr);
      
  simstop_p : process
  begin
    wait on clken_p for 800 ns;     
    assert not clken_p report "Simulation failed due to timeout" severity failure;
    wait; 
  end process; 

end tbench;
