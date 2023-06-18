library ieee;
use ieee.std_logic_1164.all;

entity seqdet is 
port ( clk         : in  std_ulogic;
       rst_n       : in  std_ulogic;       
       ser_i       : in  std_ulogic;
       done_o      : out  std_ulogic);  
end entity;

architecture rtl of seqdet is

type state_t is (idle, A, B, C, D, E, F, G);
signal current_state, next_state : state_t;
  
begin

current_state <= A when rst_n = '0' else next_state when rising_edge(clk);

process(current_state, next_state, ser_i)

begin

	case current_state is 
	
		when idle => if ser_i = '1' then next_state <= idle; else next_state <= idle; --added to test the machine manually
		end if;
		done_o <= '1';
		

		when A => if ser_i = '1' then next_state <= B; else next_state <= A;
		end if;
		done_o <= '0';
		
		when B => if ser_i = '1' then next_state <= C; else next_state <= A;
		end if;
		done_o <= '0';
		
		when C => if ser_i = '0' then next_state <= D; else next_state <= A;
		end if;
		done_o <= '0';
		
		when D => if ser_i = '1' then next_state <= E; else next_state <= A;
		end if;
		done_o <= '0';
		
		when E => if ser_i = '0' then next_state <= F; else next_state <= A;
		end if;
		done_o <= '0';
		
		when F => if ser_i = '0' then next_state <= G; else next_state <= A;
		end if;
		done_o <= '0';
		
		--when G => if ser_i = '1' then next_state <= idle; else next_state <= idle; just for testing purposes
		when G =>  next_state <= A;
		done_o <= '1';
		
		when others => next_state <= A;
		done_o <= '0';
		
	end case;

end process;
		
end architecture rtl;
