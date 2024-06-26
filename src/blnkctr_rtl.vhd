library ieee;
use ieee.std_logic_1164.all;

entity blnkctr is 
port ( clk         : in  std_ulogic;
       rst_n       : in  std_ulogic;       
       schalter_i  : in  std_ulogic;
       ld_short_o  : out std_ulogic;
       ld_long_o   : out std_ulogic;
       done_i      : in  std_ulogic;
       led_o       : out std_ulogic_vector(9 downto 0));  
end entity;

architecture rtl of blnkctr is

type state_t is (idle1,idle2,A,A2,B,B2,C,C2); --States that we need for this Automat
signal current_state, next_state : state_t;

begin

current_state <= idle1 when rst_n = '0' else next_state when rising_edge(clk);

	process(current_state,next_state,schalter_i,done_i)
	begin
		case current_state is
		
			when idle1 => if schalter_i = '1' then next_state <= A; else next_state <= idle1; --Start State
			end if;
			led_o <= "1010101010"; --Set the start output and load signals for the counter
			ld_short_o <= '0';
			ld_long_o <= '0';
			
			when A => ld_short_o <= '1'; --First counter state that recieves ld_short_o = 1 and counts for 0.5s
						 ld_long_o <= '0';
						 next_state <= A2; --Transition to output state from counter
						 
			when A2 => 
			if done_i = '1' then next_state <= B; else next_state <= A2; --Checks if the counter did his thing, if not, then wait
			end if;
			led_o <= "1100000000"; --Set the first state and load signals back to 0
			ld_short_o <= '0';
			ld_long_o <= '0';
			
			when B => ld_short_o <= '0'; 
						 ld_long_o <= '1'; --Second counter that recieves ld_long_o = 1 and counts for 2s
						 next_state <= B2; --Transition to output state from counter
						 
			when B2 =>
			if done_i = '1' then next_state <= C; else next_state <= B2; --Checks if the counter did his thing, if not, then wait
			end if;
			led_o <= "0000110000";
			ld_long_o <= '0';
			ld_short_o <= '0';
			
			when C => ld_short_o <= '1'; --Third counter state that recieves ld_short_o = 1 and counts for 0.5s
						 ld_long_o <= '0';
						 next_state <= C2; --Transition to output state from counter
						 
			when C2 =>
			if done_i = '1' then next_state <= idle2; else next_state <= C2; --Checks if the counter did his thing, if not, then wait
			end if;
			led_o <= "0000000011";
			ld_short_o <= '0';
			ld_long_o <= '0';
			
			when idle2 => if schalter_i = '0' then next_state <= idle1; else next_state <= idle2; --Second idle state that waits for the switch to be turned off
			end if;
			led_o <= "1010101010";
			ld_short_o <= '0';
			ld_long_o <= '0';
			
			when others => next_state <= idle1; --required
			led_o <= "1010101010";
			ld_short_o <= '0';
			ld_long_o <= '0';
			
		end case;
	end process;

end architecture rtl;
