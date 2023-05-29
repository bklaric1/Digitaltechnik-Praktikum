library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Add two 4 Bit numbers
entity add4 is 
port ( a_i   : in      std_ulogic_vector(3 downto 0);
       b_i   : in      std_ulogic_vector(3 downto 0);
       y_o   : out     std_ulogic_vector(3 downto 0));    
end entity;

architecture rtl of add4 is

  signal a,b,sum : unsigned(3 downto 0);

begin

  -- Typecast of the std_ulogic_vector type inputs to type unsigned
  a <= unsigned(a_i);
  b <= unsigned(b_i);

  -- Add
  sum <= a + b;

  -- Typecast the result of the additon from unsigned to std_ulogic_vector
  -- for the output.
  y_o <= std_ulogic_vector(sum);
 
end architecture rtl;
