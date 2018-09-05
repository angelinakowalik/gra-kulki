// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

`include "_color_macros.vh"

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
  wire [3:0] red_out, green_out, blue_out;
  wire [63:0] color_r, color_b, color_g, color_y;
  wire [1:0] transfer_color;
  wire transfer;
  wire [5:0] random_color;
  wire [11:0] score;
  wire [`COLOR_BUS_SIZE - 1 : 0] color_reg;

  
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
        .mouse_left(mouse_left),

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
        .color_reg(color_reg),
        .transfer_color(transfer_color),
        .transfer(transfer),
        
        .hsync_out(hsync_out),
        .vsync_out(vsync_out),
        .red_out(red_out),
        .green_out(green_out),
        .blue_out(blue_out),
        .game_en(game_en)
    );        

// ---------------------------------------------------------------

    core my_core (
        .clk(pclk),
        .rst(rst),
        .game_mode(game_mode),
        .mouse_xpos(xpos_d),
        .mouse_ypos(ypos_d),
        .mouse_left(mouse_left),
    
        .color_reg(color_reg),    
        .transfer_color(transfer_color),
        .random_colors_out(random_color),
        .score(score),
        .transfer(transfer),
        .end_en(end_en)
    );
 
// ---------------------------------------------------------------

      my_delay my_delay (
        .pclk(pclk),
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

    assign r = red_out;
    assign g = green_out;
    assign b = blue_out;
    
endmodule
