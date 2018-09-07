`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2018 22:36:56
// Design Name: 
// Module Name: vga_mux
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

module vga_mux(
    input wire clk,
    input wire rst,
    input wire [`VGA_BUS_SIZE - 1:0] vga_start,
    input wire [`VGA_BUS_SIZE - 1:0] vga_game,
    input wire [`VGA_BUS_SIZE - 1:0] vga_end,
    input wire start_mode,
    input wire game_mode,
    input wire end_mode,
      
    output reg [`VGA_BUS_SIZE - 1:0] vga_out
    );
    
    reg [`VGA_BUS_SIZE - 1:0] vga_nxt;
    
    always @(posedge clk)
    begin
        if(rst)
            vga_out <= vga_start;
        else
            vga_out <= vga_nxt;
    end
    
    always @*
    begin
        case({end_mode, game_mode, start_mode})
            3'b001: vga_nxt = vga_start;
            3'b010: vga_nxt = vga_game;
            3'b100: vga_nxt = vga_end;
            default: vga_nxt = vga_start;
        endcase
    end
endmodule
