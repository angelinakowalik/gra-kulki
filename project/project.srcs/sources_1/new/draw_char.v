`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 13:54:31
// Design Name: 
// Module Name: draw_char
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

module draw_char(
    input wire          pclk,
    input wire          rst,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    input wire [7:0]    char_pixel,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out,
    output reg  [7:0]   char_xy,
    output reg  [3:0]   char_line
    );
    
    `VGA_INPUT(vga_in)
    `VGA_OUT_WIRE
    `VGA_OUTPUT(vga_out)
    
localparam  TEXTRECT_WIDTH = 16,
            TEXTRECT_HIGH = 16,
            TEXT_COLOR = 12'hf_f_f,
            TEXT_POSITION_X = 80,
            TEXT_POSITION_Y = 0,
            RECT_Y           = 11'd30,
            RECT_X           = 11'd30,
            HEIGHT           = 256,
            WIDTH            = 128;
    
    reg [3:0]   pixel_index;
    reg [11:0]  rgb_out_nxt = 0, rgb_in_nxt = 0, rgb_nxt = 0, rgb_temp = 0;
    reg [3:0]   char_line_nxt = 0;
    reg [7:0]   char_xy_nxt = 0;
    reg [10:0]  hcount_temp = 0;
    reg [10:0]  vcount_temp = 0;
    wire [10:0]  vcount_rect = 0;
    wire [10:0]  hcount_rect = 0;
    
    always @(posedge pclk)
        begin
            if(rst)
            begin
                rgb_in_nxt  <= 0;
                rgb_temp     <= 0;
                
                char_line   <= 0;
                char_xy     <= 0;
            end 
            else begin
                rgb_in_nxt <= rgb_in;
                //rgb_nxt <= rgb_in_nxt;
                rgb_temp <= rgb_out_nxt;
            
                char_line <= char_line_nxt;
                char_xy <= char_xy_nxt;
            end
        end    

    always @*
    begin
        char_line_nxt   = 0;
        pixel_index     = 0;
        rgb_out_nxt     = rgb_in_nxt; 
        char_xy_nxt     = char_xy;
        hcount_temp      = hcount_in - 300;    
        vcount_temp      = vcount_in - 200;  
        
        if((hcount_out >= TEXT_POSITION_X) && (hcount_out < TEXT_POSITION_X+8*TEXTRECT_WIDTH) && (vcount_out >= TEXT_POSITION_Y) && (vcount_out < TEXT_POSITION_Y + 16*TEXTRECT_HIGH) ) 
        begin
            pixel_index = (hcount_out - 300)% 8;
            if( char_pixel[7-pixel_index] == 1)    rgb_out_nxt = TEXT_COLOR; 
            //else rgb_out_nxt = rgb_nxt;
        end
            
        if((hcount_out >= TEXT_POSITION_X) && (hcount_in < TEXT_POSITION_X + 8*TEXTRECT_WIDTH) && (vcount_out >= TEXT_POSITION_Y) && (vcount_in < TEXT_POSITION_Y+16*TEXTRECT_HIGH) )
        begin
            char_line_nxt   = vcount_temp[3:0];
            char_xy_nxt     = {vcount_temp[7:4], hcount_temp[6:3]};
        end
    end
    
    assign rgb_out = rgb_temp;

// --------------------------------------------------------------- 
           
    delay_2 #(
        .WIDTH(26),
        .CLK_DEL(2)
    ) u_delay (
        .clk(pclk),
        .rst(rst),
        .din({hcount_in, hsync_in, hblnk_in, vcount_in, vsync_in, vblnk_in}),
        .dout({hcount_out, hsync_out, hblnk_out, vcount_out, vsync_out, vblnk_out})
    );
            
    
endmodule
