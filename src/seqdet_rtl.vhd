library ieee;
use ieee.std_logic_1164.all;

entity seqdet is 
port ( clk         : in  std_ulogic;
       rst_n       : in  std_ulogic;       
       ser_i       : in  std_ulogic;
		 done_z		 : in std_ulogic;
		 falsch_i	 : in std_ulogic;
		 enable_o	 : out std_ulogic;
       done_o      : out  std_ulogic);  
end entity;

architecture rtl of seqdet is

type state_t is (N, A, B, C, D, E, F, G);
signal current_state, next_state : state_t;
  
begin

current_state <= A when rst_n = '0' else next_state when rising_edge(clk);

process(current_state, ser_i)

begin

	next_state <= current_state;
	done_o <= '0';
	
	case current_state is 

		when N => if ser_i = '0' then next_state <= A; else next_state <= N;
		done_o <= '0';
		end if;
		
		when A => if ser_i = '1' then next_state <= B; else next_state <= N;
		end if;
		
		when B => if ser_i = '1' then next_state <= C; else next_state <= N;
		end if;
		
		when C => if ser_i = '0' then next_state <= D; else next_state <= N;
		end if;
		
		when D => if ser_i = '1' then next_state <= E; else next_state <= N;
		end if;
		
		when E => if ser_i = '0' then next_state <= F; else next_state <= N;
		end if;
		
		when F => if ser_i = '0' then next_state <= G; else next_state <= N;
		end if;
		
		when G => next_state <= N;
		done_o <= '1';
		
		when others => next_state <= N;
		
	end case;

end process;

/* lange sequenz
type state_t is (A, B, C, C1, D, E, F, G);
signal current_state, next_state : state_t;

begin

current_state <= A when rst_n = '0' else next_state when rising_edge(clk);

process(current_state, ser_i, falsch_i, done_z)

begin

	next_state <= current_state;
	done_o <= '0';
	enable_o <= '0';
	
	case current_state is 

		when A => if ser_i = '1' then next_state <= B; else next_state <= A;
		end if;
		
		when B => if ser_i = '1' then next_state <= C; else next_state <= A;
		end if;
		
		when C => if ser_i = '1' then next_state <= C1; else next_state <= A;
		end if;
		
		when C1 => enable_o <= '1';
		if done_z = '1' and falsch_i = '0' then next_state <= D; 
		elsif falsch_i = '0' then next_state <= C1;
		else next_state <= A; 
		end if;
		
		when D => if ser_i = '1' then next_state <= E; else next_state <= A;
		end if;
		
		when E => if ser_i = '0' then next_state <= F; else next_state <= A;
		end if;
		
		when F => if ser_i = '1' then next_state <= G; else next_state <= A;
		end if;
		
		when G => next_state <= A;
		done_o <= '1';
		
		when others => next_state <= A;
		
	end case;

end process;
/*

/* 0110100
type state_t is (N, A, B, C, D, E, F, G);
signal current_state, next_state : state_t;
  
begin

current_state <= A when rst_n = '0' else next_state when rising_edge(clk);

process(current_state, ser_i)

begin

	next_state <= current_state;
	done_o <= '0';
	
	case current_state is 

		when N => if ser_i = '0' then next_state <= A; else next_state <= N;
		end if;
		
		when A => if ser_i = '1' then next_state <= B; else next_state <= N;
		end if;
		
		when B => if ser_i = '1' then next_state <= C; else next_state <= N;
		end if;
		
		when C => if ser_i = '0' then next_state <= D; else next_state <= N;
		end if;
		
		when D => if ser_i = '1' then next_state <= E; else next_state <= N;
		end if;
		
		when E => if ser_i = '0' then next_state <= F; else next_state <= N;
		end if;
		
		when F => if ser_i = '0' then next_state <= G; else next_state <= N;
		end if;
		
		when G => next_state <= N;
		done_o <= '1';
		
		when others => next_state <= N;
		
	end case;

end process;
	*/
end architecture rtl;