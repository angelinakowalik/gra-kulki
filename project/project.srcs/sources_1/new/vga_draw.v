`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2018 14:23:50
// Design Name: 
// Module Name: vga_draw
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

module vga_draw (
	input wire pclk,
    input wire rst,
    input wire [11:0] xpos,
    input wire [11:0] ypos,
    input wire mouse_left,
    input wire start_mode,
    input wire game_mode,
    input wire end_mode,
    input wire [5:0] random_color,
    input wire [11:0] score,
    input wire [63:0] color_r,
    input wire [63:0] color_b,
    input wire [63:0] color_g,
    input wire [63:0] color_y,
    input wire [1:0] transfer_color,
    input wire transfer,
	
    output wire hsync_out,
    output wire vsync_out,
    output wire [3:0] red_out,
    output wire [3:0] green_out,
    output wire [3:0] blue_out,
    output wire game_en,
    output wire end_en	
	);
	
	wire [10:0] vcount, hcount, vcount_out_b, hcount_out_b,vcount_out_ball, hcount_out_ball, hcount_out_ctl, vcount_out_ctl;
	wire vsync, hsync, vsync_out_b, hsync_out_b, hsync_out_ball, vsync_out_ball;
	wire vblnk, hblnk, vblnk_out_b, hblnk_out_b, vblnk_out_ball, hblnk_out_ball, hblnk_out_ctl, vblnk_out_ctl;
	wire [11:0] rgb_out_b, rgb_out_ball, rgb_out_ctl;
	wire [11:0] address, address_2;
	wire [11:0] rgb_pixel_b, rgb_pixel_g, rgb_pixel_2;
	wire en_m;
	wire [2:0] color_from_reg;
	
	wire [`VGA_BUS_SIZE - 1:0] vga_timing, vga_start, vga_game, vga_end, vga_mux;
	
// ---------------------------------------------------------------	
	vga_timing my_timing (
		.pclk(pclk),
		.rst(rst),
		.vga_out(vga_timing)	
//		.vcount(vcount),
//		.vsync(vsync),
//		.vblnk(vblnk),
//		.hcount(hcount),
//		.hsync(hsync),
//		.hblnk(hblnk)
	);
		
// ---------------------------------------------------------------

    draw_start my_start (
        .pclk(pclk),
        .rst(rst),
        .vga_in(vga_timing),
        .mouse_xpos(xpos),
        .mouse_ypos(ypos),
        .mouse_left(mouse_left),
        .vga_out(vga_start),
        .game_en(game_en)
    );
// ---------------------------------------------------------------

    draw_game my_game (
        .pclk(pclk),
        .rst(rst),
        .transfer(transfer),
        .transfer_color(transfer_color),
        .xpos(xpos),
        .ypos(ypos),
        .score(score),
        .random_color(random_color),
        .color_r(color_r),
        .color_b(color_b),
        .color_g(color_g),
        .color_y(color_y),
        .vga_in(vga_timing),
        
        .vga_out(vga_game)
    );	

// ---------------------------------------------------------------

    vga_mux my_mux (
        .vga_start(vga_start),
        .vga_game(vga_game),
        .vga_end(vga_end),
        .start_mode(start_mode),
        .game_mode(game_mode),
        .end_mode(end_mode),
          
        .vga_out(vga_mux)
    );

// ---------------------------------------------------------------

	MouseDisplay my_mouse_display (
        .pixel_clk(pclk),
        .xpos(xpos),
        .ypos(ypos),
        
        .hcount({1'b0,vga_mux[10:0]}),
        .vcount({1'b0,vga_mux[21:11]}),
        .blank(vga_mux[34] || vga_mux[35]),
          
        .red_in(vga_mux[33:30]),
        .green_in(vga_mux[29:26]),
        .blue_in(vga_mux[25:22]),
             
        .enable_mouse_display_out(en_m),
          
        .red_out(red_out),
        .green_out(green_out),
        .blue_out(blue_out)
    );
	
	assign hsync_out = vga_mux[36];
	assign vsync_out = vga_mux[37];
	/*
        assign red_out_m = rgb_out_b[11:8];
        assign green_out_m = rgb_out_b[7:4];
        assign blue_out_m = rgb_out_b[3:0];
        */
endmodule