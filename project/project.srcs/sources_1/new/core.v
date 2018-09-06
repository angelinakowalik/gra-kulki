`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2018 14:23:50
// Design Name: 
// Module Name: core
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

module core(
    input wire clk,
    input wire rst,
    input wire game_mode,
    input wire [11:0] mouse_xpos,
    input wire [11:0] mouse_ypos,
    input wire mouse_left,
    
    output wire [`COLOR_BUS_SIZE - 1:0] color_reg,
    output wire [1:0] transfer_color,
    output wire [5:0] random_colors_out,
    output wire [11:0] score,
    output wire transfer,
    output wire end_en
    );    
    
    wire [`COLOR_BUS_SIZE - 1:0] color_find, color_mv, color_disp;
    wire [9:0] points_in;
    wire [9:0] points_out;
    wire find_end, move_end;
    wire rnd_col_en;
    wire find_en, move_en, disp_en;
    wire find_en_nxt, move_en_nxt, disp_en_nxt, rnd_col_en_nxt;
    

// ---------------------------------------------------------------

    control_ms machine_states (
        .clk(clk),
        .reset(rst),
        .go(game_mode),
        .color_find(color_find),
        .color_mv(color_mv),
        .color_disp(color_disp),
        .find_end(find_end),
        .move_end(move_end),
        .end_en(end_en),
        .points_out(points_out),
            
        .color_out(color_reg),
        .rnd_col_en(rnd_col_en),
        .find_en(find_en),
        .move_en(move_en),
        .disp_en(disp_en),
        .points_in(points_in)
    );

// ---------------------------------------------------------------

    random_top my_random (
        .clk(clk),
        .reset(rst),
        .color_in(color_reg),   
        .rnd_col_en(rnd_col_en),
        .find_en(find_en),
    
        .color_out(color_find),
        .random_colors_out(random_colors_out),
        .end_game(end_en),
        .find_end(find_end)    
    );
 
// ---------------------------------------------------------------

    move_top my_move (
        .clk(clk),
        .rst(rst),
        .move_en(move_en),
        .mouse_xpos(mouse_xpos),
        .mouse_ypos(mouse_ypos),
        .mouse_left(mouse_left),
        .color_in(color_reg),
           
        .color_out(color_mv),   
        .transfer_color(transfer_color),
        .transfer(transfer),
        .move_end(move_end)    
    );    
    
// ---------------------------------------------------------------    

    disappear_balls my_disappear (
        .clk(clk),
        .rst(rst),
        .disp_en(disp_en),
        .color_in(color_reg),
        .points_in(points_in),
    
        .color_out(color_disp),
        .points_out(points_out)
    );
    
// ---------------------------------------------------------------

    num_to_dig num_to_dig (
        .number(points_out),
        
        .digits(score)
    );
         
endmodule
