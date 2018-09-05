`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 09:26:42
// Design Name: 
// Module Name: transfer_ball
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

module transfer_ball(
    input wire          pclk,
    input wire          rst,
    input wire [11:0]   xpos,
    input wire [11:0]   ypos,
    input wire [11:0]   rgb_pixel,
    input wire          transfer,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out,
    output reg [11:0]   pixel_addr
    );
    
    `VGA_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_OUTPUT(vga_out)
    
    reg [10:0]  hcount_temp, vcount_temp;
    reg         hsync_temp, vsync_temp, hblnk_temp, vblnk_temp;
    reg [11:0]  rgb_out_nxt = 0, rgb_nxt = 0;
    reg [5:0]   addrx, addry;
    
    localparam  WIDTH   = 50,
                HEIGHT  = 50,
                SQUARE_SIZE = 64;
                
    always @(posedge pclk)
    begin
        if(rst)
        begin
            hcount_temp <= 0;
            hsync_temp  <= 0;
            hblnk_temp  <= 0;
            vcount_temp <= 0;
            vsync_temp  <= 0;
            vblnk_temp  <= 0;
            
            rgb_nxt     <= 0;
            
            hcount_out  <= 0;
            hsync_out   <= 0;
            hblnk_out   <= 0;
            vcount_out  <= 0;
            vsync_out   <= 0;
            vblnk_out   <= 0;
            
            rgb_out     <= 0;
            
            pixel_addr  <= 0;
        end
        else begin
            hcount_temp <= hcount_in;
            hsync_temp  <= hsync_in;
            hblnk_temp  <= hblnk_in;
            vcount_temp <= vcount_in;
            vsync_temp  <= vsync_in;
            vblnk_temp  <= vblnk_in;
                   
            rgb_nxt     <= rgb_in;
                   
            hcount_out  <= hcount_temp;
            hsync_out   <= hsync_temp;
            hblnk_out   <= hblnk_temp;
            vcount_out  <= vcount_temp;
            vsync_out   <= vsync_temp;
            vblnk_out   <= vblnk_temp;
                    
            rgb_out     <= rgb_out_nxt;
            
            pixel_addr  <= {addry, addrx};
        end
    end
    
    always @*
    begin
        addrx = hcount_in - xpos + SQUARE_SIZE/2;
        addry = vcount_in - ypos + SQUARE_SIZE/2;
        rgb_out_nxt = rgb_nxt;
           
        if( (transfer == 1'b1) &&
             (hcount_temp >= xpos - WIDTH/2) && (hcount_temp <= xpos + WIDTH - WIDTH/2) &&
             (vcount_temp >= ypos - HEIGHT/2) && (vcount_temp <= ypos + HEIGHT - HEIGHT/2) &&
            !(vblnk_temp || hblnk_temp))
            begin
                if(rgb_pixel == 12'hf_f_f)
                    rgb_out_nxt = rgb_nxt;
                else
                    rgb_out_nxt = rgb_pixel;
            end
    end
endmodule
