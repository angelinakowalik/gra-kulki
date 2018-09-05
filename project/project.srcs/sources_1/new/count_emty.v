`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2018 07:37:45 PM
// Design Name: 
// Module Name: count_empty
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "_color_macros.vh"

module count_empty(
    input wire clk,
    input wire rst,
    input wire find_en,
    input wire [`COLOR_BUS_SIZE - 1:0] color_in,
    output reg [6:0] empty_places
    );
    reg [6:0] count_ones, empty_places_nxt;
    reg [63:0] ball_reg;
    integer idx;
    
    `COLOR_INPUT(color_in)
    
    always @(posedge clk) begin
        if(rst)
            empty_places <= 7'b0;
        else  
            if(find_en)
                empty_places <= empty_places_nxt;
            else
                empty_places <= 7'b0;
        end
    
    always @* begin      
            ball_reg = color_r_in | color_b_in | color_g_in | color_y_in;
            count_ones=0;
            for(idx=0; idx<=63; idx=idx+1) begin 
                count_ones = count_ones + ball_reg[idx];
            end  
            empty_places_nxt = 'd64 - count_ones;     
    end
      
    
endmodule
