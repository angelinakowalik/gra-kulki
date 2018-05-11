
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2018 13:39:07
// Design Name: 
// Module Name: draw_rect_char
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


module draw_rect_char(
  input wire [10:0] vcount_in,
  input wire        vsync_in,
  input wire        vblnk_in,
  input wire [10:0] hcount_in,
  input wire        hsync_in,
  input wire        hblnk_in,
  input wire [11:0] rgb_in,
  input wire        pclk,
  input wire        rst,
  input wire [7:0]  char_pixel,
    
  output wire [10:0] vcount_out,
  output wire        vsync_out,
  output wire        vblnk_out,
  output wire [10:0] hcount_out,
  output wire        hsync_out,
  output wire        hblnk_out,
  output reg  [11:0] rgb_out,
  output reg  [7:0]  char_xy,
  output reg  [3:0]  char_line
  
);

localparam  TEXTRECT_WIDTH = 16,
            TEXTRECT_HIGH = 16,
            TEXT_COLOR = 12'hf_f_f;

reg [3:0]   pixel_index;
reg [11:0]  rgb_out_nxt = 0, rgb_in_nxt = 0, rgb_nxt = 0;
reg [3:0]   char_line_nxt   = 0;
reg [7:0]   char_xy_nxt     = 0;
reg [10:0]  hcount_temp      = 0;
reg [10:0]  vcount_temp      = 0;
    
    always @* begin
        char_line_nxt   = 0;
        pixel_index     = 0;
        rgb_out_nxt     = rgb_in_nxt; 
        char_xy_nxt     = char_xy;
        hcount_temp      = hcount_in - 300;    
        vcount_temp      = vcount_in - 200;  

        if((hcount_out >= 80) && (hcount_out < 80+8*TEXTRECT_WIDTH) && (vcount_out >= 200) && (vcount_out < 200 + 16*TEXTRECT_HIGH) ) 
            begin
                pixel_index = (hcount_out - 300)% 8;
                if( char_pixel[7-pixel_index] == 1)    rgb_out_nxt = TEXT_COLOR; 
                //else rgb_out_nxt = rgb_nxt;
            end
        
        if((hcount_out >= 80) && (hcount_in < 80 + 8*TEXTRECT_WIDTH) && (vcount_out >= 200) && (vcount_in < 200+16*TEXTRECT_HIGH) )
            begin
                char_line_nxt   = vcount_temp[3:0];
                char_xy_nxt     = {vcount_temp[7:4], hcount_temp[6:3]};
                end
        end

always @(posedge pclk)
    begin
        rgb_in_nxt <= rgb_in;
        //rgb_nxt <= rgb_in_nxt;
        rgb_out <= rgb_out_nxt;
        char_line <= char_line_nxt;
        char_xy <= char_xy_nxt;
    end
    
    
    delay #(
        .WIDTH(26),
        .CLK_DEL(2)
    ) u_delay (
        .clk(pclk),
        .rst(rst),
        .din({hcount_in, hsync_in, hblnk_in, vcount_in, vsync_in, vblnk_in}),
        .dout({hcount_out, hsync_out, hblnk_out, vcount_out, vsync_out, vblnk_out})
    );
        
    
endmodule
/*

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2017 18:05:55
// Design Name: 
// Module Name: draw_rect_char
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


module draw_rect_char
    #(
        parameter   TEXTRECT_XPOS       = 0,
                    TEXTRECT_YPOS       = 0,
                    TEXT_COLOR          = 12'h0_0_0,
                    TRANSPARENT_COLOR   = 1, 
                    BACKGROUND_COLOR    = 12'hf_f_f 
    )
    (
    input wire [10:0]   hcount_in,
    input wire          hsync_in,
    input wire          hblnk_in,
    input wire [10:0]   vcount_in,
    input wire          vsync_in,
    input wire          vblnk_in,
    input wire [11:0]   rgb_in,
    input wire          pclk,
    input wire [7:0]    char_pixel,
    
    output wire [10:0]  hcount_out,
    output wire         hsync_out,
    output wire         hblnk_out,
    output wire [10:0]  vcount_out,
    output wire         vsync_out,
    output wire         vblnk_out,
    output reg [11:0]   rgb_out,
    output reg [7:0]    char_xy,
    output reg [3:0]    char_line
    );

    localparam  TEXTRECT_WIDTH  = 16,       //shouldn't be changed
                TEXTRECT_HIGH   = 16;       //shouldn't be changed
    
    reg [11:0]  rgb_background  = 12'hf_f_f;
    reg [11:0]  rgb_in_nxt      = 0;
    reg [11:0]  rgb_in_nxt1     = 0;
    reg [11:0]  rgb_out_nxt     = 0;
    reg [3:0]   pixel_index     = 0;
    reg [3:0]   char_line_nxt   = 0;
    reg [7:0]   char_xy_nxt     = 0;
    reg [10:0]  hcount_tmp      = 0;
    reg [10:0]  vcount_tmp      = 0;
    
    always @* begin
        char_line_nxt   = 0;
        pixel_index     = 0;
        rgb_background  = (TRANSPARENT_COLOR==1) ? rgb_in_nxt : BACKGROUND_COLOR;
        rgb_out_nxt     = rgb_in_nxt; 
        char_xy_nxt     = char_xy;
        hcount_tmp      = hcount_in - TEXTRECT_XPOS;    
        vcount_tmp      = vcount_in - TEXTRECT_YPOS;
        
        if( (hcount_out >= TEXTRECT_XPOS) && (hcount_out < TEXTRECT_XPOS+8*TEXTRECT_WIDTH) && (vcount_out >= TEXTRECT_YPOS) && (vcount_out < TEXTRECT_YPOS+16*TEXTRECT_HIGH) ) begin
            pixel_index     = (hcount_out-TEXTRECT_XPOS) % 8;
            if( char_pixel[7-pixel_index] == 1)    rgb_out_nxt = TEXT_COLOR; 
            else                                    rgb_out_nxt = rgb_background;
        end 
        
        if( (hcount_in >= TEXTRECT_XPOS) && (hcount_in < TEXTRECT_XPOS+8*TEXTRECT_WIDTH) && (vcount_in >= TEXTRECT_YPOS) && (vcount_in < TEXTRECT_YPOS+16*TEXTRECT_HIGH) ) begin
            char_line_nxt   = vcount_tmp[3:0];
            char_xy_nxt     = {vcount_tmp[7:4], hcount_tmp[6:3]};
        end
                                      
    end
    
    always @(posedge pclk) begin
            rgb_in_nxt1     <= rgb_in;
            rgb_in_nxt      <= rgb_in_nxt1;
            rgb_out         <= rgb_out_nxt;
            char_line       <= char_line_nxt;
            char_xy         <= char_xy_nxt;
    end
    
    delay #(
            .WIDTH (26),
            .CLK_DEL(2)
        ) u_delay1 (
            .clk (pclk),
            .rst (1'b0),
            .din( {hcount_in,  hsync_in,  hblnk_in,  vcount_in,  vsync_in,  vblnk_in}  ),
            .dout({hcount_out, hsync_out, hblnk_out, vcount_out, vsync_out, vblnk_out} )
        );
        
endmodule
*/