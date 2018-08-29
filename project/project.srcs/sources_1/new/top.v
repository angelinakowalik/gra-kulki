// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module top (
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

  wire locked;
  wire pclk, mclk, vclk;
  wire game_en, end_en;
  wire start_mode, game_mode, end_mode;
  wire [11:0] xpos, ypos, xpos_d, ypos_d;
  wire mouse_left;
  wire hsync_out, vsync_out;
  wire [3:0] red_out_m, green_out_m, blue_out_m;
  wire [63:0] color_r, color_b, color_g, color_y;
  wire [1:0] transfer_color;
  wire transfer, back, putt;
  wire [3:0] back_column, back_row, putt_column, putt_row;
  wire [5:0] random_color;
  wire [11:0] score;

  /*
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
  */
  
// clock
// ---------------------------------------------------------------
    clk_wiz_0 my_clk_wiz (
        .clk(clk),
        .reset(rst),
        .locked(locked),
        .clk100MHz(mclk),
        .clk40MHz(vclk),
        .clk20MHz(pclk)
    );

// ---------------------------------------------------------------
// instances
// ---------------------------------------------------------------

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
    
// ---------------------------------------------------------------

    menu my_menu (
        .pclk(pclk),
        .rst(rst),
        .game_en(game_en),
        .end_en(end_en),

        .start_mode(start_mode),
        .game_mode(game_mode),
        .end_mode(end_mode)
    );

// ---------------------------------------------------------------
    vga_draw my_vga (        
        .pclk(vclk),
        .rst(rst),
        .start_mode(start_mode),
        .game_mode(game_mode),
        .end_mode(end_mode),
        .xpos(xpos_d),
        .ypos(ypos_d),
        .mouse_left(mouse_left),
        .score(score),
        .random_color(random_color),
        .color_r(color_r),
        .color_b(color_b),
        .color_g(color_g),
        .color_y(color_y),
        .transfer_color(transfer_color),
        .transfer(transfer),
        
        .hsync_out(hsync_out),
        .vsync_out(vsync_out),
        .red_out(red_out_m),
        .green_out(green_out_m),
        .blue_out(blue_out_m),
        .game_en(game_en),
        .end_en(end_en)
    );        

// ---------------------------------------------------------------

    core my_core (
        .clk(pclk),
        .rst(rst),
        .game_mode(game_mode),
        .mouse_xpos(xpos_d),
        .mouse_ypos(ypos_d),
        .mouse_left(mouse_left),
    
        .color_r_out(color_r),
        .color_b_out(color_b),
        .color_g_out(color_g),
        .color_y_out(color_y),    
        .transfer_color(transfer_color),
        .random_colors_out(random_color),
        .score(score),
        .transfer(transfer),
        .end_en(end_en)
    );
 
// ---------------------------------------------------------------

      my_delay my_delay (
        .pclk(vclk),
        .xpos(xpos),
        .ypos(ypos),
        .xpos_d(xpos_d),
        .ypos_d(ypos_d)
      ); 
 
 
  always @(posedge pclk)
  begin
    // Just pass these through.
    hs <= hsync_out;
    vs <= vsync_out;  
  end

    assign r = red_out_m;
    assign g = green_out_m;
    assign b = blue_out_m;
    
endmodule
