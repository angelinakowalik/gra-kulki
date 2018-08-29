`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 14:16:17
// Design Name: 
// Module Name: draw_letters
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

module draw_letters(
    input wire          pclk,
    input wire          rst,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out
    );
    
    wire [7:0] f2c_char_pixel;
    wire [7:0] c2r_char_xy;
    wire [6:0] r2f_char_code;
    wire [3:0] c2f_char_line;
    
// ---------------------------------------------------------------

    font_rom my_font (
        .clk(pclk),
        .addr({r2f_char_code[6:0], c2f_char_line[3:0]}),
        .char_line_pixels(f2c_char_pixel)
    );
    
// ---------------------------------------------------------------

    char_rom_16x16 my_char_rom (
        .char_xy(c2r_char_xy),
        .char_code(r2f_char_code)
    );

// ---------------------------------------------------------------

    draw_char my_char (
        .pclk(pclk),
        .rst(rst),
        .char_pixel(f2c_char_pixel),
        .vga_in(vga_in),
        
        .vga_out(vga_out),
        .char_xy(c2r_char_xy),
        .char_line(c2f_char_line)
    );

endmodule
