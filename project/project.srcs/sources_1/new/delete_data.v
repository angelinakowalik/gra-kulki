`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.07.2018 21:16:01
// Design Name: 
// Module Name: delete_data
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


module delete_data(
    input wire          pclk,
    input wire          rst,
    input wire          delete,
    input wire [3:0]    column,
    input wire [3:0]    row,
    input wire [63:0]   ball_reg_in,
    input wire [63:0]   color_r_in,
    input wire [63:0]   color_b_in,
    input wire [63:0]   color_g_in,
    input wire [63:0]   color_y_in,
    input wire [1:0]    transfer_color,

    output reg [63:0]  ball_reg_out,
    output reg [63:0]  color_r_out,
    output reg [63:0]  color_b_out,
    output reg [63:0]  color_g_out,
    output reg [63:0]  color_y_out
    );
    
    
    reg [63:0] ball_reg_nxt, color_r_nxt, color_b_nxt, color_g_nxt, color_y_nxt, temp_reg, temp_reg_nxt;
    
    always @(posedge pclk)
    begin
        if(rst)
        begin
            ball_reg_out    <= 64'b0;
            color_r_out     <= 64'b0;
            color_b_out     <= 64'b0;
            color_g_out     <= 64'b0;
            color_y_out     <= 64'b0;
            
            temp_reg        <= 64'b0;
        end
        else begin
            ball_reg_out    <= ball_reg_nxt;
            color_r_out     <= color_r_nxt;
            color_b_out     <= color_b_nxt;
            color_g_out     <= color_g_nxt;
            color_y_out     <= color_y_nxt;
            
            temp_reg        <= temp_reg_nxt;    
        end
    end
    
    always @*
    begin
        if(delete)
        begin
            temp_reg_nxt = 1'b1 << (column + 8*row);   

            color_r_nxt = color_r_in;
            color_b_nxt = color_b_in;    
            color_g_nxt = color_g_in;
            color_y_nxt = color_y_in;
            
            case(transfer_color)
                2'b00: color_r_nxt = (color_r_in & (~temp_reg_nxt));
                2'b01: color_b_nxt = (color_b_in & (~temp_reg_nxt));
                2'b10: color_g_nxt = (color_g_in & (~temp_reg_nxt));
                2'b11: color_y_nxt = (color_y_in & (~temp_reg_nxt));
            endcase
            
            ball_reg_nxt = (color_r_nxt || color_b_nxt || color_g_nxt || color_y_nxt);
        end
        
        else begin
            ball_reg_nxt = ball_reg_in;
            color_r_nxt = color_r_in;
            color_b_nxt = color_b_in;    
            color_g_nxt = color_g_in;
            color_y_nxt = color_y_in;
        end
    end

endmodule
