// File: vga_timing.v
// Author: Weronika Potaczek
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module draw_background (
  input wire [10:0] vcount_in,
  input wire vsync_in,
  input wire vblnk_in,
  input wire [10:0] hcount_in,
  input wire hsync_in,
  input wire hblnk_in,
  input wire pclk,
  input wire rst,  
  
  output reg [10:0] vcount_out,
  output reg vsync_out,
  output reg vblnk_out,
  output reg [10:0] hcount_out,
  output reg hsync_out,
  output reg hblnk_out,
  output reg [11:0] rgb_out
  );
  
  reg [11:0] rgb_out_nxt;
       
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
            // During blanking, make it it black.
            if (vblnk_in || hblnk_in) rgb_out_nxt <= 12'h0_0_0; 
            else
            begin
             // Active display, top edge, make a yellow line.
              if (vcount_in == 0) rgb_out_nxt <= 12'hf_f_0;
              // Active display, bottom edge, make a red line.
              else if (vcount_in == 599) rgb_out_nxt <= 12'hf_0_0;
              // Active display, left edge, make a green line.
              else if (hcount_in == 0) rgb_out_nxt <= 12'h0_f_0;
              // Active display, right edge, make a blue line.
              else if (hcount_in == 799) rgb_out_nxt <= 12'h0_0_f;
              // Active display, interior, fill with gray.
              // You will replace this with your own test.
              
              //linie poziome
              else if(hcount_in >= 227 && hcount_in <= 233 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 287 && hcount_in <= 293 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 347 && hcount_in <= 353 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 407 && hcount_in <= 413 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 467 && hcount_in <= 473 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 527 && hcount_in <= 533 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 587 && hcount_in <= 593 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 647 && hcount_in <= 653 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 707 && hcount_in <= 713 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 767 && hcount_in <= 773 && vcount_in >= 27 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
              
              //linie pionowe
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 27 && vcount_in <= 33) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 87 && vcount_in <= 93) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 147 && vcount_in <= 153) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 207 && vcount_in <= 213) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 267 && vcount_in <= 273) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 327 && vcount_in <= 333) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 387 && vcount_in <= 393) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 447 && vcount_in <= 453) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 507 && vcount_in <= 513) rgb_out_nxt <= 12'h0_0_0;
              else if(hcount_in >= 227 && hcount_in <= 773 && vcount_in >= 567 && vcount_in <= 573) rgb_out_nxt <= 12'h0_0_0;
            
              else rgb_out_nxt <= 12'h8_8_8;
              
            end
        end     
endmodule
