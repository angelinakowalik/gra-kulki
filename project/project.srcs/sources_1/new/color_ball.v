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
    input wire [47:0] address,
    
    output wire [11:0] rgb_pixel_r,
    output wire [11:0] rgb_pixel_b,
    output wire [11:0] rgb_pixel_g,
    output wire [11:0] rgb_pixel_y  
    );

    

    
    // ---------------------------------------------------------------
    
        image_rom my_image_r (
            .clk(pclk),
            .color_in(2'b00),
            .address(address[11:0]),
            
            .rgb(rgb_pixel_r)
        );
    
    // ---------------------------------------------------------------
    
        image_rom my_image_b (
            .clk(pclk),
            .color_in(2'b01),
            .address(address[23:12]),
            
            .rgb(rgb_pixel_b)
        );
    
    // ---------------------------------------------------------------
    
        image_rom my_image_g (
            .clk(pclk),
            .color_in(2'b10),
            .address(address[35:24]),
            
            .rgb(rgb_pixel_g)
        );
    
    // ---------------------------------------------------------------
    
        image_rom my_image_y (
            .clk(pclk),
            .color_in(2'b11),
            .address(address[47:36]),
            
            .rgb(rgb_pixel_y)
        );

endmodule
