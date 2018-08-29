`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2018 22:44:37
// Design Name: 
// Module Name: color_ball
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


module color_ball(
    input wire pclk,
    input wire [11:0] address_ball,
    input wire [11:0] address_random,
    input wire ball_en,
    input wire random_en,
    
    output wire [11:0] rgb_pixel_r,
    output wire [11:0] rgb_pixel_b,
    output wire [11:0] rgb_pixel_g,
    output wire [11:0] rgb_pixel_y  
    );
    
    reg [11:0] address;
    
    always @*
        case({ball_en, random_en})
            2'b01: address = address_random;
            2'b10: address = address_ball;
            default: address = address_ball;
        endcase
    
    // ---------------------------------------------------------------
    
        image_rom my_image_r (
            .clk(pclk),
            .color_in(2'b00),
            .address(address),
            
            .rgb(rgb_pixel_r)
        );
    
    // ---------------------------------------------------------------
    
        image_rom my_image_b (
            .clk(pclk),
            .color_in(2'b01),
            .address(address),
            
            .rgb(rgb_pixel_b)
        );
    
    // ---------------------------------------------------------------
    
        image_rom my_image_g (
            .clk(pclk),
            .color_in(2'b10),
            .address(address),
            
            .rgb(rgb_pixel_g)
        );
    
    // ---------------------------------------------------------------
    
        image_rom my_image_y (
            .clk(pclk),
            .color_in(2'b11),
            .address(address),
            
            .rgb(rgb_pixel_y)
        );

endmodule
