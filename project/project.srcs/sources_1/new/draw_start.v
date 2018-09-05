`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2018 22:35:40
// Design Name: 
// Module Name: draw_start
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

module draw_start(
    input wire          pclk,
    input wire          rst,
    input wire [`VGA_BUS_SIZE - 1:0] vga_in,
    input wire [11:0]   mouse_xpos,
    input wire [11:0]   mouse_ypos,
    input wire          mouse_left,    

    output wire [`VGA_BUS_SIZE - 1:0] vga_out,
    output reg          game_en
    );
    
    `VGA_INPUT(vga_in)
    `VGA_OUT_REG
    `VGA_OUTPUT(vga_out)
    
    localparam  X_START     = 195,
                Y_START     = 80,
                WIDTH       = 60,
                X_BTN       = 250,
                Y_BTN       = 400,
                X_BTN_TEXT  = 285,
                Y_BTN_TEXT  = 410,
                BTN_WIDTH   = 300,
                BTN_HEIGHT  = 120,
                TEXT_WIDTH  = 60,
                THICK       = 20,
                NAME_COLOR  = 12'h0_8_8,
                BTN_COLOR   = 12'h8_8_8,
                TEXT_COLOR  = 12'h0_8_8,
                BACK_COLOR  = 12'hc_c_c,
                FRAME_COLOR = 12'h0_f_f;
    
    reg [11:0] rgb_out_nxt;
    reg game_en_nxt;
    
           
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
                    
                rgb_out   <= 0;
                game_en   <= 0;
            end
            else begin
                vcount_out <= vcount_in;
                hcount_out <= hcount_in;
                  
                vsync_out <= vsync_in;
                vblnk_out <= vblnk_in;                
                hsync_out <= hsync_in;
                hblnk_out <= hblnk_in;
                   
                rgb_out <= rgb_out_nxt;
                game_en <= game_en_nxt;
            end
        end
        
    always @*
    begin
        rgb_out_nxt = rgb_in;
        game_en_nxt = game_en;
        // During blanking, make it it black.
        if (vblnk_in || hblnk_in) rgb_out_nxt <= 12'h0_0_0; 
        else
        begin
            // Active display, top edge, make a yellow line.
            if (vcount_in == 0) rgb_out_nxt = FRAME_COLOR;
            // Active display, bottom edge, make a red line.
            else if (vcount_in == 599) rgb_out_nxt = FRAME_COLOR;
            // Active display, left edge, make a green line.
            else if (hcount_in == 0) rgb_out_nxt = FRAME_COLOR;
            // Active display, right edge, make a blue line.
            else if (hcount_in == 799) rgb_out_nxt = FRAME_COLOR;
            // Active display, interior, fill with gray.
            // You will replace this with your own test.
                    
//R             
            else if((hcount_in >= X_START) && (hcount_in <= X_START + 15) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                            
            else if((hcount_in >= X_START + 15) && (hcount_in <= X_START + 50) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 20))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 15) && (hcount_in <= X_START + 50) &&
                    (vcount_in >= Y_START + 55) && (vcount_in <= Y_START + 75))
                        rgb_out_nxt = NAME_COLOR;
                               
            else if((hcount_in >= X_START + 35) && (hcount_in <= X_START + 50) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 75))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 15) && (hcount_in <= X_START + 28) &&
                    (vcount_in >= Y_START + 75) && (vcount_in <= Y_START + 100))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 25) && (hcount_in <= X_START + 38) &&
                    (vcount_in >= Y_START + 100) && (vcount_in <= Y_START + 125))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 35) && (hcount_in <= X_START + 50) &&
                    (vcount_in >= Y_START + 125) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;             
                             
//G             
            else if((hcount_in >= X_START + WIDTH) && (hcount_in <= X_START + WIDTH + 15) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + WIDTH + 15) && (hcount_in <= X_START + WIDTH + 50) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 20))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + WIDTH + 15) && (hcount_in <= X_START + WIDTH + 50) &&
                    (vcount_in >= Y_START + 120) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + WIDTH + 35) && (hcount_in <= X_START + WIDTH + 50) &&
                    (vcount_in >= Y_START + 105) && (vcount_in <= Y_START + 120))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + WIDTH + 25) && (hcount_in <= X_START + WIDTH + 50) &&
                    (vcount_in >= Y_START + 75) && (vcount_in <= Y_START + 105))
                        rgb_out_nxt = NAME_COLOR;                         
                 
