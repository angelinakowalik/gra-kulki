// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_example (
  input wire clk,
  input wire rst,
  output reg vs,
  output reg hs,
  output wire [3:0] r,
  output wire [3:0] g,
  output wire [3:0] b,
  inout ps2_clk,
  inout ps2_data
  );

  // Converts 100 MHz clk into 40 MHz pclk.
  // This uses a vendor specific primitive
  // called MMCME2, for frequency synthesis.

/*
  wire clk_in;
  wire locked;
  wire clk_fb;
  wire clk_ss;
  wire clk_out;
  wire pclk;
  (* KEEP = "TRUE" *) 
  (* ASYNC_REG = "TRUE" *)
  reg [7:0] safe_start = 0;


  IBUF clk_ibuf (.I(clk),.O(clk_in));

  MMCME2_BASE #(
    .CLKIN1_PERIOD(10.000),
    .CLKFBOUT_MULT_F(10.000),
    .CLKOUT0_DIVIDE_F(25.000))
  clk_in_mmcme2 (
    .CLKIN1(clk_in),
    .CLKOUT0(clk_out),
    .CLKOUT0B(),
    .CLKOUT1(),
    .CLKOUT1B(),
    .CLKOUT2(),
    .CLKOUT2B(),
    .CLKOUT3(),
    .CLKOUT3B(),
    .CLKOUT4(),
    .CLKOUT5(),
    .CLKOUT6(),
    .CLKFBOUT(clkfb),
    .CLKFBOUTB(),
    .CLKFBIN(clkfb),
    .LOCKED(locked),
    .PWRDWN(1'b0),
    .RST(1'b0)
  );

  BUFH clk_out_bufh (.I(clk_out),.O(clk_ss));
  always @(posedge clk_ss) safe_start<= {safe_start[6:0],locked};

  BUFGCE clk_out_bufgce (.I(clk_out),.CE(safe_start[7]),.O(pclk));
*/
  // Mirrors pclk on a pin for use by the testbench;
  // not functionally required for this design to work.
  
  wire locked;
  wire pclk, mclk;
   
  
  clk_wiz_0 my_clk_wiz (
    .clk(clk),
    .reset(rst),
    .locked(locked),
    .clk100MHz(mclk),
    .clk40MHz(pclk)
  );
