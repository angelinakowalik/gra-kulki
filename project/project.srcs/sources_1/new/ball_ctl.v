`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 09:26:42
// Design Name: 
// Module Name: ball_ctl
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

`include "_vga_macros.vh"

module ball_ctl(
    input wire          pclk,
    input wire          rst,
    input wire          transfer,
    input wire [1:0]    transfer_color,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out
    );
    
    wire [11:0] b2m_x, b2m_y, p2m_x, p2m_y, m2t_x, m2t_y;
    wire [11:0] ctl_address;
    wire [11:0] rgb_pixel;
    
// ---------------------------------------------------------------

//    move_ball my_back (
//        .pclk(pclk),
//        .rst(rst),
//        .button(back),
//        .transfer(transfer),
//        .mouse_xpos(mouse_xpos),
//        .mouse_ypos(mouse_ypos),
//        .column_in(back_column),
//        .row_in(back_row),
        
//        .x_out(b2m_x),
//        .y_out(b2m_y) 
//    );
    
//// ---------------------------------------------------------------
    
//    move_ball my_putt (
//        .pclk(pclk),
//        .rst(rst),
//        .button(putt),
//        .transfer(transfer),
//        .mouse_xpos(mouse_xpos),
//        .mouse_ypos(mouse_ypos),
//        .column_in(putt_column),
//        .row_in(putt_row),
            
//        .x_out(p2m_x),
//        .y_out(p2m_y) 
//    );
    
//// ---------------------------------------------------------------

//    mux_back_putt my_mux_bp (
//        .pclk(pclk),
//        .rst(rst),
//        .back(back),
//        .putt(putt),
//        .mouse_xpos(mouse_xpos),
//        .mouse_ypos(mouse_ypos),
//        .x_back(b2m_x),
//        .y_back(b2m_y),
//        .x_putt(p2m_x),
//        .y_putt(p2m_y),
//        .x_ctl(m2t_x),
//        .y_ctl(m2t_y)
//    );

// ---------------------------------------------------------------

    image_rom my_image_ctl (
        .clk(pclk),
        .color_in(transfer_color),
        .address(ctl_address),
    
        .rgb(rgb_pixel)
    );

// ---------------------------------------------------------------

    transfer_ball my_transfer (
        .pclk(pclk),
        .rst(rst),
        .xpos(mouse_xpos),
        .ypos(mouse_ypos),
        .rgb_pixel(rgb_pixel),
        .transfer(transfer),
        .vga_in(vga_in),
        
        .vga_out(vga_out),
        .pixel_addr(ctl_address)
    );
    
endmodule