//B             
            else if((hcount_in >= X_START + 2*WIDTH) && (hcount_in <= X_START + 2*WIDTH + 10) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 2*WIDTH) && (hcount_in <= X_START + 2*WIDTH + 50) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 20))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 2*WIDTH + 30) && (hcount_in <= X_START + 2*WIDTH + 50) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 2*WIDTH) && (hcount_in <= X_START + 2*WIDTH + 50) &&
                    (vcount_in >= Y_START + 60) && (vcount_in <= Y_START + 90))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 2*WIDTH) && (hcount_in <= X_START + 2*WIDTH + 50) &&
                    (vcount_in >= Y_START + 130) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;            
                 
//A             
            else if((hcount_in >= X_START + 3*WIDTH) && (hcount_in <= X_START + 3*WIDTH + 15) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 3*WIDTH + 35) && (hcount_in <= X_START + 3*WIDTH + 50) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 3*WIDTH) && (hcount_in <= X_START + 3*WIDTH + 50) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 20))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 3*WIDTH) && (hcount_in <= X_START + 3*WIDTH + 50) &&
                    (vcount_in >= Y_START + 60) && (vcount_in <= Y_START + 90))
                        rgb_out_nxt = NAME_COLOR;
                           
//L           
            else if((hcount_in >= X_START + 4*WIDTH) && (hcount_in <= X_START + 4*WIDTH + 15) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 4*WIDTH) && (hcount_in <= X_START + 4*WIDTH + 50) &&
                    (vcount_in >= Y_START + 120) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
                 
