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


module find_random_top(
    input wire clk,
    input wire reset,
    input wire find_en,
    input wire [5:0] random_colors_in,
    input wire [63:0] color_0_in, color_1_in, color_2_in, color_3_in,
    input wire [2:0] color_amount,
    
//    output reg [20:0] random_empty,
    output reg [63:0] color_0_out, color_1_out, color_2_out, color_3_out,
//    output reg [5:0] random_colors_out,
    output reg end_game,
    output reg find_end
    );
    
    wire [6:0] empty_places;
    wire [20:0] random_number;
    wire [20:0] random_empty_nxt;
    wire [63:0] color_0_nxt, color_1_nxt, color_2_nxt, color_3_nxt;
    reg [63:0] color_0_tmp1, color_1_tmp1, color_2_tmp1, color_3_tmp1;
    reg [63:0] color_0_tmp2, color_1_tmp2, color_2_tmp2, color_3_tmp2;
    reg [63:0] color_0_tmp3, color_1_tmp3, color_2_tmp3, color_3_tmp3;
    reg [63:0] ball_reg_out, ball_reg_nxt, ball_reg_in;
    wire [5:0] random_colors_nxt;
    reg end_game_nxt, find_end_nxt, find_end_nxt1, find_end_nxt2, find_end_nxt3, find_end_nxt4, find_end_nxt5;
    reg find_en_nxt1, find_en_nxt2, find_en_nxt3, find_en_nxt4, find_en_nxt5, find_en_nxt6;
    
    always @(posedge clk) begin
        if(reset) begin
            find_end <= 0;
            end_game <= 0;
//            random_empty <= 0;
            color_0_out <= 0;
            color_1_out <= 0;
            color_2_out <= 0;
            color_3_out <= 0;
            ball_reg_out <= 0;
            ball_reg_in <= 0;
        end
        else begin     
                find_en_nxt1 <= find_en;
                find_en_nxt2 <= find_en_nxt1;
                find_en_nxt3 <= find_en_nxt2;
                find_en_nxt4 <= find_en_nxt3;
                //find_en_nxt5 <= find_en_nxt4;
                //find_en_nxt6 <= find_en_nxt5;
                
//           if(find_en) begin  
                color_0_tmp1 <= color_0_in;      
                color_1_tmp1 <= color_1_in;
                color_2_tmp1 <= color_2_in;
                color_3_tmp1 <= color_3_in;
                
                ball_reg_in <= (color_0_in | color_1_in | color_2_in | color_3_in);
//            end
//            else begin
//                color_0_tmp1 <= color_0_out;      
//                color_1_tmp1 <= color_1_out;
//                color_2_tmp1 <= color_2_out;
//                color_3_tmp1 <= color_3_out; 
//                ball_reg_in <= (color_0_out | color_1_out | color_2_out | color_3_out);
//            end
                color_0_tmp2 <= color_0_tmp1;
                color_1_tmp2 <= color_1_tmp1;
                color_2_tmp2 <= color_2_tmp1;
                color_3_tmp2 <= color_3_tmp1;
                
                color_0_tmp3 <= color_0_tmp2;
                color_1_tmp3 <= color_1_tmp2;
                color_2_tmp3 <= color_2_tmp2;
                color_3_tmp3 <= color_3_tmp2;
                
                
    //            random_empty <= random_empty_nxt;//
    
                
//            if(find_en_nxt4) begin    
                color_0_out <= color_0_nxt;
                color_1_out <= color_1_nxt;
                color_2_out <= color_2_nxt;
                color_3_out <= color_3_nxt;  
//            end

                ball_reg_out <= ball_reg_nxt;
                end_game <= end_game_nxt; 
                
                find_end_nxt1 <= find_end_nxt; 
                find_end_nxt2 <= find_end_nxt1;
                find_end_nxt3 <= find_end_nxt2; 
                find_end_nxt4 <= find_end_nxt3;  
                find_end_nxt5 <= find_end_nxt4;
                find_end <= find_end_nxt5;  
                    
        end
    end
    
    always @* begin
//        if(find_en_nxt4) begin
            ball_reg_nxt = (color_0_out | color_1_out | color_2_out | color_3_out);
            if(empty_places<3) end_game_nxt = 0;
            else end_game_nxt = 0; /////////////////////////////
            if(ball_reg_out > ball_reg_in) find_end_nxt = 1; /////////////////////
            else find_end_nxt = 0;
//        end
    end
    
// ---------------------------------------------------------------    
    
    count_empty my_count_empty(
        .clk(clk),
        .rst(reset),
        .find_en(find_en),
        .color_0_in(color_0_in),
        .color_1_in(color_1_in),
        .color_2_in(color_2_in),
        .color_3_in(color_3_in),
        .empty_places(empty_places)
    );
    
// ---------------------------------------------------------------    
   
    random_places my_random_places(
        .clk(clk),
        .rst(reset),
        .find_en(find_end_nxt1),
        .empty_places(empty_places),
        .random_numbers(random_number)
    );
    
// ---------------------------------------------------------------    
    
//    random_colors my_random_colors(
//    .clk(clk),
//    .rst(reset),
//    .enable(1),
//    .random_numbers(random_colors_in)
////    .find_en()
//    );

// ---------------------------------------------------------------
    
    find_random_empty find_empty(
        .clk(clk),
        .reset(reset),
        .find_en(find_en_nxt3),
        .color_0_in(color_0_tmp3),
        .color_1_in(color_1_tmp3),
        .color_2_in(color_2_tmp3),
        .color_3_in(color_3_tmp3),
        .random_number(random_number),
        .random_color(random_colors_in),
        .random_empty(random_empty_nxt),  //
        .color_0_out(color_0_nxt),
        .color_1_out(color_1_nxt),
        .color_2_out(color_2_nxt),
        .color_3_out(color_3_nxt)
//      .find_end(find_end)
    );
    
endmodule
