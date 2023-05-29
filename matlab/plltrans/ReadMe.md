PLL Trans - Data transmission with PLL support
==============================================

This module supports clock synchronization via a
phased lock loop (PLL) for data transmission. The
transmitted data is a fixed 1 which is scrambled
via a 10 Bit scrambler. Data transmission errors
are detected via the Descrambler.

Synchronization
---------------
The clock synchronization is done via a digital pll.
The pll is configured to expect the data at a rate
of 1/3rd of the sample rate, i.e. 16.6666 MHz.

Internal vs. External Clock
---------------------------
The receiver is always clocked with the default CLOCK_50
clock. The transmitter can be clocked via two modes

  * SW9=0: The transmitter is also clocked via CLOCK_50.
    The transmittter is enabled every 3rd clock.
  * SW9=1: The transmitter is clocked via the DAC external
    clock SMA jack on the DAC/ADC board. Always enabled.