//L            
            else if((hcount_in >= X_START + 5*WIDTH) && (hcount_in <= X_START + 5*WIDTH + 15) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
            else if((hcount_in >= X_START + 5*WIDTH) && (hcount_in <= X_START + 5*WIDTH + 50) &&
                    (vcount_in >= Y_START + 120) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                             
//S
            else if((hcount_in >= X_START + 6*WIDTH) && (hcount_in <= X_START + 6*WIDTH + 50) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 20))
                        rgb_out_nxt = NAME_COLOR;
                                         
            else if((hcount_in >= X_START + 6*WIDTH) && (hcount_in <= X_START + 6*WIDTH + 50) &&
                    (vcount_in >= Y_START + 60) && (vcount_in <= Y_START + 90))
                        rgb_out_nxt = NAME_COLOR;
                                        
            else if((hcount_in >= X_START + 6*WIDTH) && (hcount_in <= X_START + 6*WIDTH + 50) &&
                    (vcount_in >= Y_START + 120) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                                         
            else if((hcount_in >= X_START + 6*WIDTH) && (hcount_in <= X_START + 6*WIDTH + 15) &&
                    (vcount_in >= Y_START) && (vcount_in <= Y_START + 75))
                        rgb_out_nxt = NAME_COLOR;
                                        
            else if((hcount_in >= X_START + 6*WIDTH + 35) && (hcount_in <= X_START + 6*WIDTH + 50) &&
                    (vcount_in >= Y_START + 75) && (vcount_in <= Y_START + 150))
                        rgb_out_nxt = NAME_COLOR;
                            
//BTN             
            else if((hcount_in >= X_BTN) && (hcount_in <= X_BTN + BTN_WIDTH) &&
                    (vcount_in >= Y_BTN) && (vcount_in <= Y_BTN + BTN_HEIGHT))
                    begin                            
//NAPIS: P
                        if((hcount_in >= X_BTN_TEXT) && (hcount_in <= X_BTN_TEXT + 15) &&
                           (vcount_in >= Y_BTN_TEXT) && (vcount_in <= Y_BTN_TEXT + 100))
                                rgb_out_nxt = TEXT_COLOR;
    
                        else if((hcount_in >= X_BTN_TEXT + 35) && (hcount_in <= X_BTN_TEXT + 50) &&
                                (vcount_in >= Y_BTN_TEXT) && (vcount_in <= Y_BTN_TEXT + 50))
                                    rgb_out_nxt = TEXT_COLOR;
    
                        else if((hcount_in >= X_BTN_TEXT) && (hcount_in <= X_BTN_TEXT + 50) &&
                                (vcount_in >= Y_BTN_TEXT) && (vcount_in <= Y_BTN_TEXT + 15))  
                                    rgb_out_nxt = TEXT_COLOR;
            
                        else if((hcount_in >= X_BTN_TEXT) && (hcount_in <= X_BTN_TEXT + 50) &&
                                (vcount_in >= Y_BTN_TEXT + 40) && (vcount_in <= Y_BTN_TEXT + 60))
                                    rgb_out_nxt = TEXT_COLOR;
                
//L            
                        else if((hcount_in >= X_BTN_TEXT + TEXT_WIDTH) && (hcount_in <= X_BTN_TEXT + TEXT_WIDTH + 15) &&
                                (vcount_in >= Y_BTN_TEXT) && (vcount_in <= Y_BTN_TEXT + 100))
                                    rgb_out_nxt = TEXT_COLOR;
                
                        else if((hcount_in >= X_BTN_TEXT + TEXT_WIDTH) && (hcount_in <= X_BTN_TEXT + TEXT_WIDTH + 50) &&
                                (vcount_in >= Y_BTN_TEXT + 80) && (vcount_in <= Y_BTN_TEXT + 100))
                                    rgb_out_nxt = TEXT_COLOR;
                    
//A
                        else if((hcount_in >= X_BTN_TEXT + 2*TEXT_WIDTH) && (hcount_in <= X_BTN_TEXT + 2*TEXT_WIDTH + 15) &&
                                (vcount_in >= Y_BTN_TEXT) && (vcount_in <= Y_BTN_TEXT + 100))
                                    rgb_out_nxt = TEXT_COLOR;
                
                        else if((hcount_in >= X_BTN_TEXT + 2*TEXT_WIDTH + 35) && (hcount_in <= X_BTN_TEXT + 2*TEXT_WIDTH + 50) &&
                                (vcount_in >= Y_BTN_TEXT) && (vcount_in <= Y_BTN_TEXT + 100))
                                    rgb_out_nxt = TEXT_COLOR;
                
                        else if((hcount_in >= X_BTN_TEXT + 2*TEXT_WIDTH) && (hcount_in <= X_BTN_TEXT + 2*TEXT_WIDTH + 50) &&
                                (vcount_in >= Y_BTN_TEXT) && (vcount_in <= Y_BTN_TEXT + 15))
                                    rgb_out_nxt = TEXT_COLOR;
                
                        else if((hcount_in >= X_BTN_TEXT + 2*TEXT_WIDTH) && (hcount_in <= X_BTN_TEXT + 2*TEXT_WIDTH + 50) &&
                                (vcount_in >= Y_BTN_TEXT + 40) && (vcount_in <= Y_BTN_TEXT + 70))
                                    rgb_out_nxt = TEXT_COLOR;
                
//Y
                        else if((hcount_in >= X_BTN_TEXT + 3*TEXT_WIDTH) && (hcount_in <= X_BTN_TEXT + 3*TEXT_WIDTH + 15) &&
                                (vcount_in >= Y_BTN_TEXT) && (vcount_in <= Y_BTN_TEXT + 50))
                                    rgb_out_nxt = TEXT_COLOR;
    
                        else if((hcount_in >= X_BTN_TEXT + 3*TEXT_WIDTH + 35) && (hcount_in <= X_BTN_TEXT + 3*TEXT_WIDTH + 50) &&
                                (vcount_in >= Y_BTN_TEXT) && (vcount_in <= Y_BTN_TEXT + 50))
                                    rgb_out_nxt = TEXT_COLOR;
        
                        else if((hcount_in >= X_BTN_TEXT + 3*TEXT_WIDTH) && (hcount_in <= X_BTN_TEXT + 3*TEXT_WIDTH + 50) &&
                                (vcount_in >= Y_BTN_TEXT + 40) && (vcount_in <= Y_BTN_TEXT + 60))
                                    rgb_out_nxt = TEXT_COLOR;
        
                        else if((hcount_in >= X_BTN_TEXT + 3*TEXT_WIDTH + 15) && (hcount_in <= X_BTN_TEXT + 3*TEXT_WIDTH + 35) &&
                                (vcount_in >= Y_BTN_TEXT + 60) && (vcount_in <= Y_BTN_TEXT + 100))
                                    rgb_out_nxt = TEXT_COLOR;
                                         
                        else
                            rgb_out_nxt = BTN_COLOR;
                        
                        if ((mouse_left == 1) &&
                            (mouse_xpos >= X_BTN) &&
                            (mouse_xpos <= X_BTN + BTN_WIDTH) &&
                            (mouse_ypos >= Y_BTN) &&
                            (mouse_ypos <= Y_BTN + BTN_HEIGHT))
                                game_en_nxt = 1'b1;        
                    end            
                 
            else begin
                rgb_out_nxt <= BACK_COLOR;
                game_en_nxt = 1'b0;              
            end
        end
    end
endmodule