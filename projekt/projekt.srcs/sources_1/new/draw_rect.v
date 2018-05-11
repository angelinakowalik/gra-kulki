// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.
 
module draw_rect(
    input wire [10:0]   hcount_in,
    input wire          hsync_in,
    input wire          hblnk_in,
    input wire [10:0]   vcount_in,
    input wire          vsync_in,
    input wire          vblnk_in,
    input wire [11:0]   rgb_in,
    input wire          pclk,
    input wire          rst, 
    input wire [11:0]   xpos,
    input wire [11:0]   ypos,
    input wire [11:0]   rgb_pixel,
    
    output reg [10:0]   hcount_out,
    output reg          hsync_out,
    output reg          hblnk_out,
    output reg [10:0]   vcount_out,
    output reg          vsync_out,
    output reg          vblnk_out,
    output reg [11:0]   rgb_out,
    output reg [11:0]   pixel_addr
    );
 
    reg [10:0]  hcount_temp=0, vcount_temp=0,hcount_temp2=0, vcount_temp2=0;
    reg         hsync_temp=0, hblnk_temp=0, vsync_temp=0, vblnk_temp=0, 
                hsync_temp2=0, hblnk_temp2=0, vsync_temp2=0, vblnk_temp2=0;
    
    reg [11:0]  rgb_out_nxt = 0, rgb_nxt = 0, rgb_in_nxt = 0;
    reg [5:0]   addrx, addry;
    
    localparam  WIDTH  = 48,
                HIGH   = 64;
      
    always @(posedge pclk) begin
        // Just pass these through.
        
        if(rst)
             begin
                vcount_temp <= 0;
                hcount_temp <= 0;
                vsync_temp <= 0;
                vblnk_temp <= 0;
                hsync_temp <= 0;
                hblnk_temp <= 0;                
                rgb_in_nxt <= 0;
                        
                vcount_temp2 <= 0;
                hcount_temp2 <= 0;                                    
                vsync_temp2 <= 0;
                vblnk_temp2 <= 0;
                hsync_temp2 <= 0;
                hblnk_temp2 <= 0;                                    
                rgb_nxt <= 0;
                        
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
                hcount_temp  <= hcount_in;
                vcount_temp  <= vcount_in;      
                hsync_temp  <= hsync_in;
                vsync_temp   <= vsync_in;
                hblnk_temp   <= hblnk_in;
                vblnk_temp   <= vblnk_in;
        
                hcount_temp2  <= hcount_temp;
                vcount_temp2  <= vcount_temp;      
                hsync_temp2   <= hsync_temp;
                vsync_temp2   <= vsync_temp;
                hblnk_temp2   <= hblnk_temp;
                vblnk_temp2   <= vblnk_temp;
        
                hcount_out  <= hcount_temp2;
                vcount_out  <= vcount_temp2;      
                hsync_out   <= hsync_temp2;
                vsync_out   <= vsync_temp2;
                hblnk_out   <= hblnk_temp2;
                vblnk_out   <= vblnk_temp2;
        
                rgb_out     <= rgb_out_nxt;
    
                rgb_nxt <= rgb_in_nxt;
                rgb_in_nxt  <= rgb_in;
                
                pixel_addr  <= {addry,addrx};
            end
    end
    
    always @*
        begin
            addrx = hcount_in - xpos;
            addry = vcount_in - ypos;
            rgb_out_nxt = rgb_nxt;
            
            if( (hcount_temp2 >= xpos) && (hcount_temp2 < xpos+WIDTH) && (vcount_temp2 >= ypos) && (vcount_temp2 < ypos+HIGH) && !(vblnk_temp2 || hblnk_temp2) )
                begin
                rgb_out_nxt = rgb_pixel;
            end
        end    
endmodule
