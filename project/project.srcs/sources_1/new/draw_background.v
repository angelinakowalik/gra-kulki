// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

`include "_vga_macros.vh"

module draw_background (
    input wire  pclk,
    input wire  rst,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out
  );
  
  `VGA_INPUT(vga_in)
  `VGA_OUT_REG
  `VGA_OUTPUT(vga_out)
  
  localparam    UP = 32,
                LEFT_SIDE = 256,
                SQUARE_SIZE = 64,
                LINE_COLOR = 12'h0_0_0,
                BACK_COLOR = 12'hc_c_c,
                FRAME_COLOR = 12'h0_f_f;
				
  integer i, j;
  reg [11:0] rgb_out_nxt;
  reg [11:0] hcount_temp, vcount_temp;
  reg hsync_temp, vsync_temp, hblnk_temp, vblnk_temp;
       
  always @(posedge pclk)
    begin
        if(rst)
            begin                              
                vcount_out <= 0;
                hcount_out <= 0;
                
                vsync_out <= 0;
                vblnk_out <= 0;
                hsync_out <= 0;
                hblnk_out <= 0;
                
                rgb_out <= 0;                
            end
        else
            begin                         
                vcount_out <= vcount_in;
                hcount_out <= hcount_in;
                
                vsync_out <= vsync_in;
                vblnk_out <= vblnk_in;                
                hsync_out <= hsync_in;
                hblnk_out <= hblnk_in;
                
                rgb_out <= rgb_out_nxt;
            end
    end
    
    always @*
        begin
            rgb_out_nxt = rgb_in;
            
            // During blanking, make it it black.
            if (vblnk_in || hblnk_in) rgb_out_nxt = 12'h0_0_0; 
            else
            begin
             // Active display, top edge, make a yellow line.
				if (vcount_in == 0) rgb_out_nxt = FRAME_COLOR;
              // Active display, bottom edge, make a red line.
				else if (vcount_in == 599) rgb_out_nxt = FRAME_COLOR;
				// Active display, left edge, make a green line.
				else if (hcount_in == 0) rgb_out_nxt = FRAME_COLOR;
				// Active display, right edge, make a blue line.
				else if (hcount_in == 799) rgb_out_nxt = FRAME_COLOR;
				// Active display, interior, fill with gray.
              // You will replace this with your own test.
		
		
             //linie poziome
              else if(hcount_in >= (LEFT_SIDE - 3) && hcount_in <= LEFT_SIDE + 3 && vcount_in >= UP - 3 && vcount_in <= UP + 8*SQUARE_SIZE + 3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= (LEFT_SIDE - 3 + SQUARE_SIZE) && hcount_in <= LEFT_SIDE + 3 + SQUARE_SIZE && vcount_in >= UP - 3 && vcount_in <= UP + 8*SQUARE_SIZE + 3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 + SQUARE_SIZE*2 && hcount_in <= LEFT_SIDE + 3 + SQUARE_SIZE*2 && vcount_in >= UP - 3 && vcount_in <= UP + 8*SQUARE_SIZE + 3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 + SQUARE_SIZE*3 && hcount_in <= LEFT_SIDE + 3 + SQUARE_SIZE*3 && vcount_in >= UP - 3 && vcount_in <= UP + 8*SQUARE_SIZE + 3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 + SQUARE_SIZE*4 && hcount_in <= LEFT_SIDE + 3 + SQUARE_SIZE*4 && vcount_in >= UP - 3 && vcount_in <= UP + 8*SQUARE_SIZE + 3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 + SQUARE_SIZE*5 && hcount_in <= LEFT_SIDE + 3 + SQUARE_SIZE*5 && vcount_in >= UP - 3 && vcount_in <= UP + 8*SQUARE_SIZE + 3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 + SQUARE_SIZE*6 && hcount_in <= LEFT_SIDE + 3 + SQUARE_SIZE*6 && vcount_in >= UP - 3 && vcount_in <= UP + 8*SQUARE_SIZE + 3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 + SQUARE_SIZE*7 && hcount_in <= LEFT_SIDE + 3 + SQUARE_SIZE*7 && vcount_in >= UP - 3 && vcount_in <= UP + 8*SQUARE_SIZE + 3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 + SQUARE_SIZE*8 && hcount_in <= LEFT_SIDE + 3 + SQUARE_SIZE*8 && vcount_in >= UP - 3 && vcount_in <= UP + 8*SQUARE_SIZE + 3) rgb_out_nxt = LINE_COLOR;
              //else if(hcount_in >= 767 && hcount_in <= 773 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              
              //linie pionowe
              else if(hcount_in >= LEFT_SIDE - 3 && hcount_in <= LEFT_SIDE + 3 + 8*SQUARE_SIZE && vcount_in >= UP - 3 && vcount_in <= UP + 3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 && hcount_in <= LEFT_SIDE + 3 + 8*SQUARE_SIZE && vcount_in >= UP - 3 + SQUARE_SIZE && vcount_in <= UP + 3 + SQUARE_SIZE) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 && hcount_in <= LEFT_SIDE + 3 + 8*SQUARE_SIZE && vcount_in >= UP - 3 + SQUARE_SIZE*2 && vcount_in <= UP + 3 + SQUARE_SIZE*2) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 && hcount_in <= LEFT_SIDE + 3 + 8*SQUARE_SIZE && vcount_in >= UP - 3 + SQUARE_SIZE*3 && vcount_in <= UP + 3 + SQUARE_SIZE*3) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 && hcount_in <= LEFT_SIDE + 3 + 8*SQUARE_SIZE && vcount_in >= UP - 3 + SQUARE_SIZE*4 && vcount_in <= UP + 3 + SQUARE_SIZE*4) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 && hcount_in <= LEFT_SIDE + 3 + 8*SQUARE_SIZE && vcount_in >= UP - 3 + SQUARE_SIZE*5 && vcount_in <= UP + 3 + SQUARE_SIZE*5) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 && hcount_in <= LEFT_SIDE + 3 + 8*SQUARE_SIZE && vcount_in >= UP - 3 + SQUARE_SIZE*6 && vcount_in <= UP + 3 + SQUARE_SIZE*6) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 && hcount_in <= LEFT_SIDE + 3 + 8*SQUARE_SIZE && vcount_in >= UP - 3 + SQUARE_SIZE*7 && vcount_in <= UP + 3 + SQUARE_SIZE*7) rgb_out_nxt = LINE_COLOR;
              else if(hcount_in >= LEFT_SIDE - 3 && hcount_in <= LEFT_SIDE + 3 + 8*SQUARE_SIZE && vcount_in >= UP - 3 + SQUARE_SIZE*8 && vcount_in <= UP + 3 + SQUARE_SIZE*8) rgb_out_nxt = LINE_COLOR;
              //else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 567 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
    
				else rgb_out_nxt = BACK_COLOR;
			end
              
        end     
endmodule
