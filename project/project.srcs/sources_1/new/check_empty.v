`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2018 09:23:33
// Design Name: 
// Module Name: check_empty
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


module check_empty(
    input wire          clk,
    input wire          rst,
    input wire [3:0]    column,
    input wire [3:0]    row,
    input wire [63:0]   color_r,
    input wire [63:0]   color_b,
    input wire [63:0]   color_g,
    input wire [63:0]   color_y,
    
    output reg          empty,
    output reg [1:0]    transfer_color
    );
    
    reg empty_nxt = 0;
    reg [1:0] transfer_color_nxt;
    reg [63:0] ball_reg;
    
    always @(posedge clk)
    begin
        if(rst)
        begin
            empty           <= 0;
            transfer_color  <= 0;
        end
        else begin
            empty           <= empty_nxt;
            transfer_color  <= transfer_color_nxt;
        end
    end
    
    always @*
    begin
        ball_reg = (color_r | color_b | color_g | color_y);
        empty_nxt = !(ball_reg[column + 8*row] && 1'b1);
        
        if(color_r[column + 8*row])
            transfer_color_nxt = 2'b00;
        else if(color_b[column + 8*row])
            transfer_color_nxt = 2'b01;
        else if(color_g[column + 8*row])
            transfer_color_nxt = 2'b10;
        else if(color_y[column + 8*row])
            transfer_color_nxt = 2'b11;
        else
            transfer_color_nxt = 2'b00;                  
    end
   
endmodule
