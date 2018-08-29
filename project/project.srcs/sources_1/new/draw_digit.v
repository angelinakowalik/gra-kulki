`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 13:31:37
// Design Name: 
// Module Name: draw_digit
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

module draw_digit
    #(parameter
        DIGIT_XPOS      = 100,
        DIGIT_YPOS      = 100,
        DIGIT_THICK     = 10,
        DIGIT_HEIGHT    = 100,
        DIGIT_WIDTH     = 50,
        DIGIT_COLOR     = 12'h0_8_8
    )
    (
    input wire          pclk,
    input wire          rst,
    input wire [3:0]    digit_bcd,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    
    output wire [`VGA_BUS_SIZE - 1:0] vga_out
    );
    
    `VGA_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_OUTPUT(vga_out)
    
    reg [11:0] rgb_out_nxt;
    wire [6:0] digit_sseg;
// ---------------------------------------------------------------

    bcd2sseg my_bcd2sseg (
        .bcd(digit_bcd),
        .sseg(digit_sseg)
    );

// ---------------------------------------------------------------

    always @(posedge pclk) begin
		if(rst) begin
			hcount_out   <= 0;
			hsync_out    <= 0;
			hblnk_out    <= 0;
			vcount_out   <= 0;
			vsync_out    <= 0;
			vblnk_out    <= 0;
			
			rgb_out      <= 0;
		end
		else begin
			hcount_out   <= hcount_in;
			hsync_out    <= hsync_in;
			hblnk_out    <= hblnk_in;
			vcount_out   <= vcount_in;
			vsync_out    <= vsync_in;
			vblnk_out    <= vblnk_in;
			
			rgb_out  <= rgb_out_nxt;
		end
	end
    
    always @*
    begin
        if      ((digit_sseg[0] == 0) &&
                (hcount_in >= DIGIT_XPOS) && (hcount_in <= DIGIT_XPOS + DIGIT_WIDTH) &&
                (vcount_in >= DIGIT_YPOS) && (vcount_in <= DIGIT_YPOS + DIGIT_THICK))                    
                    rgb_out_nxt = DIGIT_COLOR;                        
        else if((digit_sseg[1] == 0) &&
                (hcount_in >= DIGIT_XPOS + DIGIT_WIDTH - DIGIT_THICK) && ( hcount_in <= DIGIT_XPOS + DIGIT_WIDTH) &&
                (vcount_in >= DIGIT_YPOS) && (vcount_in <= DIGIT_YPOS + (DIGIT_HEIGHT/2)))
                    rgb_out_nxt = DIGIT_COLOR;
        else if((digit_sseg[2] == 0) &&
                (hcount_in >= DIGIT_XPOS + DIGIT_WIDTH - DIGIT_THICK) && ( hcount_in <= DIGIT_XPOS + DIGIT_WIDTH) &&
                (vcount_in >= DIGIT_YPOS + (DIGIT_HEIGHT/2)) && (vcount_in <= DIGIT_YPOS + DIGIT_HEIGHT))
                    rgb_out_nxt = DIGIT_COLOR;
        else if((digit_sseg[3] == 0) &&
                (hcount_in >= DIGIT_XPOS) && ( hcount_in <= DIGIT_XPOS + DIGIT_WIDTH) &&
                (vcount_in >= DIGIT_YPOS + DIGIT_HEIGHT - DIGIT_THICK) && (vcount_in <= DIGIT_YPOS + DIGIT_HEIGHT))
                    rgb_out_nxt = DIGIT_COLOR;
        else if((digit_sseg[4] == 0) &&
                (hcount_in >= DIGIT_XPOS) && ( hcount_in <= DIGIT_XPOS + DIGIT_THICK) &&
                (vcount_in >= DIGIT_YPOS + (DIGIT_HEIGHT/2)) && (vcount_in <= DIGIT_YPOS + DIGIT_HEIGHT))
                    rgb_out_nxt = DIGIT_COLOR;
        else if((digit_sseg[5] == 0) &&
                (hcount_in >= DIGIT_XPOS) && ( hcount_in <= DIGIT_XPOS + DIGIT_THICK) &&
                (vcount_in >= DIGIT_YPOS) && (vcount_in <= DIGIT_YPOS + (DIGIT_HEIGHT/2)))
                    rgb_out_nxt = DIGIT_COLOR;
        else if((digit_sseg[6] == 0) &&
                (hcount_in >= DIGIT_XPOS) && ( hcount_in <= DIGIT_XPOS + DIGIT_WIDTH) &&
                (vcount_in >= DIGIT_YPOS + (DIGIT_HEIGHT/2) - DIGIT_THICK) && (vcount_in <= DIGIT_YPOS + (DIGIT_HEIGHT/2)))
                    rgb_out_nxt = DIGIT_COLOR;
        else
            rgb_out_nxt = rgb_in;
    end
endmodule
