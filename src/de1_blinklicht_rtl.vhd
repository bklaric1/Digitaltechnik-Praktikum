library ieee;
use ieee.std_logic_1164.all;

entity de1_blinklicht is 
port ( SW       : in  std_ulogic_vector(9 downto 0);
       KEY      : in  std_ulogic_vector(3 downto 0); 
       LEDG     : out std_ulogic_vector(7 downto 0);   -- green LEDs
       LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
end entity;

architecture rtl of de1_blinklicht is

  type state_t is (start, schritt1, schritt2a, schritt2b, schritt3); --enumeric data types initialization (used as states in automation)
  signal current_state, next_state : state_t; --created signals which are type state_t, used as a states
  signal rst_n,clk   : std_ulogic; --standard flipflop things

begin

current_state <= start when rst_n = '0' else next_state when rising_edge(clk); 

		/*
		--setting the first state depending on reset
		if(rst_n = '0') then current_state <= start;
		--setting the next state depending on rising_edge(clk)
		elsif rising_edge(clk) then current_state <=next_state;
		end if;
	*/

blinklicht : process(current_state, next_state, SW(0)) --sensitivity list with things that are going to be read out of
begin

		--case when statement is used when we have more paths we can take depending on the value of the input signal or expression
		case current_state is

			--going from start state, where all leds are turned off, to schritt1
			when start => next_state <= schritt1;
			LEDR <= "0000000000";
			
			--checking if the SW(0) is turned on or off and then depending on the value, setting the next path
			when schritt1 => if(SW(0) = '0') then next_state <= schritt2a; else next_state <= schritt2b;
			end if;
			LEDR <= "1110000111";

			--setting the next path
			when schritt2a => next_state <= schritt3;
			LEDR <= "0111001110";
			
			--setting the next path
			when schritt2b => next_state <= schritt3;
			LEDR <= "0101010101";

			--setting the next path
			when schritt3 => next_state <= schritt1;
			LEDR <= "0001111000";
			
			--setting the undefined states if they are to appear
			when others => next_state <= schritt1;
			LEDR <= "0000000000";

		end case;
end process;
    
  ---------------------------------------------------------
  -- Connections to switches, leds and keys
  ---------------------------------------------------------
  rst_n   <= KEY(0);         -- KEYS are 0 when pushed...
  clk     <= KEY(1);         -- KEYS are 0 when pushed...
  LEDG(0) <= rst_n;
  LEDG(1) <= clk; 

end architecture rtl;
