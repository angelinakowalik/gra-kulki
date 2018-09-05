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
    input wire [35:0]    rgb_pixel,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out,
    output reg [11:0]   address_random
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
    reg [11:0] rgb_out_nxt = 0, rgb_nxt;
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
            rgb_nxt <= 0;
            address_random <= 0;
        end
        else begin
            hcount_out <= hcount_in;                
            hsync_out <= hsync_in;
            hblnk_out <= hblnk_in;
            vcount_out <= vcount_in;                  
            vsync_out <= vsync_in;
            vblnk_out <= vblnk_in;
            
            rgb_nxt <= rgb_in;      
            rgb_out <= rgb_out_nxt;
            address_random  <= {addry, addrx};
        end
    end

    always @* begin
            addrx = hcount_in - SQUARE_SIZE/2 + 2;
            addry = vcount_in - SQUARE_SIZE/2;
            rgb_out_nxt = rgb_nxt;
            
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
                        if(rgb_pixel[35:24] == 12'hf_f_f)
                            rgb_out_nxt = rgb_nxt;
                        else
                            rgb_out_nxt = rgb_pixel[35:24];
                    end
            else if((hcount_in >= (LEFT + DRAW_BALL + SQUARE_SIZE)) &&
                    (hcount_in <= (LEFT + DRAW_BALL + SQUARE_SIZE + BALL_SIZE)) &&
                    (vcount_in >= (UP + DRAW_BALL)) &&
                    (vcount_in <= (UP + DRAW_BALL + BALL_SIZE)))
                    begin
                        if(rgb_pixel[23:12] == 12'hf_f_f)
                            rgb_out_nxt = rgb_nxt;                    
                        else
                            rgb_out_nxt = rgb_pixel[23:12];
                    end
                    
            else if((hcount_in >= (LEFT + DRAW_BALL + SQUARE_SIZE*2)) &&
                    (hcount_in <= (LEFT + DRAW_BALL + SQUARE_SIZE*2 + BALL_SIZE)) &&
                    (vcount_in >= (UP + DRAW_BALL)) &&
                    (vcount_in <= (UP + DRAW_BALL + BALL_SIZE)))
                    begin
                        if(rgb_pixel[11:0] == 12'hf_f_f)
                            rgb_out_nxt = rgb_nxt;                    
                        else
                            rgb_out_nxt = rgb_pixel[11:0];
                    end					
    		else rgb_out_nxt = rgb_nxt;
    end     
endmodule
    