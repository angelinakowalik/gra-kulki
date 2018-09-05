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

    wire [11:0] ctl_address;
    wire [11:0] rgb_pixel;
    
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
