library ieee;
use ieee.std_logic_1164.all;

entity t_de1_majority is
end; 

architecture tbench of t_de1_majority is

  component de1_majority is 
    port ( SW       : in  std_ulogic_vector(9 downto 0);
           HEX0     : out std_ulogic_vector(6 downto 0);
           HEX1     : out std_ulogic_vector(6 downto 0);
           HEX2     : out std_ulogic_vector(6 downto 0);
           HEX3     : out std_ulogic_vector(6 downto 0);
           LEDG     : out std_ulogic_vector(7 downto 0);
           LEDR     : out std_ulogic_vector(9 downto 0)); 
  end component;

  signal switches, redleds      : std_ulogic_vector(9 downto 0);
  signal greenleds              : std_ulogic_vector(7 downto 0);  
  signal hex0,hex1,hex2,hex3    : std_ulogic_vector(6 downto 0); 

begin

  de1_majority_i0 : de1_majority
    port map (
      SW                  => switches,
      HEX0                => hex0,
      HEX1                => hex1,
      HEX2                => hex2,
      HEX3                => hex3,
      LEDG                => greenleds, 
      LEDR                => redleds);

  -- This is the process where the switches are switched.
  schalter : process
  begin
    wait for 1 us; 
    switches <= "0000000001";
    wait for 1 us;
    switches <= "1001000000";
    wait for 1 us; 
    switches <= "0011000111";
    wait for 1 us;
    switches <= "1001101011"; 
    wait for 1 us;
    switches <= "1111111111";
    wait for 1 us; 
    wait;                               -- wait forever
  end process schalter;

end; -- architecture
