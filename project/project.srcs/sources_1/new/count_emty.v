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


module count_empty(
    input wire clk,
    input wire rst,
    input wire find_en,
    input wire [63:0] color_0_in, color_1_in, color_2_in, color_3_in,
    output reg [6:0] empty_places
    );
    reg [6:0] count_ones, empty_places_nxt;
    reg [63:0] ball_reg;
    integer idx;
    
    always @(clk) begin
        if(rst)
            empty_places <= 7'b0;
        else  
            if(find_en)
                empty_places <= empty_places_nxt;
            else
                empty_places <= 7'b0;
        end
    
    always @* begin
//        empty_places_nxt = empty_places;
//        if(find_en)
//        begin            
            ball_reg = color_0_in | color_1_in | color_2_in | color_3_in;
            count_ones=0;
            for(idx=0; idx<=63; idx=idx+1) begin 
                count_ones = count_ones + ball_reg[idx];
            end  
            empty_places_nxt = 'd64 - count_ones;
//        end     
    end
      
    
endmodule
