library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Loadable downcounter which stops when cnt is 0
-- The done_o output is 1, when cnt is 0;
-- When ld_i is '1', the counter is loaded with a startvalue of 13
-- The cnt_o output shows the current value of the counter

entity cnt15 is 
port ( clk    : in      std_ulogic;
       rst_n  : in      std_ulogic; 
       ld_i   : in      std_ulogic;
       done_o : out     std_ulogic;
       cnt_o  : out     std_ulogic_vector(3 downto 0)); 
end entity;

architecture rtl of cnt15 is 

signal d, q		: unsigned(3 downto 0); --besser mit unsigned zu arbeiten, weil man arithmetische Operationen machen kann(=, -, <, >, usw.)


begin

q <= "0000" when rst_n = '0' else d when rising_edge(clk); --4 Flipflops initializieren

d <= "1101" when ld_i = '1' else q when q = 0 else q - 1; --Eingaenge von Flipflops setzen in Abhaengigkeit von q, also wenn ld_1 = 1 ist,
																			 --dann wird 13 eingeschrieben, wenn nicht, dann pruefen wir ob q = 0 ist, when nicht,
																			 --dann zaehlen wir rueckwaerts. 

done_o <= '1' when q = 0 else '0';								 --einfache Setzung von done_o in Abhaengigkeit von q.
cnt_o <= std_ulogic_vector(q);									 --Setzen von cnt_o, die uns Zustand des Zaehlers zeigt.

end architecture rtl;