`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 09:26:42
// Design Name: 
// Module Name: move_ball
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


module move_ball(
    input wire  pclk,
    input wire  rst,
    input wire button,
    input wire transfer,
    input wire [11:0] mouse_xpos,
    input wire [11:0] mouse_ypos,
    input wire [3:0] column_in,
    input wire [3:0] row_in,
        
    output reg [11:0] x_out,
    output reg [11:0] y_out    
    );
    
    localparam	IDLE     	= 2'b00,
                MOVE_COL    = 2'b01,
                MOVE_RO     = 2'b10,
                END         = 2'b11;
                
    localparam  STATE_SIZE  = 2,
                FREQ_DIV    = 100_000,
                UP          = 32,
                LEFT        = 256,
                SQUARE_SIZE = 64,
                BALL_SIZE   = 50,
                START_DRAW  = (SQUARE_SIZE/2) - (BALL_SIZE/2);
                
    reg [11:0] x_out_nxt = 0, y_out_nxt = 0;
    reg [11:0] x_limit, y_limit;
    reg [STATE_SIZE : 0] state, state_nxt;
    reg [20:0] clk_div = 0, clk_div_nxt = 0;
    reg column, row;
    
    always @(posedge pclk) begin
        if(rst) begin
            x_out <= 0;
            y_out <= 0;
            state <= IDLE;
            clk_div <= 0;
        end
        else begin
            x_out <= x_out_nxt;
            y_out <= y_out_nxt;
            state <= state_nxt;
            clk_div <= clk_div_nxt;
        end
    end
        
    always @*
    begin
        case(state)
            IDLE:       state_nxt = (button == 1)   ?   MOVE_COL  : IDLE;
            MOVE_COL:   state_nxt = (column == 1)   ?   MOVE_RO   : MOVE_COL;                         
            MOVE_RO:    state_nxt = (row == 1)      ?   END       : MOVE_RO;
            END:        state_nxt = (transfer == 1) ?   IDLE      : END;
            default:    state_nxt =                     IDLE;
        endcase
    end    
        
    always @*
    begin
        clk_div_nxt = clk_div;
        x_out_nxt  = x_out;
        y_out_nxt  = y_out;
        column      = 0;
        row         = 0;
        x_limit     = LEFT + (column_in - 1)*SQUARE_SIZE + START_DRAW;
        y_limit     = UP + (row_in - 1)*SQUARE_SIZE + START_DRAW;       
            
        case(state)
            IDLE:       begin
                            x_out_nxt = mouse_xpos;
                            y_out_nxt = mouse_ypos;
                        end
            MOVE_COL:   begin                                      
                            clk_div_nxt = clk_div + 1;
                            if(x_out > x_limit)
                            begin
                                if(clk_div == FREQ_DIV)
                                begin
                                    x_out_nxt = x_out - 1;
                                    clk_div_nxt = 0;
                                end
                            end
                            else if(x_out < x_limit)
                            begin
                                if(clk_div == FREQ_DIV)
                                begin                
                                    x_out_nxt = x_out + 1;
                                    clk_div_nxt = 0;
                                end
                            end
                            else begin
                                    column = 1;
                                    x_out_nxt = x_limit;
                            end
                        end
            MOVE_RO:    begin             
                            clk_div_nxt = clk_div + 1;
                            if(y_out > y_limit)
                            begin
                                if(clk_div == FREQ_DIV)
                                begin
                                    y_out_nxt = y_out - 1;
                                    clk_div_nxt = 0;
                                end
                            end
                            else if(y_out < y_limit)
                            begin
                                if(clk_div == FREQ_DIV)
                                begin                
                                    y_out_nxt = y_out + 1;
                                    clk_div_nxt = 0;
                                end
                            end
                            else begin
                                row = 1;
                                y_out_nxt = x_limit;
                            end
                        end
                                
            END:    begin
                        x_out_nxt = x_limit;
                        y_out_nxt = y_limit;
                    end
        endcase
    end
endmodule
