`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 08:02:08 PM
// Design Name: 
// Module Name: find_random_top
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

module find_random_top(
    input wire clk,
    input wire reset,
    input wire find_en,
    input wire [5:0] random_colors_in,
    input wire [`COLOR_BUS_SIZE - 1:0] color_in,
    
    output wire [`COLOR_BUS_SIZE - 1:0] color_out,
    output reg end_game,
    output reg find_end
    );
    
    `COLOR_INPUT(color_in)
    `COLOR_OUT_REG
    `COLOR_OUTPUT(color_out)  
    
    wire [`COLOR_BUS_SIZE - 1:0] color_nxt;
    wire [6:0] empty_places;
    wire [20:0] random_number;
    reg [63:0] color_r_tmp1, color_b_tmp1, color_g_tmp1, color_y_tmp1;
    reg [63:0] ball_reg_out, ball_reg_nxt, ball_reg_in;
    wire [5:0] random_colors_nxt;
    reg end_game_nxt, find_end_nxt, find_end_nxt1, find_end_nxt2, find_end_nxt3, find_end_nxt4, find_end_nxt5;
    reg find_en_nxt1, find_en_nxt2, find_en_nxt3, find_en_nxt4, find_en_nxt5, find_en_nxt6;
    
    always @(posedge clk) begin
        if(reset) begin
            find_end <= 0;
            end_game <= 0;
            color_r_out <= 0;
            color_b_out <= 0;
            color_g_out <= 0;
            color_y_out <= 0;
            ball_reg_out <= 0;
            ball_reg_in <= 0;
        end
        else begin     
            find_en_nxt1 <= find_en;
            find_en_nxt2 <= find_en_nxt1;
            find_en_nxt3 <= find_en_nxt2;
            find_en_nxt4 <= find_en_nxt3;
            find_en_nxt5 <= find_en_nxt4;
            find_en_nxt6 <= find_en_nxt5;
                
            ball_reg_in <= (color_r_in | color_b_in | color_g_in | color_y_in);

            if(find_en_nxt4) begin   
                color_r_tmp1 <= color_nxt[63:0];
                color_b_tmp1 <= color_nxt[127:64];
                color_g_tmp1 <= color_nxt[191:128];
                color_y_tmp1 <= color_nxt[255:192];
            end
                
            ball_reg_out <= ball_reg_nxt;
            end_game <= end_game_nxt; 
                
            color_r_out <= color_r_tmp1;
            color_b_out <= color_b_tmp1;
            color_g_out <= color_g_tmp1;
            color_y_out <= color_y_tmp1;
                
            find_end_nxt1 <= find_end_nxt; 
            find_end_nxt2 <= find_end_nxt1;
            find_end_nxt3 <= find_end_nxt2; 
            find_end_nxt4 <= find_end_nxt3;  
            find_end_nxt5 <= find_end_nxt4;
            find_end <= find_end_nxt5;                      
        end
    end
    
    always @* begin
            ball_reg_nxt = (color_r_tmp1 | color_b_tmp1 | color_g_tmp1 | color_y_tmp1);
            if((empty_places<3) && find_en) end_game_nxt = 1;
            else end_game_nxt = 0;
            if((ball_reg_out > ball_reg_in) && find_en_nxt6) find_end_nxt = 1; 
            else find_end_nxt = 0;
    end
    
// ---------------------------------------------------------------    
    
    count_empty my_count_empty(
        .clk(clk),
        .rst(reset),
        .find_en(1),
        .color_in(color_in),
        .empty_places(empty_places)
    );
    
// ---------------------------------------------------------------    
   
    random_places my_random_places(
        .clk(clk),
        .rst(reset),
        .find_en(1),
        .empty_places(empty_places),
        .random_numbers(random_number)
    ); 

// ---------------------------------------------------------------
    
    find_random_empty find_empty(
        .clk(clk),
        .reset(reset),
        .find_en(1),
        .color_in(color_in),
        .random_number(random_number),
        .random_color(random_colors_in),
        .color_out(color_nxt)
    );
    
endmodule
