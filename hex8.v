`timescale 1ns / 1ps


//

module hex8(
    clk, rst_n, disp_en, disp_data, sel, seg
    );

    input clk;
    input rst_n;
    input [31:0] disp_data;//4 bits of BCD code * 8 led Nixietube
    input disp_en;


    output reg [7:0] sel;//select which led Nixietube to light
    output reg [7:0] seg;//

    reg [15:0] divider_cnt;//count to 50000
    reg divide_clk;

    reg [2:0] sel_cnt;/*sel_cnt = 000, sel = 0000_0001
                        sel_cnt = 001, sel = 0000_0010
                        sel_cnt = 010, sel = 0000_0100
                        sel_cnt = 011, sel = 0000_1000
                        sel_cnt = 100, sel = 0001_0000
                        sel_cnt = 101, sel = 0010_0000
                        sel_cnt = 110, sel = 0100_0000
                        sel_cnt = 111, sel = 1000_0000*/

    reg [3:0] data_tmp;


    //divider
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            divider_cnt <= 0;
        else if(!disp_en)
            divider_cnt <= 0;
        else if(divider_cnt == 49999)
            divider_cnt <= 0;
        else
            divider_cnt <= divider_cnt + 1;
    end

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            divide_clk <= 0;
        else if(divider_cnt == 49998)
            divide_clk <= 1;
        else
            divide_clk <= 0;
    end

    //sel_counter
    always @(posedge clk, negedge rst_n) begin
        if(!rst_n)
            sel_cnt <= 3'b000;
        else if(divider_cnt == 49998)
            sel_cnt <= sel_cnt + 1;
        else
            sel_cnt <= sel_cnt;
    end
    //3-8 decoder
    always @(*) begin
        if(!rst_n)
            sel = 8'b0000_0000;
        else if(!disp_en)
            sel = 8'b0000_0000;
        else case (sel_cnt)
            3'b000: sel = 8'b0000_0001;
            3'b001: sel = 8'b0000_0010;
            3'b010: sel = 8'b0000_0100;
            3'b011: sel = 8'b0000_1000;
            3'b100: sel = 8'b0001_0000;
            3'b101: sel = 8'b0010_0000;
            3'b110: sel = 8'b0100_0000;
            3'b111: sel = 8'b1000_0000;
            default: sel = 8'b0000_0000;
        endcase
    end

    //BCD Look-up table
    always @(*) begin
        case (sel)
            8'b0000_0001: data_tmp = disp_data[3:0];
            8'b0000_0010: data_tmp = disp_data[7:4];
            8'b0000_0100: data_tmp = disp_data[11:8];
            8'b0000_1000: data_tmp = disp_data[15:12];
            8'b0001_0000: data_tmp = disp_data[19:16];
            8'b0010_0000: data_tmp = disp_data[23:20];
            8'b0100_0000: data_tmp = disp_data[27:24];
            8'b1000_0000: data_tmp = disp_data[31:28];
            default: data_tmp = 4'h8;//display 8
        endcase
    end
    
    always @(*) begin
        case (data_tmp)
            4'h0: seg = 8'b11000000;
            4'h1: seg = 8'b11111001;
            4'h2: seg = 8'b10100100;
            4'h3: seg = 8'b10110000;
            4'h4: seg = 8'b10011001;
            4'h5: seg = 8'b10010010;
            4'h6: seg = 8'b10000010;
            4'h7: seg = 8'b11111000;
            4'h8: seg = 8'b10000000;
            4'h9: seg = 8'b10010000;
            4'ha: seg = 8'b10001000;
            4'hb: seg = 8'b10000011;
            4'hc: seg = 8'b11000110;
            4'hd: seg = 8'b10100001;
            4'he: seg = 8'b10000110;
            4'hf: seg = 8'b10001110;
            default: seg = 8'b00000000;
        endcase
    end


endmodule
