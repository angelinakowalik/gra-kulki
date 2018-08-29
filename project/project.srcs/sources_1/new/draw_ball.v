`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2018 23:43:31
// Design Name: 
// Module Name: draw_ball
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

module draw_ball(
    input wire          pclk,
    input wire          rst,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    input wire [63:0]   color_r,
    input wire [63:0]   color_b,
    input wire [63:0]   color_g,
    input wire [63:0]   color_y,
    input wire [11:0]   rgb_pixel_r,
    input wire [11:0]   rgb_pixel_b,
    input wire [11:0]   rgb_pixel_g,
    input wire [11:0]   rgb_pixel_y,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out,
    output wire [11:0]   pixel_addr,
    output wire ball_en,
    output wire random_en
    );

wire [`VGA_BUS_SIZE - 1:0] r2b_vga, b2g_vga, g2y_vga;

// ---------------------------------------------------------------

    draw_ball_color my_red (
        .pclk(pclk),
        .rst(rst),
        .vga_in(vga_in),
        .color_in(color_r),
        .rgb_pixel(rgb_pixel_r),
    
        .vga_out(r2b_vga),
        .pixel_addr(pixel_addr),
        .ball_en(ball_en),
        .random_en(random_en)
    );
    
// ---------------------------------------------------------------
    
    draw_ball_color my_blue (
        .pclk(pclk),
        .rst(rst),
        .vga_in(r2b_vga),
        .color_in(color_b),
        .rgb_pixel(rgb_pixel_b),
        
        .vga_out(b2g_vga),
        .pixel_addr(pixel_addr),
        .ball_en(ball_en),
        .random_en(random_en)
    );    
    
// ---------------------------------------------------------------
        
    draw_ball_color my_green (
        .pclk(pclk),
        .rst(rst),
        .vga_in(b2g_vga),
        .color_in(color_g),
        .rgb_pixel(rgb_pixel_g),
         
        .vga_out(g2y_vga),
        .pixel_addr(pixel_addr),
        .ball_en(ball_en),
        .random_en(random_en)
    );
                
// ---------------------------------------------------------------
            
    draw_ball_color my_yellow (
        .pclk(pclk),
        .rst(rst),
        .vga_in(g2y_vga),
        .color_in(color_y),
        .rgb_pixel(rgb_pixel_y),
               
        .vga_out(vga_out),
        .pixel_addr(pixel_addr),
        .ball_en(ball_en),
        .random_en(random_en)
    );

endmodule
