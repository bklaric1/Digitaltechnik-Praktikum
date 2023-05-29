library ieee;
use ieee.std_logic_1164.all;

entity de1_play is
  port (
    CLOCK_50 : in  std_ulogic;                    -- 50 mhz clock
    KEY      : in  std_ulogic_vector(1 downto 0); -- key(1..0)
    LEDR     : out std_ulogic_vector(4 downto 0); -- red LED(4..0)
    LEDG     : out std_ulogic_vector(1 downto 0)  -- green LED(1..0)
    );
end de1_play;

architecture structure of de1_play is

  component count1s
    port (
      clk         : in  std_ulogic;
      rst_n       : in  std_ulogic;
      onesec_o    : out std_ulogic);
  end component;

  component rising_edge_detector
    port (
      clk    : in  std_ulogic;
      rst_n  : in  std_ulogic;
      x_i    : in  std_ulogic;
      rise_o : out std_ulogic);
  end component;

  component play is
  port (clk        : in  std_ulogic;
        rst_n      : in  std_ulogic;
        onesec_i   : in  std_ulogic;
        key_i      : in  std_ulogic;
        led_o      : out std_ulogic_vector(4 downto 0));
  end component;

  signal clk      : std_ulogic;
  signal rst_n    : std_ulogic;
  signal key_inv  : std_ulogic;
  signal key_edge : std_ulogic;

  signal one_second_period : std_ulogic;

begin

  -- connecting clock generator master clock of synchronous system
  clk <= CLOCK_50;

  -- connecting asynchronous system reset to digital system
  rst_n <= KEY(0);
  -- Invert the pushbutton for controlling play 
  key_inv <= not KEY(1);

  LEDG <= not KEY;                      -- pushbutton on green LED
  
  -- Rising Edge Detection for KEY1 
  rising_edge_detect_i0 : rising_edge_detector
    port map (
      clk    => clk,
      rst_n  => rst_n,
      x_i    => key_inv,
      rise_o => key_edge);

  -- based on the 50 mhz clock, generates an enable signal of period t = 1 sec
  count1s_i0 : count1s
    port map (
      clk         => clk,
      rst_n       => rst_n,               
      onesec_o    => one_second_period);

  play_i0 : play
    port map (
      clk      => clk,
      rst_n    => rst_n,
      onesec_i => one_second_period,
      key_i    => key_edge,
      led_o    => LEDR);

end structure;
