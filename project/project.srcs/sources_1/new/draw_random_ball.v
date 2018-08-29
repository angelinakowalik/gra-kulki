`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2018 23:26:10
// Design Name: 
// Module Name: draw_random_ball
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

module draw_random_ball(
    input wire          pclk,
    input wire          rst,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,   
    input wire [5:0]    color_in,
    input wire [11:0]   rgb_pixel_r,
    input wire [11:0]   rgb_pixel_b,
    input wire [11:0]   rgb_pixel_g,
    input wire [11:0]   rgb_pixel_y,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out,
    output reg [11:0]   address_random,
    output reg random_en,
    output reg ball_en
    );
    
    `VGA_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_OUTPUT(vga_out)
    
    localparam  UP          = 416,
                LEFT        = 32,
                SQUARE_SIZE = 64,
                BALL_SIZE   = 50,
                DRAW_BALL   = (SQUARE_SIZE/2) - (BALL_SIZE/2),
                LINE_COLOR  = 12'h0_0_0;
                
    integer i;
    reg [11:0] rgb_out_nxt = 0;
    reg [5:0] addrx = 0, addry = 0;
    
    always @(posedge pclk)
        begin
        if(rst)
        begin            
            hcount_out <= 0;
            hsync_out <= 0;
            hblnk_out <= 0;
            vcount_out <= 0;    
            vsync_out <= 0;
            vblnk_out <= 0;
                  
            rgb_out <= 0;
            address_random <= 0;
        end
        else begin
            hcount_out <= hcount_in;                
            hsync_out <= hsync_in;
            hblnk_out <= hblnk_in;
            vcount_out <= vcount_in;                  
            vsync_out <= vsync_in;
            vblnk_out <= vblnk_in;
                  
            rgb_out <= rgb_out_nxt;
            address_random  <= {addry, addrx};
        end
    end

    always @* begin
            addrx = hcount_in;
            addry = vcount_in;
            rgb_out_nxt = rgb_out;
            random_en = 1'b1;
            ball_en = 1'b0;
            
            if     ((hcount_in >= (LEFT - 3)) && 
    				(hcount_in <= (LEFT + 3*SQUARE_SIZE + 3)) &&
    				(vcount_in >= (UP - 3)) &&
    			    (vcount_in <= (UP + 3)) )
    				    rgb_out_nxt = LINE_COLOR;
    			
            else if((hcount_in >= (LEFT - 3)) && 
    				(hcount_in <= (LEFT + 3*SQUARE_SIZE + 3)) &&
    				(vcount_in >= (UP + SQUARE_SIZE - 3)) &&
    				(vcount_in <= (UP + SQUARE_SIZE + 3)))
                        rgb_out_nxt = LINE_COLOR;
    					
            else if((hcount_in >= (LEFT - 3)) && 
    				(hcount_in <= (LEFT + 3)) &&
    				(vcount_in >= (UP - 3)) &&
    				(vcount_in <= (UP + SQUARE_SIZE + 3)) )
    					rgb_out_nxt = LINE_COLOR;
    					
            else if((hcount_in >= (LEFT + 3*SQUARE_SIZE - 3)) && 
    				(hcount_in <= (LEFT + 3*SQUARE_SIZE + 3)) &&
    				(vcount_in >= (UP - 3)) &&
    				(vcount_in <= (UP + SQUARE_SIZE + 3)) )
    					rgb_out_nxt = LINE_COLOR;
    					
    		else if((hcount_in >= (LEFT + DRAW_BALL)) &&
                    (hcount_in <= (LEFT + DRAW_BALL + BALL_SIZE)) &&
                    (vcount_in >= (UP + DRAW_BALL)) &&
                    (vcount_in <= (UP + DRAW_BALL + BALL_SIZE)))
                    begin
                        case(color_in[5:4])
                            2'b00:      rgb_out_nxt = rgb_pixel_r;
                            2'b01:      rgb_out_nxt = rgb_pixel_b;
                            2'b10:      rgb_out_nxt = rgb_pixel_g;
                            2'b11:      rgb_out_nxt = rgb_pixel_y;
                            default:    rgb_out_nxt = rgb_out;
                        endcase
                    end
            else if((hcount_in >= (LEFT + DRAW_BALL + SQUARE_SIZE)) &&
                    (hcount_in <= (LEFT + DRAW_BALL + SQUARE_SIZE + BALL_SIZE)) &&
                    (vcount_in >= (UP + DRAW_BALL)) &&
                    (vcount_in <= (UP + DRAW_BALL + BALL_SIZE)))
                    begin
                        case(color_in[3:2])
                            2'b00:      rgb_out_nxt = rgb_pixel_r;
                            2'b01:      rgb_out_nxt = rgb_pixel_b;
                            2'b10:      rgb_out_nxt = rgb_pixel_g;
                            2'b11:      rgb_out_nxt = rgb_pixel_y;
                            default:    rgb_out_nxt = rgb_out;                        
                        endcase
                    end
                    
            else if((hcount_in >= (LEFT + DRAW_BALL + SQUARE_SIZE*2)) &&
                    (hcount_in <= (LEFT + DRAW_BALL + SQUARE_SIZE*2 + BALL_SIZE)) &&
                    (vcount_in >= (UP + DRAW_BALL)) &&
                    (vcount_in <= (UP + DRAW_BALL + BALL_SIZE)))
                    begin
                        case(color_in[1:0])
                            2'b00:      rgb_out_nxt = rgb_pixel_r;
                            2'b01:      rgb_out_nxt = rgb_pixel_b;
                            2'b10:      rgb_out_nxt = rgb_pixel_g;
                            2'b11:      rgb_out_nxt = rgb_pixel_y;
                            default:    rgb_out_nxt = rgb_out;
                        endcase
                    end					
    		else rgb_out_nxt = rgb_in;
    end     
endmodule
    