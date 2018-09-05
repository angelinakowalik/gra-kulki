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
`include "_color_macros.vh"

module draw_ball(
    input wire          pclk,
    input wire          rst,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    input wire [`COLOR_BUS_SIZE - 1:0] color_reg,
    input wire [11:0]   rgb_pixel_r,
    input wire [11:0]   rgb_pixel_b,
    input wire [11:0]   rgb_pixel_g,
    input wire [11:0]   rgb_pixel_y,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out,
    output wire [47:0]  pixel_addr
    );

wire [`VGA_BUS_SIZE - 1:0] r2b_vga, b2g_vga, g2y_vga;
//wire [11:0] pixel_addr_r, pixel_addr_b, pixel_addr_g, pixel_addr_y;

// ---------------------------------------------------------------

    draw_ball_color my_red (
        .pclk(pclk),
        .rst(rst),
        .vga_in(vga_in),
        .color_in(color_reg[63:0]),
        .rgb_pixel(rgb_pixel_r),
    
        .vga_out(r2b_vga),
        .pixel_addr(pixel_addr[11:0])
    );
    
// ---------------------------------------------------------------
    
    draw_ball_color my_blue (
        .pclk(pclk),
        .rst(rst),
        .vga_in(r2b_vga),
        .color_in(color_reg[127:64]),
        .rgb_pixel(rgb_pixel_b),
        
        .vga_out(b2g_vga),
        .pixel_addr(pixel_addr[23:12])
    );    
    
// ---------------------------------------------------------------
        
    draw_ball_color my_green (
        .pclk(pclk),
        .rst(rst),
        .vga_in(b2g_vga),
        .color_in(color_reg[191:128]),
        .rgb_pixel(rgb_pixel_g),
         
        .vga_out(g2y_vga),
        .pixel_addr(pixel_addr[35:24])
    );
                
// ---------------------------------------------------------------
            
    draw_ball_color my_yellow (
        .pclk(pclk),
        .rst(rst),
        .vga_in(g2y_vga),
        .color_in(color_reg[255:192]),
        .rgb_pixel(rgb_pixel_y),
               
        .vga_out(vga_out),
        .pixel_addr(pixel_addr[47:36])
    );
    
    
//    assign pixel_addr = pixel_addr_r | pixel_addr_b | pixel_addr_g | pixel_addr_y;

endmodule
