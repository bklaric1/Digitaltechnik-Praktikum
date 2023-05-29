library ieee;
use ieee.std_logic_1164.all;

entity t_ledcntsw is
end; 

architecture tbench of t_ledcntsw is

-- This is the component declaration 
  component ledcntsw
  port (
    SW:         in std_ulogic_vector(9 downto 0);
    LEDG:       out std_ulogic_vector(7 downto 0);
    LEDR:       out std_ulogic_vector(9 downto 0)
    );
  end component;

-- Signal declaration for the switches and the leds
  signal switches, redleds : std_ulogic_vector(9 downto 0);
  signal greenleds : std_ulogic_vector(7 downto 0); 

begin

  -- Here the device under test is instantiated
  -- The ledsw circuit is connected to the signals in the testbench
  ledcntsw_i0 : ledcntsw
    port map (
      SW                  => switches,
      LEDG                => greenleds, 
      LEDR                => redleds);

  -- This is the process where the switches are switched.
  schalter : process
  begin
    wait for 1 us; 
    switches <= "0000000001";
    wait for 3 us;
    switches <= "1000000000";
    wait for 2 us; 
    switches <= "0000000001";
    wait for 5 us;
    switches <= "1000000000"; 
    wait for 4 us;
    switches <= "1111111111";
    wait for 1 us; 
    wait;                               -- wait forever
  end process schalter;

end; -- architecture
