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


module core(
    input wire clk,
    input wire rst,
    input wire game_mode,
    input wire [11:0] mouse_xpos,
    input wire [11:0] mouse_ypos,
    input wire mouse_left,
    
    output wire [63:0] color_r_out,
    output wire [63:0] color_b_out,
    output wire [63:0] color_g_out,
    output wire [63:0] color_y_out,    
    output wire [1:0] transfer_color,
    output wire [5:0] random_colors_out,
    output wire [11:0] score,
    output wire transfer,
    output wire end_en
    );    
    
    reg [63:0] color_r_in, color_b_in, color_g_in, color_y_in;
    wire [63:0] color_r_find, color_b_find, color_g_find, color_y_find;
    wire [63:0] color_r_mv, color_b_mv, color_g_mv, color_y_mv;
    wire [63:0] color_r_disp, color_b_disp, color_g_disp, color_y_disp;
    reg [9:0] points_in;
    wire [9:0] points_out;
    wire find_end, move_end;
    wire rnd_col_en;
    wire find_en, move_en, disp_en;
    wire find_en_nxt, move_en_nxt, disp_en_nxt, rnd_col_en_nxt;
    

    always @(posedge clk) begin
        if(rst)
        begin
            color_r_in      <= 63'b0;
            color_b_in      <= 63'b0;
            color_g_in      <= 63'b0;
            color_y_in      <= 63'b0;
            points_in       <= 0;
//            find_en         <= 0;
//            move_en         <= 0;
//            disp_en         <= 0;
        end  
        else begin
            color_r_in      <= color_r_out;
            color_b_in      <= color_b_out;
            color_g_in      <= color_g_out;
            color_y_in      <= color_y_out;
            points_in       <= points_out;
//            find_en         <= find_en_nxt;
//            move_en         <= move_en_nxt;
//            disp_en         <= disp_en_nxt;
//            rnd_col_en      <= rnd_col_en_nxt;
//            back_column<= 0;
//            back_row<= 0;
//            putt_column<= 0;
//            putt_row<= 0;
    
        end
    end

    
// ---------------------------------------------------------------

    control_ms machine_states (
        .clk(clk),
        .reset(rst),
        .go(game_mode),    
        .color_0_find(color_r_find),
        .color_0_mv(color_r_mv),
        .color_0_dsp(color_r_disp),
        .color_1_find(color_b_find),
        .color_1_mv(color_b_mv),
        .color_1_dsp(color_b_disp),
        .color_2_find(color_g_find),
        .color_2_mv(color_g_mv),
        .color_2_dsp(color_g_disp),
        .color_3_find(color_y_find),
        .color_3_mv(color_y_mv),
        .color_3_dsp(color_y_disp),
//      .set_ball(set_ball),
        .find_end(find_end),
        .move_end(move_end),
//      .set_new(set_new),
            
        .color_0_out(color_r_out),
        .color_1_out(color_b_out),
        .color_2_out(color_g_out),
        .color_3_out(color_y_out), 
        .rnd_col_en(rnd_col_en),
        .find_en(find_en),
        .move_en(move_en),
        .disp_en(disp_en)
//      .random_empty(random_empty)    
    );

// ---------------------------------------------------------------

    random_top my_random (
        .clk(clk),
        .reset(rst),
        .color_amount(3'd4),
        .color_0_in(color_r_out),
        .color_1_in(color_b_out),
        .color_2_in(color_g_out),
        .color_3_in(color_y_out),   
        .rnd_col_en(rnd_col_en),
        .find_en(find_en),
    
        .color_0_find(color_r_find),
        .color_1_find(color_b_find),
        .color_2_find(color_g_find),
        .color_3_find(color_y_find),
        .random_colors_out(random_colors_out),
//        .random_empty(random_empty),
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
        .color_r_in(color_r_out),
        .color_b_in(color_b_out),
        .color_g_in(color_g_out),
        .color_y_in(color_y_out),
           
        .color_r(color_r_mv),
        .color_b(color_b_mv),
        .color_g(color_g_mv),
        .color_y(color_y_mv),    
        .transfer_color(transfer_color),
        .transfer(transfer),
        .move_end(move_end)    
    );    
    
// ---------------------------------------------------------------    

    disappear_balls my_disappear (
        .clk(clk),
        .rst(rst),
        .disp_en(disp_en),
        .color_0_in(color_r_out),
        .color_1_in(color_b_out),
        .color_2_in(color_g_out),
        .color_3_in(color_y_out),
        .points_in(points_in),
    
        .color_0_out(color_r_disp),
        .color_1_out(color_b_disp),
        .color_2_out(color_g_disp),
        .color_3_out(color_y_disp),
        .points_out(points_out)
//        .set_new(set_new)
    );
    
// ---------------------------------------------------------------

    num_to_dig num_to_dig (
        .number(points_out),
        .digits(score)
    );
         
endmodule