/*
  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );
  */

  // Instantiate the vga_timing module, which is
  // the module you are designing for this lab.

  wire [10:0] vcount, hcount, vcount_out_b, hcount_out_b, vcount_out_r, hcount_out_r, vcount_out_c, hcount_out_c;
  wire vsync, hsync, vsync_out_b, hsync_out_b, vsync_out_r, hsync_out_r, vsync_out_c, hsync_out_c;
  wire vblnk, hblnk, vblnk_out_b, hblnk_out_b, vblnk_out_r, hblnk_out_r, vblnk_out_c, hblnk_out_c;
  wire [11:0] rgb_out_b, rgb_out_r, rgb_out_c;
  wire [11:0] xpos, ypos, xpos_d, ypos_d, xpos_r, ypos_r;
  wire [3:0] red_out_m, green_out_m, blue_out_m;
  wire en_m, mouse_left;
  wire [11:0] address;  // address = {addry[5:0], addrx[5:0]}
  wire [11:0] rgb_pixel;
  wire [7:0]  char_pixel;
  wire [7:0] char_xy;
  wire [6:0] char_code;
  wire [3:0] char_line;

  vga_timing my_timing (
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk(pclk)
  );
  
  MouseCtl my_mouse_ctl (
          .clk(mclk),
          .rst(rst),
          .xpos(xpos),
          .ypos(ypos),
          .zpos(),
          .left(mouse_left),
          .middle(),
          .right(),
          .new_event(),
          .value(12'b0),
          .setx(1'b0),
          .sety(1'b0),
          .setmax_x(1'b0),
          .setmax_y(1'b0),
          .ps2_clk(ps2_clk),
          .ps2_data(ps2_data)
      );
      
      my_delay my_delay (
        .pclk(pclk),
        .xpos(xpos),
        .ypos(ypos),
        .xpos_d(xpos_d),
        .ypos_d(ypos_d)
      ); 
      

  // This is a simple test pattern generator.
  
  draw_background my_background (
    
    .vcount_in(vcount),
    .vsync_in(vsync),
    .vblnk_in(vblnk),
    .hcount_in(hcount),
    .hsync_in(hsync),
    .hblnk_in(hblnk),
    .pclk(pclk),
    .rst(rst),
    
    .vcount_out(vcount_out_b),
    .vsync_out(vsync_out_b),
    .vblnk_out(vblnk_out_b),
    .hcount_out(hcount_out_b),
    .hsync_out(hsync_out_b),
    .hblnk_out(hblnk_out_b),
    .rgb_out(rgb_out_b)
  );
  
  image_rom my_image (
    .clk(pclk),
    .address(address),  // address = {addry[5:0], addrx[5:0]}
    .rgb(rgb_pixel)
  );
  
  draw_rect_ctl my_draw_ctl (
    .clk(pclk),
    .rst(rst),
    .mouse_left(mouse_left),
    .mouse_xpos(xpos),
    .mouse_ypos(ypos),      
    .xpos(xpos_r),
    .ypos(ypos_r)
  );
  
  draw_rect my_rect (
    .vcount_in(vcount_out_b),
    .vsync_in(vsync_out_b),
    .vblnk_in(vblnk_out_b),
    .hcount_in(hcount_out_b),
    .hsync_in(hsync_out_b),
    .hblnk_in(hblnk_out_b),
    .rgb_in(rgb_out_b),
    .rgb_pixel(rgb_pixel),
    .xpos(xpos_r),
    .ypos(ypos_r),
    .pclk(pclk),
    .rst(rst),  
    
    .vcount_out(vcount_out_r),
    .vsync_out(vsync_out_r),
    .vblnk_out(vblnk_out_r),
    .hcount_out(hcount_out_r),
    .hsync_out(hsync_out_r),
    .hblnk_out(hblnk_out_r),
    .rgb_out(rgb_out_r),
    .pixel_addr(address)
    );
    
    draw_rect_char my_char (
      .vcount_in(vcount_out_r),
      .vsync_in(vsync_out_r),
      .vblnk_in(vblnk_out_r),
      .hcount_in(hcount_out_r),
      .hsync_in(hsync_out_r),
      .hblnk_in(hblnk_out_r),
      .rgb_in(rgb_out_r),
      .pclk(pclk),
      //.rst(rst),
      .char_pixel(char_pixel),
        
      .vcount_out(vcount_out_c),
      .vsync_out(vsync_out_c),
      .vblnk_out(vblnk_out_c),
      .hcount_out(hcount_out_c),
      .hsync_out(hsync_out_c),
      .hblnk_out(hblnk_out_c),
      .rgb_out(rgb_out_c),
      .char_xy(char_xy),
      .char_line(char_line)
    );
    
    font_rom my_font (
        .clk(pclk),
        .addr({char_code[6:0], char_line[3:0]}),
        .char_line_pixels(char_pixel)
    );
    
    char_rom_16x16 my_char_rom (
        .clk(pclk),
        .char_xy(char_xy),
        .char_code(char_code)
    );
    
    MouseDisplay my_mouse_display (
        .pixel_clk(pclk),
        .xpos(xpos_d),
        .ypos(ypos_d),
        
        .hcount({1'b0,hcount_out_c}),
        .vcount({1'b0,vcount_out_c}),
        .blank(hblnk_out_c || vblnk_out_c),
          
        .red_in(rgb_out_c[11:8]),
        .green_in(rgb_out_c[7:4]),
        .blue_in(rgb_out_c[3:0]),
             
        .enable_mouse_display_out(en_m),
          
        .red_out(red_out_m),
        .green_out(green_out_m),
        .blue_out(blue_out_m)
    );  
  
  always @(posedge pclk)
  begin
    // Just pass these through.
    hs <= hsync_out_r;
    vs <= vsync_out_r;    
  end

    assign r = red_out_m;
    assign g = green_out_m;
    assign b = blue_out_m;
    
endmodule
