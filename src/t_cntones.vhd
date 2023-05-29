library ieee;
use ieee.std_logic_1164.all;

entity t_cntones is
end; 

architecture tbench of t_cntones is

  component cntones is 
  port ( switches_i   : in      std_ulogic_vector(3 downto 0);
         cnt_o        : out     std_ulogic_vector(2 downto 0));  
  end component cntones;

  signal switches : std_ulogic_vector(3 downto 0);
  signal cnt      : std_ulogic_vector(2 downto 0); 

begin

  -- Here the device under test is instantiated
  cntones_i0 : cntones
    port map (
      switches_i => switches,
      cnt_o      => cnt);

  -- This is the process where the switches are switched.
  schalter : process
  begin
    wait for 1 us; 
    switches <= "0000";
    wait for 3 us;
    switches <= "0001";
    wait for 2 us; 
    switches <= "1001";
    wait for 5 us;
    switches <= "1011"; 
    wait for 4 us;
    switches <= "1111";
    wait for 1 us; 
    wait;                               -- wait forever
  end process schalter;

end; -- architecture
