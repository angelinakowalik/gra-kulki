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

`include "_color_macros.vh"

module random_top(
    input wire clk,
    input wire reset,
    input wire [`COLOR_BUS_SIZE - 1:0] color_in,  
    input wire rnd_col_en, find_en,
    
    output wire [`COLOR_BUS_SIZE - 1:0] color_out,
    output reg [5:0] random_colors_out,
    output wire end_game,
    output wire find_end
    );
    
    `COLOR_INPUT(color_in)
    `COLOR_OUT_REG
    `COLOR_OUTPUT(color_out)
            
            
    reg [2:0] state_nxt, state;
    wire find_en_start;
    reg [9:0] points_in;

    reg [5:0] random_colors_in;
    wire [5:0] random_colors_in_nxt, random_colors_nxt;
    wire [12:0] random_lfsr;
    reg find_en_nxt, find_en_nxt1, find_en_nxt2, find_en_nxt3, find_en_nxt4, find_en_nxt5, find_en_nxt6;
            
    always @(posedge clk) begin
        if(reset)begin
            random_colors_out <= 0;
        end  
        else begin
            find_en_nxt <= find_en;
            find_en_nxt1 <= find_en_nxt;
            find_en_nxt2 <= find_en_nxt1;
            find_en_nxt3 <= find_en_nxt2;
            find_en_nxt4 <= find_en_nxt3;
            find_en_nxt5 <= find_en_nxt4;
            find_en_nxt6 <= find_en_nxt5;
            
            random_colors_out <= random_colors_nxt;
        end
    end
    
// ---------------------------------------------------------------    

    random_colors start_ranom_color(
        .clk(clk),
        .rst(reset),
        .enable(rnd_col_en || find_en_nxt6),
        
        .random_numbers(random_colors_nxt)
    );
    
// ---------------------------------------------------------------    

    find_random_top find_core(
        .clk(clk),
        .reset(reset),
        .find_en(find_en),
        .color_in(color_in),
        .random_colors_in(random_colors_nxt),
        
        .color_out(color_out),
        .end_game(end_game),
        .find_end(find_end)
    );
    
endmodule
