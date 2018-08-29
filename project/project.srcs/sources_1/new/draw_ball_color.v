`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.08.2018 09:32:29
// Design Name: 
// Module Name: draw_ball_color
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

module draw_ball_color(
    input wire          pclk,
    input wire          rst,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    input wire [63:0]   color_in,
    input wire [11:0]   rgb_pixel,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out,
    output reg [11:0]   pixel_addr,
    output reg ball_en,
    output reg random_en
    );
    
    `VGA_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_OUTPUT(vga_out)
    
    localparam  UP          = 32,
                LEFT        = 256,
                SQUARE_SIZE = 64,
                BALL_SIZE   = 50,
                DRAW_BALL = (SQUARE_SIZE/2) - (BALL_SIZE/2);
                    
    reg [5:0] addrx = 0, addry = 0;
    reg [6:0] column = 0, row = 0;
    reg [11:0] rgb_nxt = 0, rgb_out_nxt = 0;
    reg [1:0] color_nxt = 2'b0;
    
    reg [10:0] hcount_temp, vcount_temp;
    reg hsync_temp, vsync_temp, hblnk_temp, vblnk_temp;  
    
    integer i;
                
    always @(posedge pclk)
    begin
        if(rst)
        begin
            hcount_temp  <= 0;
            hsync_temp   <= 0;
            hblnk_temp   <= 0;
            vcount_temp  <= 0;
            vsync_temp   <= 0;
            vblnk_temp   <= 0;
                              
            hcount_out  <= 0;
            hsync_out   <= 0;
            hblnk_out   <= 0;
            vcount_out  <= 0;
            vsync_out   <= 0;
            vblnk_out   <= 0;            
            
            rgb_out_nxt <= 0;
            rgb_out     <= 0;
            pixel_addr  <= 0;
        end
        else begin  
            hcount_temp  <= hcount_in;
            hsync_temp   <= hsync_in;
            hblnk_temp   <= hblnk_in;
            vcount_temp  <= vcount_in;
            vsync_temp   <= vsync_in;
            vblnk_temp   <= vblnk_in;
                    
            hcount_out  <= hcount_temp;
            hsync_out   <= hsync_temp;
            hblnk_out   <= hblnk_temp;
            vcount_out  <= vcount_temp;
            vsync_out   <= vsync_temp;
            vblnk_out   <= vblnk_temp;            
            
            rgb_out_nxt <= rgb_nxt;
            rgb_out     <= rgb_out_nxt;
            pixel_addr  <= {addry, addrx};
        end
    end
    
    always @*
    begin
            addrx = hcount_in;
            addry = vcount_in;
            
            rgb_nxt = rgb_in;
            
            ball_en = 1'b1;
            random_en = 1'b0;     
                    
            for(i = 0; i < 64; i = i + 1)
            begin
                if(color_in[i] == 1) begin
                    row = (i >> 3) + 1;
                    column = i - (row - 1)*8 + 1;            
                    if ((hcount_in >= LEFT + SQUARE_SIZE*(column - 1) + DRAW_BALL) &&
                        (hcount_in <= LEFT + SQUARE_SIZE*(column - 1) + DRAW_BALL + BALL_SIZE) &&
                        (vcount_in >= UP + SQUARE_SIZE*(row - 1) + DRAW_BALL) &&
                        (vcount_in <= UP + SQUARE_SIZE*(row - 1) + DRAW_BALL + BALL_SIZE) &&
                        !(vblnk_in || hblnk_in))
                        begin
                            rgb_nxt = rgb_pixel;
                        end
                end
            end
    end
endmodule
