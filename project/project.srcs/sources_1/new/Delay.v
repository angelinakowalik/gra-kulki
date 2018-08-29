`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2018 15:05:30
// Design Name: 
// Module Name: Delay
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


module my_delay(
    input wire pclk,
    input wire [11:0] xpos, ypos,
    output reg [11:0] xpos_d, ypos_d
    );
    
    always @(posedge pclk)
        begin
            xpos_d <= xpos;
            ypos_d <= ypos;
        end
endmodule
