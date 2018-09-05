// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

`include "_vga_macros.vh"

module vga_timing (
    input wire  pclk,
    input wire  rst,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out
  );

`VGA_OUT_WIRE
`VGA_OUTPUT(vga_out)

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.

  localparam    HOR_TOTAL_TIME  = 1055,
                HOR_BLANK_START = 800,
                HOR_BLANK_TIME  = 256,
                HOR_SYNC_START  = 840,
                HOR_SYNC_TIME   = 128,
                
                VER_TOTAL_TIME  = 627,
                VER_BLANK_START = 600,
                VER_BLANK_TIME  = 28,
                VER_SYNC_START  = 601,
                VER_SYNC_TIME   = 4;
                
    reg [11:0]  vcount_nxt = 0,  hcount_nxt = 0, vcount_temp = 0, hcount_temp = 0;
    reg vsync_nxt = 0, hsync_nxt = 0;
    reg vblnk_nxt = 0, hblnk_nxt = 0;
    reg [11:0] rgb_nxt = 0, rgb_temp = 0;                        


    always @(posedge pclk) 
    begin
        if(rst)
        begin
            vcount_temp  <= 0;
            hcount_temp  <= 0;
            rgb_temp     <= 0;
        end
        else begin
            vcount_temp  <= vcount_nxt;
            hcount_temp  <= hcount_nxt;
            rgb_temp     <= rgb_nxt;
        end
    end

    always @*
    begin
       rgb_nxt = 12'hf_f_f;
        
        if(hcount_out >= HOR_TOTAL_TIME)
        begin
            hcount_nxt = 0;
            if(vcount_out >= VER_TOTAL_TIME)
                vcount_nxt = 0;
            else vcount_nxt = vcount_out + 1;
        end
        else begin
            hcount_nxt = hcount_out + 1;
            vcount_nxt = vcount_out;
        end 
    end
  
    assign hcount_out = hcount_temp;
    assign vcount_out = vcount_temp;
    assign hblnk_out = ((hcount_out >= HOR_BLANK_START) && (hcount_out <= HOR_BLANK_START + HOR_BLANK_TIME));
    assign hsync_out = ((hcount_out >= HOR_SYNC_START) && (hcount_out <= HOR_SYNC_START + HOR_SYNC_TIME));
    assign vblnk_out = ((vcount_out >= VER_BLANK_START) && (vcount_out <= VER_BLANK_START + VER_BLANK_TIME));
    assign vsync_out = ((vcount_out >= VER_SYNC_START) && (vcount_out <= VER_SYNC_START + VER_SYNC_TIME));
    assign rgb_out = rgb_temp;
          
endmodule
