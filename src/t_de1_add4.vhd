library ieee;
use ieee.std_logic_1164.all;

entity t_de1_add4 is
end; 

architecture tbench of t_de1_add4 is

-- This is the component declaration 
  component de1_add4 is 
  port ( SW   : in      std_ulogic_vector(9 downto 0);
         HEX0 : out     std_ulogic_vector(6 downto 0);
         HEX1 : out     std_ulogic_vector(6 downto 0);
         HEX2 : out     std_ulogic_vector(6 downto 0);
         LEDG : out     std_ulogic_vector(7 downto 0);
         LEDR : out     std_ulogic_vector(9 downto 0));  
  end component;

  signal switches, redleds : std_ulogic_vector(9 downto 0);
  signal greenleds         : std_ulogic_vector(7 downto 0);  
  signal hex0,hex1,hex2    : std_ulogic_vector(6 downto 0); 

begin

  de1_add4_i0 : de1_add4
    port map (
      SW                  => switches,
      HEX0                => hex0,
      HEX1                => hex1,
      HEX2                => hex2,
      LEDG                => greenleds, 
      LEDR                => redleds);

  -- This is the process where the switches are switched.
  schalter : process
  begin
    wait for 1 us; 
    switches <= "0000000001";
    wait for 1 us;
    switches <= "1000000000";
    wait for 1 us; 
    switches <= "0011000111";
    wait for 1 us;
    switches <= "1001000011"; 
    wait for 1 us;
    switches <= "1111111111";
    wait for 1 us; 
    wait;                               -- wait forever
  end process schalter;

end; -- architecture
