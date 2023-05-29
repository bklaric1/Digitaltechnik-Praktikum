library ieee;
use ieee.std_logic_1164.all;

entity de1_flipflop is 
port ( SW       : in  std_ulogic_vector(9 downto 0);
       KEY      : in  std_ulogic_vector(3 downto 0); 
       LEDG     : out std_ulogic_vector(7 downto 0);   -- green LEDs
       LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
end entity;

architecture rtl of de1_flipflop is

  signal rst_n,clk   : std_ulogic; 
  signal d,q         : std_ulogic; -- for single fliplop
  signal d0,d1,q0,q1 : std_ulogic; -- for mod4 counter

begin
    
  --------------------------------------------------------------------
  -- rising edge triggered flipflop with asynchronous low active reset
  --------------------------------------------------------------------
  q <= '0' when rst_n = '0' else d when rising_edge(clk); 
 
  -----------------------------------------------------
  -- Modulo 4 Counter
  -----------------------------------------------------
  -- Flipflops
  q0 <= '0' when rst_n = '0' else d0 when rising_edge(clk);
  q1 <= '0' when rst_n = '0' else d1 when rising_edge(clk); 
  -- Next State Logic
  d0 <= not q0;
  d1 <= q0 xor q1; 

  ---------------------------------------------------------
  -- Connections to switches, leds and keys
  ---------------------------------------------------------
  -- Common connections for flipflop and counter
  rst_n   <= KEY(0);         -- KEYS are 0 when pushed...
  clk     <= KEY(1);         -- KEYS are 0 when pushed...
  LEDG(0) <= rst_n;
  LEDG(1) <= clk; 
  -- Flipflop Connections
  d       <= SW(0);
  LEDG(2) <= q; 
  -- Counter connections
  LEDG(7) <= q1;
  LEDG(6) <= q0;
  LEDG(5) <= d1;
  LEDG(4) <= d0; 
  -- Other connections
  LEDG(3) <= '0'; 
  LEDR    <= SW;  

end architecture rtl;
