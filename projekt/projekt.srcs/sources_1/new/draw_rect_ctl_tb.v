`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2018 21:06:12
// Design Name: 
// Module Name: draw_rect_ctl_tb
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


module draw_rect_ctl_tb(
    output reg mouse_left,
    output reg [11:0] mouse_xpos,
    output reg [11:0] mouse_ypos
    );
    
   initial
   begin
    mouse_xpos = 0;
    mouse_ypos = 0;
    mouse_left = 0;
    #100;
    mouse_xpos = 500;
    mouse_ypos = 500;
    #200;
    mouse_left = 1;
    #10;
    mouse_left = 0;
   end
   
endmodule
