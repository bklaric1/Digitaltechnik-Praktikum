library ieee;
use ieee.std_logic_1164.all;

entity t_de1_play is
end t_de1_play;

architecture tbench of t_de1_play is

component de1_play is
  port (
    CLOCK_50 : in  std_ulogic;                    -- 50 mhz clock
    KEY      : in  std_ulogic_vector(1 downto 0); -- key(1..0)
    LEDR     : out std_ulogic_vector(4 downto 0); -- red LED(4..0)
    LEDG     : out std_ulogic_vector(1 downto 0)  -- green LED(1..0)
    );
end component;

  -- definition of a clock period
  constant period : time    := 10 ns;
  -- switch for clock generator
  signal clken_p  : boolean := true;


  signal clk_i    : std_ulogic;
  signal rst_ni   : std_ulogic;
  signal key      : std_ulogic;
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
  
  -- initial reset, always necessary at the beginning of a simulation
  reset : rst_ni <= '0', '1' AFTER period;

  stimuli_p : process
    begin
      key <= '1';     
      wait until rst_ni = '1';      
      wait for 15*period;
      wait until falling_edge(clk_i) and ledr = "00010"; 
      key <= '0';
      wait until falling_edge(clk_i) and ledr = "00100"; 
      wait for period;
      key <= '1'; 
      wait for period;
      key <= '0';
      wait for 1 * period;
      key <= '1';
      wait until falling_edge(clk_i) and ledr = "10000";
      for i in 0 to 100 loop
        wait until falling_edge(clk_i);
        assert ledr = "10000" or ledr = "00001" report "hit error";
      end loop;
      wait until falling_edge(clk_i) and ledr = "00001";
      clken_p <= false;
      wait;    
  end process stimuli_p;


  de1_play_i0 : de1_play
    port map (
      CLOCK_50  => clk_i,
      KEY(0)    => rst_ni,
      KEY(1)    => key,
      LEDR      => ledr);
      
  simstop_p : process
  begin
    wait on clken_p for 2000 ns;     
    assert not clken_p report "Simulation failed due to timeout" severity failure;
    wait; 
  end process; 

end tbench;
