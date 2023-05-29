library ieee;
use ieee.std_logic_1164.all;

entity t_add4 is
end; 

architecture tbench of t_add4 is

  component add4 is 
  port ( a_i   : in      std_ulogic_vector(3 downto 0);
         b_i   : in      std_ulogic_vector(3 downto 0);
         y_o   : out     std_ulogic_vector(3 downto 0));    
  end component;

  signal a,b,y : std_ulogic_vector(3 downto 0);

begin

  -- Here the device under test is instantiated
  add4_i0 : add4
    port map (
      a_i => a,
      b_i => b,
      y_o => y);

  -- In this process the values for the summands a and b are set
  schalter : process
  begin
    a <= "0000";
    b <= "0000"; 
    wait for 1 us; 
    a <= "0001";
    b <= "1000"; 
    wait for 1 us;
    a <= "0011";
    b <= "0101"; 
    wait for 1 us;
    a <= "0111";
    b <= "0011"; 
    wait for 1 us;
    a <= "1001";
    b <= "0011"; 
    wait for 1 us;
    a <= "0101";
    b <= "0100"; 
    wait for 1 us;
    a <= "1111";
    b <= "1111"; 
    wait for 1 us; 
    wait;                               -- wait forever
  end process schalter;

end; -- architecture
