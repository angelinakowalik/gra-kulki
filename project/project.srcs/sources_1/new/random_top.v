`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2018 17:16:45
// Design Name: 
// Module Name: random_top
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


module random_top(
    input wire clk,
    input wire reset,
    input wire [2:0] color_amount,
    input wire [63:0] color_0_in,
    input wire [63:0] color_1_in, color_2_in, color_3_in,
//    input wire [9:0] points_in,    
    input wire rnd_col_en, find_en,
    
    output wire [63:0] color_0_find,
    output wire [63:0] color_1_find,
    output wire [63:0] color_2_find,
    output wire [63:0] color_3_find,
    output reg [5:0] random_colors_out,
//    output wire [20:0] random_empty,
    output wire end_game,
    output wire find_end
    );
            
            
    reg [2:0] state_nxt, state;
    reg [63:0] color_0_nxt, color_1_nxt, color_2_nxt, color_3_nxt;
    reg [63:0] color_0_nxt1, color_1_nxt1, color_2_nxt1, color_3_nxt1;
    wire find_en_start;
    reg [9:0] points_in;

    reg [5:0] random_colors_in;
    wire [5:0] random_colors_in_nxt, random_colors_nxt;
    wire [12:0] random_lfsr;
    reg find_en_nxt, find_en_nxt1, find_en_nxt2, find_en_nxt3;
            
    always @(posedge clk) begin
        if(reset)begin
            random_colors_out <= 0;
        end  
        else begin
            color_0_nxt <= color_0_in;
            color_1_nxt <= color_1_in;
            color_2_nxt <= color_2_in;
            color_3_nxt <= color_3_in;
            find_en_nxt <= find_en;
            
            color_0_nxt1 <= color_0_nxt;
            color_1_nxt1 <= color_1_nxt;
            color_2_nxt1 <= color_2_nxt;
            color_3_nxt1 <= color_3_nxt;
            find_en_nxt1 <= find_en_nxt;
            find_en_nxt2 <= find_en_nxt1;
            find_en_nxt3 <= find_en_nxt2;
            
            random_colors_out <= random_colors_nxt;
        end
    end
    
// ---------------------------------------------------------------    

    random_colors start_ranom_color(
        .clk(clk),
        .rst(reset),
        .enable(rnd_col_en || find_en),
        
        .random_numbers(random_colors_nxt)
//      .find_en(find_en_start)
    );
    
// ---------------------------------------------------------------    

    find_random_top find_core(
        .clk(clk),
        .reset(reset),
        .find_en(find_en_nxt1),
        .color_0_in(color_0_nxt1),
        .color_1_in(color_1_nxt1),
        .color_2_in(color_2_nxt1),
        .color_3_in(color_3_nxt1),
        .random_colors_in(random_colors_nxt),
        .color_amount(color_amount),
        
//      .random_empty(random_empty),
        .color_0_out(color_0_find), 
        .color_1_out(color_1_find),
        .color_2_out(color_2_find), 
        .color_3_out(color_3_find),
//      .random_colors_out(random_colors_nxt),
        .end_game(end_game),
        .find_end(find_end)
    );
    
endmodule
