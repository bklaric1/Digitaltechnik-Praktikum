--Copyright 2013,2021 Friedrich Beckmann, Hochschule Augsburg
--
--   Licensed under the Apache License, Version 2.0 (the "License");
--   you may not use this file except in compliance with the License.
--   You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library altera; 
use altera.altera_primitives_components.all;

entity de1_audio is 
  port (
    CLOCK_50:   in std_ulogic;
    KEY0:       in std_ulogic;
    I2C_SCLK:   out std_ulogic;
    I2C_SDAT:   inout std_logic; 
    AUD_ADCLRCK: out std_ulogic;
    AUD_ADCDAT:  in std_ulogic;
    AUD_DACLRCK: out std_ulogic; 
    AUD_DACDAT:  out std_ulogic; 
    AUD_XCK:     out std_ulogic;
    AUD_BCLK:    out std_ulogic; 
    LEDR:       out std_ulogic_vector(9 downto 0));
end; 

architecture struct of de1_audio is

  component audio is
    port (
      clk_i         : in  std_ulogic;
      reset_ni      : in  std_ulogic;
      i2c_sclk_o    : out std_ulogic;
      i2c_dat_i     : in  std_ulogic;
      i2c_dat_o     : out std_ulogic;
      aud_adclrck_o : out std_ulogic;
      aud_adcdat_i  : in  std_ulogic;
      aud_daclrck_o : out std_ulogic;
      aud_dacdat_o  : out std_ulogic;
      aud_xck_o     : out std_ulogic;
      aud_bclk_o    : out std_ulogic;
      adc_data_o    : out std_ulogic_vector(15 downto 0);
      adc_valid_o   : out std_ulogic;
      dac_data_i    : in  std_ulogic_vector(15 downto 0);
      dac_strobe_o  : out std_ulogic);
  end component;

  component ringbuf is 
  port (
    clk_i                  : in std_ulogic;
    reset_ni               : in std_ulogic;
    en_i                   : in std_ulogic; 
    data_i                 : in std_ulogic_vector(15 downto 0); 
    data_o                 : out std_ulogic_vector(15 downto 0));
  end component; 

  signal clk, reset_n          : std_ulogic;
  
  signal i2c_dat_o             : std_ulogic;
  signal i2c_dat_i             : std_ulogic; 

  
  signal adc_valid             : std_ulogic;
  signal dac_strobe            : std_ulogic;
  signal dac_data, adc_data    : std_ulogic_vector(15 downto 0);  
    
begin
  
  reset_n <= KEY0;
  clk     <= CLOCK_50;

  audio_i0 : audio
    port map (
      clk_i => clk,
      reset_ni => reset_n,
      i2c_sclk_o => I2C_SCLK,
      i2c_dat_i  => i2c_dat_i,
      i2c_dat_o  => i2c_dat_o,
      aud_adclrck_o => AUD_ADCLRCK,
      aud_adcdat_i  => AUD_ADCDAT,
      aud_daclrck_o => AUD_DACLRCK,
      aud_dacdat_o  => AUD_DACDAT,
      aud_xck_o     => AUD_XCK,
      aud_bclk_o    => AUD_BCLK,
      adc_data_o    => adc_data,
      adc_valid_o   => adc_valid,
      dac_data_i    => dac_data,
      dac_strobe_o  => dac_strobe);
  
  ringbuf_i0 : ringbuf
  port map (
    clk_i                  => clk,
    reset_ni               => reset_n,
    en_i                   => adc_valid,
    data_i                 => adc_data,
    data_o                 => dac_data);
  
  LEDR(9 downto 0) <= std_ulogic_vector(abs(signed(dac_data(15 downto 6))));
  
  -- i2c has an open-drain ouput
  i2c_dat_i <= I2C_SDAT; 
  i2c_data_buffer_i : OPNDRN
    port map (a_in => i2c_dat_o, a_out => I2C_SDAT);

end; -- architecture


