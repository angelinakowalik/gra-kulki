`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2018 21:03:38
// Design Name: 
// Module Name: draw_rect_ctl
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


module draw_rect_ctl(
    input wire clk,
    input wire rst,
    input wire mouse_left,
    input wire [11:0] mouse_xpos,
    input wire [11:0] mouse_ypos,
    
    output reg [11:0] xpos,
    output reg [11:0] ypos
    );
    
    reg [11:0] xpos_nxt = 0, ypos_nxt = 0;
    reg [11:0] y_refl = 0, y_refl_nxt = 0;
    reg [11:0] dt, dt_nxt;
    reg on_bottom, on_top, top_refl;
    reg [20:0] clk_div=0, clk_div_nxt=0;
    reg [2:0] state = 0, state_nxt = 0;    
        
    localparam  IDLE        = 3'b000,
                CLICK       = 3'b001,
                FALLING     = 3'b010,
                DOWN        = 3'b011,
                RISING      = 3'b100,
                UP          = 3'b101;
    
    localparam  HEIGHT      = 64,
                FREQ_DIV    = 1_000_000;                
                 
    always @(posedge clk) begin
        if(rst) begin
            xpos <= 0;
            ypos <= 0;
            y_refl <= 0;
            state <= IDLE;
            clk_div <= 0;
            dt <= 0;
        end
        else begin
            xpos <= xpos_nxt;
            ypos <= ypos_nxt;
            y_refl <= y_refl_nxt;
            state <= state_nxt;
            clk_div <= clk_div_nxt;
            dt <= dt_nxt;
        end
    end
    
    always @* begin
        case(state)
            IDLE:       state_nxt = (mouse_left == 1)       ?   CLICK : IDLE;
            CLICK:      state_nxt =                             FALLING;
            FALLING:    state_nxt = (on_bottom == 1)        ?   DOWN : FALLING;
            DOWN:       state_nxt = (y_refl <= 599-HEIGHT)  ?   RISING : IDLE;
            RISING:     state_nxt = (on_top == 1)           ?   UP : RISING;
            UP:         state_nxt = (top_refl == 1)         ?   FALLING : UP;
            default:    state_nxt = IDLE;
        endcase
    end
    
    always @* begin
    
        dt_nxt      = dt;
        clk_div_nxt = clk_div;
        xpos_nxt    = xpos;
        ypos_nxt    = ypos;
        y_refl_nxt  = y_refl; 
        on_bottom   = 0;
        on_top      = 0;
        top_refl    = 0;
       
        case(state)
            IDLE:       begin
                            xpos_nxt = mouse_xpos;
                            ypos_nxt = mouse_ypos;
                            y_refl_nxt = mouse_ypos;
                        end
            CLICK:      begin
                            y_refl_nxt = mouse_ypos;
                            dt_nxt = 0;
                        end
            FALLING:    begin
                            clk_div_nxt = clk_div + 1;
                            if(clk_div == FREQ_DIV) begin
                                ypos_nxt = ypos + dt;
                                dt_nxt = dt + 1;
                                clk_div_nxt = 0;
                            end
                            if( ypos >= 598 - HEIGHT ) begin
                                ypos_nxt = 599 - HEIGHT;
                                on_bottom = 1;
                            end 
                        end
            DOWN:
                        begin
                            y_refl_nxt = y_refl + 2*(600-y_refl)/10;
                            ypos_nxt = 599-HEIGHT;
                        end
            RISING:
                        begin
                            clk_div_nxt = clk_div + 1;
                            if(clk_div == FREQ_DIV) begin
                                ypos_nxt = ypos - dt;
                                dt_nxt = dt - 1;
                                clk_div_nxt = 0;
                            end
                            if(ypos <= y_refl) begin
                            on_top = 1;
                            end
                        end
            UP:
                        begin
                            top_refl = 1;
                        end            
        endcase
    end
    
endmodule
