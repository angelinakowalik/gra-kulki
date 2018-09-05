`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2018 21:31:10
// Design Name: 
// Module Name: draw_game
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
`include "_color_macros.vh"

module draw_game(
    input wire pclk,
    input wire rst,
    input wire transfer,
    input wire [1:0] transfer_color,
    input wire [11:0] xpos,
    input wire [11:0] ypos,
    input wire [11:0] score,
    input wire [5:0] random_color,
    input wire [`COLOR_BUS_SIZE - 1:0] color_reg,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out
    );
    
    wire [`VGA_BUS_SIZE - 1:0] bg2b_vga, b2r_vga, r2l_vga, l2s_vga, s2c_vga;
    wire [47:0] address;
    wire [11:0] rgb_pixel_r, rgb_pixel_b, rgb_pixel_g, rgb_pixel_y;

// ---------------------------------------------------------------
    
    draw_background my_background (
            .pclk(pclk),
            .rst(rst),
            .vga_in(vga_in),
            
            .vga_out(bg2b_vga)
        );        

// ---------------------------------------------------------------

    color_ball my_color (
        .pclk(pclk),
        .address(address),
    
        .rgb_pixel_r(rgb_pixel_r),
        .rgb_pixel_b(rgb_pixel_b),
        .rgb_pixel_g(rgb_pixel_g),
        .rgb_pixel_y(rgb_pixel_y)
    );

// ---------------------------------------------------------------

    draw_ball my_ball (
        .pclk(pclk),
        .rst(rst),
        .vga_in(bg2b_vga),
        .color_reg(color_reg),
        .rgb_pixel_r(rgb_pixel_r),
        .rgb_pixel_b(rgb_pixel_b),
        .rgb_pixel_g(rgb_pixel_g),
        .rgb_pixel_y(rgb_pixel_y),
        
        .vga_out(b2r_vga),
        .pixel_addr(address)
    );
    
// ---------------------------------------------------------------

    draw_random (
        .pclk(pclk),
        .rst(rst),
        .vga_in(b2r_vga),   
        .color_in(random_color),
    
        .vga_out(r2l_vga)
    );
//    draw_random_ball my_random (
//        .pclk(pclk),
//        .rst(rst),
//        .vga_in(b2r_vga),   
//        .color_in(random_color),
//        .rgb_pixel_r(rgb_pixel_r),
//        .rgb_pixel_b(rgb_pixel_b),
//        .rgb_pixel_g(rgb_pixel_g),
//        .rgb_pixel_y(rgb_pixel_y),
    
//        .vga_out(r2l_vga),
//        .address_random(address_random),
//        .ball_en(ball_en),
//        .random_en(random_en)
//    );

// ---------------------------------------------------------------
    draw_letters my_letters (
        .pclk(pclk),
        .rst(rst),
        .vga_in(r2l_vga),
        
        .vga_out(l2s_vga)
    );

// ---------------------------------------------------------------

    draw_score my_score (
        .pclk(pclk),
        .rst(rst),
        .bcd_in(score),
        .vga_in(l2s_vga),
        
        .vga_out(s2c_vga)
    );

// ---------------------------------------------------------------

    ball_ctl my_ctl (
        .pclk(pclk),
        .rst(rst),
        .transfer(transfer),
        .transfer_color(transfer_color),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .vga_in(s2c_vga),
        
        .vga_out(vga_out)
    );

// ---------------------------------------------------------------
endmodule
