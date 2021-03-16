`timescale 1ns / 1ps



module hex8_test(
    clk, rst_n, sel, seg
    );

    input clk;
    input rst_n;
    output [7:0] sel;
    output [7:0] seg;

    wire disp_en;
    wire [31:0] disp_data;//4bit * 8


    hex8 myhex8(.clk(clk), .rst_n(rst_n), .disp_en(disp_en), .sel(sel), .seg(seg), .disp_data(disp_data));
    
    vio_0 vio_0(.clk(clk), .probe_out0(disp_en), .probe_out1(disp_data));


endmodule
