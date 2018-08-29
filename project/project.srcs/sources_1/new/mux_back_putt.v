`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 13:10:24
// Design Name: 
// Module Name: mux_back_putt
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


module mux_back_putt(
    input wire          pclk,
    input wire          rst,
    input wire          back,
    input wire          putt,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    input wire [11:0]   x_back,
    input wire [11:0]   y_back,
    input wire [11:0]   x_putt,
    input wire [11:0]   y_putt,
    
    output reg [11:0]   x_ctl,
    output reg [11:0]   y_ctl
    );
    
    reg [11:0] x_ctl_nxt = 0, y_ctl_nxt = 0;
    
    always @(posedge pclk)
    begin
        if(rst)
        begin
            x_ctl <= 0;
            y_ctl <= 0;
        end
        else begin
            x_ctl <= x_ctl_nxt;
            y_ctl <= y_ctl_nxt;
        end
    end
    
    always @*
    begin
        if(back == 1) begin
            x_ctl_nxt = x_back;
            y_ctl_nxt = y_back;
        end
        else if(putt == 1)
        begin
            x_ctl_nxt = x_putt;
            y_ctl_nxt = y_putt;
        end
        else begin
            x_ctl_nxt = mouse_xpos;
            y_ctl_nxt = mouse_ypos; 
        end
    end
endmodule
