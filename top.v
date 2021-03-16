`timescale 1ns / 1ps



module top(
    clk, rst_n, rclk, sclk, s_data
    );

    input wire clk;
    input wire rst_n;

    output wire rclk;
    output wire sclk;
    output wire s_data;

    wire [15:0] p_data;


    hex8_test myhex8_mytest(.clk(clk), .rst_n(rst_n), .sel(p_data[7:0]), .seg(p_data[15:8]));
    

    HC595_driver this_driver(.clk(clk), .rst_n(rst_n), .p_data(p_data), .s_data(s_data), .sclk(sclk), .rclk(rclk));




endmodule
