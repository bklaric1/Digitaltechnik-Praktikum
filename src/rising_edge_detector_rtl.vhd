library ieee;
use ieee.std_logic_1164.all;

entity rising_edge_detector is
  port (
    clk    : in  std_ulogic;
    rst_n  : in  std_ulogic;
    x_i    : in  std_ulogic;
    rise_o : out std_ulogic
    );
end rising_edge_detector;

architecture rtl of rising_edge_detector is
  signal q0, q1 : std_ulogic; 
begin

  -- Flipflops
q0 <= '0' when rst_n = '0' else x_i when rising_edge(clk);
q1 <= '0' when rst_n = '0' else q0  when rising_edge(clk);

rise_o <= q0 and not q1;

end architecture rtl;

