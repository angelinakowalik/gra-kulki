`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2018 14:18:15
// Design Name: 
// Module Name: write_data
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

`include "_color_macros.vh"

module write_data(
    input wire          pclk,
    input wire          rst,
    input wire          write,
    input wire          delete,
    input wire [3:0]    column,
    input wire [3:0]    row,
    input wire [3:0]    column_del,
    input wire [3:0]    row_del,
    input wire  [`COLOR_BUS_SIZE - 1:0] color_in,
    input wire [1:0]    transfer_color,
    
    output wire [`COLOR_BUS_SIZE - 1:0] color_out
    );
    
    `COLOR_INPUT(color_in)
    `COLOR_OUT_REG
    `COLOR_OUTPUT(color_out)
    
    reg [63:0] color_r_nxt, color_b_nxt, color_g_nxt, color_y_nxt;
    reg [63:0] temp_reg, temp_del;
    
    always @(posedge pclk)
    begin
        if(rst)
        begin
            color_r_out     <= 64'b0;
            color_b_out     <= 64'b0;
            color_g_out     <= 64'b0;
            color_y_out     <= 64'b0;            
        end
        else begin
            color_r_out     <= color_r_nxt;
            color_b_out     <= color_b_nxt;
            color_g_out     <= color_g_nxt;
            color_y_out     <= color_y_nxt;  
        end
    end
    
    always @*
    begin
        temp_reg = 1'b1 << (column + 8*row);
        temp_del = 1'b1 << (column_del + 8*row_del);
        
        if(write)
        begin               
            color_r_nxt = color_r_in;
            color_b_nxt = color_b_in;
            color_g_nxt = color_g_in;
            color_y_nxt = color_y_in;
            
            case(transfer_color)
                2'b00: color_r_nxt = (color_r_in | temp_reg);
                2'b01: color_b_nxt = (color_b_in | temp_reg);
                2'b10: color_g_nxt = (color_g_in | temp_reg);
                2'b11: color_y_nxt = (color_y_in | temp_reg);
            endcase            
        end
        
        else if(delete)
        begin
            color_r_nxt = color_r_in;
            color_b_nxt = color_b_in;    
            color_g_nxt = color_g_in;
            color_y_nxt = color_y_in;
            
            case(transfer_color)
                2'b00: color_r_nxt = (color_r_in & (~temp_del));
                2'b01: color_b_nxt = (color_b_in & (~temp_del));
                2'b10: color_g_nxt = (color_g_in & (~temp_del));
                2'b11: color_y_nxt = (color_y_in & (~temp_del));
            endcase            
        end
        
        else begin
            color_r_nxt = color_r_in;
            color_b_nxt = color_b_in;    
            color_g_nxt = color_g_in;
            color_y_nxt = color_y_in;
        end
    end
    
endmodule
