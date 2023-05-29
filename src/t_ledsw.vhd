library ieee;
use ieee.std_logic_1164.all;

-- Testbench for the first switch/led module
-- The switches are switched...

entity t_ledsw is
end; 

architecture tbench of t_ledsw is

-- This is the component declaration 
  component ledsw 
  port (
    SW:         in std_ulogic_vector(9 downto 0);
    LEDR:       out std_ulogic_vector(9 downto 0)
    );
  end component;

-- Signal declaration for the switches and the leds
  signal switches, redleds : std_ulogic_vector(9 downto 0); 

begin

  -- Here the device under test is instantiated
  -- The ledsw circuit is connected to the signals in the testbench
  ledsw_i0 : ledsw
    port map (
      SW                  => switches,
      LEDR                => redleds);

  -- This is the process where the switches are switched. This process is not synthesizable because
  -- of the wait statement.       
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
    wait for 1 us;
    switches <= "1010111111"; 
    wait for 2 us;
    wait;                               -- wait forever
  end process schalter;

end; -- architecture
