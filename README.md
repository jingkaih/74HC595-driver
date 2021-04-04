# 74HC595-driver
First attempt on FPGA &amp; verilog programming. A driver design for shift register chip 74HC595 implemented on Xilinx board.

There's a lot IO Port saving using shift register. The demo here is to light 8*8-seg led display.

* top.v
  * HC595.v
  * hex8_test.v
    * hex8.v
