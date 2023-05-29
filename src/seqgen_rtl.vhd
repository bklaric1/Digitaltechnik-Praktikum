library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seqgen is 
port ( clk         : in  std_ulogic;
       rst_n       : in  std_ulogic;
       ctrl_i      : in  std_ulogic_vector(3 downto 0);
       ser_o       : out std_ulogic);  
end entity;

architecture rtl of seqgen is
  -- LFSR signals
  signal en : std_ulogic;
  signal sr, newsr: std_ulogic_vector(39 downto 1);
  -- Counter signals
  signal cnt,newcnt,startcnt : unsigned(38 downto 0);
  signal ld : std_ulogic;
  type state_t is (LOAD, RUN);
  signal state : state_t;
  

begin 

  -- Linear Feedback Shift Register
  sr <= (others => '1') when rst_n = '0' else newsr when en = '1' and rising_edge(clk);
  newsr(1) <= sr(39) xor sr(35);
  newsr(39 downto 2) <= sr(38 downto 1);

  -- Downcounter
  cnt <= (others => '0') when rst_n = '0' else newcnt when rising_edge(clk);
  with ctrl_i select
    startcnt <=
    to_unsigned(143, cnt'length)        when "0000",
    to_unsigned(400000000, cnt'length)  when "0001",
    to_unsigned(1000000, cnt'length)    when "0010",
    to_unsigned(10000000, cnt'length)   when "0011",
    to_unsigned(100000000, cnt'length)  when "0100",
    to_unsigned(999, cnt'length)        when others;
    
  newcnt <= startcnt when ld = '1' else
            (others => '0') when cnt = 0 else
            cnt - 1;

  en <= '1' when cnt > 0 else '0';

  -- Statemachine to control the sequence generator
  state <= LOAD when rst_n = '0' else RUN when rising_edge(clk); 
  ld <= '1' when state = LOAD else '0';

  -- Output
  ser_o <= sr(1);
  
end architecture rtl;
