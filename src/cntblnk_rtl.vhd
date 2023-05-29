library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Loadable downcounter which stops when cnt is 0
-- The done_o output is 1, when cnt is 0;

entity cntblnk is 
port ( clk        : in      std_ulogic;
       rst_n      : in      std_ulogic; 
       ld_short_i : in      std_ulogic;
       ld_long_i  : in      std_ulogic; 
       done_o     : out     std_ulogic); 
end entity;

architecture rtl of cntblnk is 

begin
  
end architecture rtl;
