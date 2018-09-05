`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2018 21:25:43
// Design Name: 
// Module Name: draw_end
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

module draw_end(
    input wire pclk,
    input wire rst,
    input wire [11:0] score,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out
    );
    
    wire [`VGA_BUS_SIZE - 1:0] b2c_vga, c2s_vga;
    wire [7:0] char_pixels, char_xy;
    wire [6:0] char_code;
    wire [3:0] char_line;
    wire [10:0] address;

// ---------------------------------------------------------------
   
    draw_end_back my_end_back (
        .pclk(pclk),
        .rst(rst),
        .vga_in(vga_in),
        
        .vga_out(b2c_vga)
    );

// ---------------------------------------------------------------
    
    font_rom my_font (
        .clk(pclk),
        .addr({char_code,char_line}),
        
        .char_line_pixels(char_pixels)
    );

// ---------------------------------------------------------------
    
    char_rom_end my_char (
        .char_xy(char_xy),
        
        .char_code(char_code)
    );

// ---------------------------------------------------------------
    
    draw_char_end my_char_rect (
        .pclk(pclk),
        .rst(rst),
        .char_pixel(char_pixels),
        .vga_in(b2c_vga),          

        .vga_out(c2s_vga),
        .char_xy(char_xy),
        .char_line(char_line)    
    );

// ---------------------------------------------------------------
    
    draw_score_end my_score_end (
        .pclk(pclk),
        .rst(rst),
        .bcd_in(score),
        .vga_in(c2s_vga),
        
        .vga_out(vga_out)
    );


endmodule