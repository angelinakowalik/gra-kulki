`ifndef _vga_macros
`define _vga_macros

//bus sizes
`define VGA_BUS_SIZE 38
`define VGA_RGB_SIZE 12
`define VGA_VCOUNT_SIZE 11
`define VGA_HCOUNT_SIZE 11

//VGA bus components
`define VGA_VSYNC_BITS 37
`define VGA_HSYNC_BITS 36
`define VGA_VBLNK_BITS 35
`define VGA_HBLNK_BITS 34
`define VGA_RGB_BITS 33:22
`define VGA_VCOUNT_BITS 21:11
`define VGA_HCOUNT_BITS 10:0

//vga bus split at input port
`define VGA_INPUT(BUS_NAME) \
    wire vsync_in = BUS_NAME[`VGA_VSYNC_BITS]; \
    wire hsync_in = BUS_NAME[`VGA_HSYNC_BITS]; \
    wire vblnk_in = BUS_NAME[`VGA_VBLNK_BITS]; \
    wire hblnk_in = BUS_NAME[`VGA_HBLNK_BITS]; \
    wire [`VGA_RGB_SIZE - 1 :0] rgb_in = BUS_NAME[`VGA_RGB_BITS]; \
    wire [`VGA_VCOUNT_SIZE - 1 :0] vcount_in = BUS_NAME[`VGA_VCOUNT_BITS]; \
    wire [`VGA_HCOUNT_SIZE - 1 :0] hcount_in = BUS_NAME[`VGA_HCOUNT_BITS]; 
    
// vga bus output variables
`define VGA_OUT_WIRE \
    wire vsync_out; \
    wire hsync_out; \
    wire vblnk_out; \
    wire hblnk_out; \
    wire [`VGA_RGB_SIZE - 1 : 0] rgb_out; \
    wire [`VGA_VCOUNT_SIZE - 1 : 0] vcount_out; \
    wire [`VGA_HCOUNT_SIZE - 1 : 0] hcount_out; 
    
`define VGA_OUT_REG \
    reg vsync_out; \
    reg hsync_out; \
    reg vblnk_out; \
    reg hblnk_out; \
    reg [`VGA_RGB_SIZE - 1 : 0] rgb_out; \
    reg [`VGA_VCOUNT_SIZE - 1 : 0] vcount_out; \
    reg [`VGA_HCOUNT_SIZE - 1 : 0] hcount_out;
  
// vga bus merge at the output
`define VGA_OUTPUT(BUS_NAME) \
    assign BUS_NAME[`VGA_VSYNC_BITS] = vsync_out; \
    assign BUS_NAME[`VGA_HSYNC_BITS] = hsync_out; \
    assign BUS_NAME[`VGA_VBLNK_BITS] = vblnk_out; \
    assign BUS_NAME[`VGA_HBLNK_BITS] = hblnk_out; \
    assign BUS_NAME[`VGA_RGB_BITS] = rgb_out; \
    assign BUS_NAME[`VGA_VCOUNT_BITS] = vcount_out; \
    assign BUS_NAME[`VGA_HCOUNT_BITS] = hcount_out; 
 
`endif
    