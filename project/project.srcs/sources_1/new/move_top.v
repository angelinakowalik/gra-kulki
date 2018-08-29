`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2018 17:16:45
// Design Name: 
// Module Name: move_top
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


module move_top(
    input wire clk,
    input wire rst,
    input wire move_en,
    input wire [11:0] mouse_xpos,
    input wire [11:0] mouse_ypos,
    input wire mouse_left,
    input wire [63:0] color_r_in,
    input wire [63:0] color_b_in,
    input wire [63:0] color_g_in,
    input wire [63:0] color_y_in,
    
    output wire [63:0] color_r,
    output wire [63:0] color_b,
    output wire [63:0] color_g,
    output wire [63:0] color_y,    
    output wire [1:0] transfer_color,
    output wire transfer,
    output wire move_end
    );
    
    wire [3:0] column, row, column_out, row_out, column_del, row_del;
    wire [1:0] transfer_color_in;
    wire in_range, empty;
    wire write, delete;
 
 // ---------------------------------------------------------------
    
    convert_to_row_col my_convert(
        .clk(clk),
        .rst(rst),
        .xpos(mouse_xpos),
        .ypos(mouse_ypos),

        .column(column),
        .row(row),
        .in_range(in_range)
    );
    
// ---------------------------------------------------------------

    check_empty my_check (
        .clk(clk),
        .rst(rst),
        .column(column),
        .row(row),
        .color_r(color_r_in),
        .color_b(color_b_in),
        .color_g(color_g_in),
        .color_y(color_y_in),

        .empty(empty),
        .transfer_color(transfer_color_in)    
    );

// ---------------------------------------------------------------

    move_ctl my_move (
        .pclk(clk),
        .rst(rst),
        .empty(empty),
        .in_range(in_range),
        .mouse_left(mouse_left),
        .move_en(move_en),
        .transfer_color_in(transfer_color_in),
        .column_in(column),
        .row_in(row),
        
        .transfer(transfer),
        .write(write),
        .delete(delete),
        .transfer_color_out(transfer_color),
        .column_out(column_out),
        .row_out(row_out),
        .column_del(column_del),
        .row_del(row_del),
        .move_end(move_end)
    );

// ---------------------------------------------------------------

//    write_data my_delete (
//        .pclk(clk),
//        .rst(rst),
//        .write(1'b0),
//        .delete(delete),
//        .column(column_out),
//        .row(row_out),
//        .color_r_in(color_r_1),
//        .color_b_in(color_b_1),
//        .color_g_in(color_g_1),
//        .color_y_in(color_y_1),
//        .transfer_color(transfer_color),
        
//        .color_r_out(color_r_d),
//        .color_b_out(color_b_d),
//        .color_g_out(color_g_d),
//        .color_y_out(color_y_d)
//    );
  
// ---------------------------------------------------------------

    write_data my_write (
        .pclk(clk),
        .rst(rst),
        .write(write),
        .delete(delete),
        .column(column_out),
        .row(row_out),
        .column_del(column_del),
        .row_del(row_del),
        .color_r_in(color_r_in),
        .color_b_in(color_b_in),
        .color_g_in(color_g_in),
        .color_y_in(color_y_in),
        .transfer_color(transfer_color),
        
        .color_r_out(color_r),
        .color_b_out(color_b),
        .color_g_out(color_g),
        .color_y_out(color_y)
    );
       
endmodule
