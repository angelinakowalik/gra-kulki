`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 13:31:37
// Design Name: 
// Module Name: draw_score
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

module draw_score(
    input wire          pclk,
    input wire          rst,
    input wire [11:0]   bcd_in,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out
    );
    
wire [`VGA_BUS_SIZE - 1:0] vga_1to2, vga_2to3;
 
// ---------------------------------------------------------------
    
    draw_digit
        #(  .DIGIT_XPOS(80),
            .DIGIT_YPOS(200),
            .DIGIT_THICK(7),
            .DIGIT_HEIGHT(50),
            .DIGIT_WIDTH(20),
            .DIGIT_COLOR(12'h0_8_8)
        )
        my_digit1 (
            .pclk(pclk),
            .rst(rst),            
            .digit_bcd(bcd_in[11:8]),
            .vga_in(vga_in),
                
            .vga_out(vga_1to2)
        );
 
// ---------------------------------------------------------------
       
    draw_digit
        #(  .DIGIT_XPOS(110),
            .DIGIT_YPOS(200),
            .DIGIT_THICK(7),
            .DIGIT_HEIGHT(50),
            .DIGIT_WIDTH(20),
            .DIGIT_COLOR(12'h0_8_8)
        )
        my_digit2 (
            .pclk(pclk),
            .rst(rst),
            .digit_bcd(bcd_in[7:4]),
            .vga_in(vga_1to2),
                   
            .vga_out(vga_2to3)
        );

// ---------------------------------------------------------------
       
    draw_digit
        #(  .DIGIT_XPOS(140),
            .DIGIT_YPOS(200),
            .DIGIT_THICK(7),
            .DIGIT_HEIGHT(50),
            .DIGIT_WIDTH(20),
            .DIGIT_COLOR(12'h0_8_8)
        )
        my_digit3 (
            .pclk(pclk),
            .rst(rst),
            .digit_bcd(bcd_in[3:0]),
            .vga_in(vga_2to3),
                   
            .vga_out(vga_out)
        );
endmodule
