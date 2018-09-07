`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 11:21:10 PM
// Design Name: 
// Module Name: control_ms
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

`include "_color_macros.vh"

module control_ms(
    input wire clk,
    input wire reset,
    input wire go,
    
    input wire [`COLOR_BUS_SIZE - 1:0] color_find,
    input wire [`COLOR_BUS_SIZE - 1:0] color_mv,
    input wire [`COLOR_BUS_SIZE - 1:0] color_disp,
    input wire find_end,
    input wire move_end,
    input wire end_en,
    input wire [9:0] points_out,
    
    output wire [`COLOR_BUS_SIZE - 1:0] color_out,
    output reg [9:0] points_in,
    output reg rnd_col_en, find_en, move_en, disp_en
    );
    
    `COLOR_OUT_REG
    `COLOR_OUTPUT(color_out)
    
    localparam  IDLE = 4'b0000,
                START = 4'b0001,
                RANDOM = 4'b0010,
                MOVE = 4'b0011,
                DISAPPEAR = 4'b0100,
                END = 4'b0101,
                RANDOM_NXT = 4'b0110,
                MOVE_NXT = 4'b0111,
                DISP_NXT = 4'b1001,
                RANDOM_M = 4'b1010,
                MOVE_M = 4'b1011,
                GAME_END = 4'b1100;

    
    reg [3:0] state_nxt, state;
    reg [63:0] color_r_nxt, color_b_nxt, color_g_nxt, color_y_nxt;
    reg [8:0] random_colors_in, random_colors_out, random_colors_nxt;
    reg rnd_col_en_nxt, find_en_nxt, move_en_nxt, disp_en_nxt, rnd_end;
    reg move_ch, move_ch_nxt, move_ch_nxt1, move_ch_nxt2, move_ch_nxt3, move_ch_nxt4;
    reg rand, rand_next;
    reg [9:0] points_nxt;
                
    always @(posedge clk) begin
        if(reset)begin
            state <= IDLE;
            rnd_col_en <= 0;
            find_en <= 0;
            move_en <= 0;
            move_ch <= 0;
            rand <= 0;
            disp_en <= 0;
        
            color_r_out <= 0;
            color_b_out <= 0;
            color_g_out <= 0;
            color_y_out <= 0;  
            points_in <= 0; 
            
            move_ch_nxt1 <= 0;
            move_ch_nxt2 <= 0;
            move_ch_nxt3 <= 0;
            move_ch_nxt4 <= 0;
        end
        
        else begin
            state <= state_nxt;
            points_in <= points_nxt;
            color_r_out <= color_r_nxt;
            color_b_out <= color_b_nxt;
            color_g_out <= color_g_nxt;
            color_y_out <= color_y_nxt;        
            rnd_col_en <= rnd_col_en_nxt;
            find_en <= find_en_nxt;
            move_en <= move_en_nxt;
            disp_en <= disp_en_nxt;
            rand <= rand_next;
        
            move_ch_nxt1 <= move_ch_nxt;
            move_ch_nxt2 <= move_ch_nxt1;
            move_ch_nxt3 <= move_ch_nxt2;
            move_ch_nxt4 <= move_ch_nxt3;
            move_ch <= move_ch_nxt4;
        end    
    end
    
    
    always @* begin
        case(state)
            IDLE: state_nxt = go ? START : IDLE;
            START: state_nxt = rnd_col_en ? RANDOM : START;
            RANDOM: state_nxt =  end_en ? GAME_END : (find_en ? RANDOM_M : RANDOM);
            RANDOM_M: state_nxt = end_en ? GAME_END : (find_end ? RANDOM_NXT : RANDOM_M);
            RANDOM_NXT: state_nxt = DISAPPEAR;
            
            MOVE: state_nxt = MOVE_NXT;
            MOVE_NXT: state_nxt = move_end ? MOVE_M : MOVE_NXT;
            MOVE_M: state_nxt = move_ch ? DISAPPEAR : MOVE_M;
            
            DISAPPEAR: state_nxt = disp_en ? DISP_NXT : DISAPPEAR;
            DISP_NXT: state_nxt = rand ? MOVE : RANDOM;
            
            GAME_END: state_nxt = IDLE;
            default: state_nxt = IDLE;
        endcase
    end
    
              
    always @* begin
        case(state)
            IDLE: begin
                color_r_nxt = 64'h0;
                color_b_nxt = 64'h0;     
                color_g_nxt = 64'h0;
                color_y_nxt = 64'h0; 
                
                points_nxt = points_out;
                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
                rand_next = 1'b0;
            end
            START: begin
                color_r_nxt = 64'h0;
                color_b_nxt = 64'h0;     
                color_g_nxt = 64'h0;
                color_y_nxt = 64'h0; 
                
                points_nxt = 10'b0;
                rnd_col_en_nxt = 1'b1;
                move_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
                rand_next = 1'b0;
            end
            RANDOM: begin
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b1;

                color_r_nxt = color_r_out;
                color_b_nxt = color_b_out;
                color_g_nxt = color_g_out;
                color_y_nxt = color_y_out;
                
                points_nxt = points_out;
                move_en_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
                rand_next = 1'b0;
            end
            RANDOM_M: begin 
                find_en_nxt = 1'b0;
                color_r_nxt = color_r_out;
                color_b_nxt = color_b_out;
                color_g_nxt = color_g_out;
                color_y_nxt = color_y_out;
                
                points_nxt = points_out;
                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
                rand_next = 1'b0;
                end
            RANDOM_NXT: begin
                color_r_nxt = color_find[63:0];
                color_b_nxt = color_find[127:64];
                color_g_nxt = color_find[191:128];
                color_y_nxt = color_find[255:192];    
                
                points_nxt = points_out; 
                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                disp_en_nxt = 1'b0; 
                move_ch_nxt = 1'b0;  
                rand_next = 1'b1;
            end
            MOVE: begin
                find_en_nxt = 1'b0;
                move_en_nxt = 1'b1;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
                
                points_nxt = points_out;
                color_r_nxt = color_r_out;
                color_b_nxt = color_b_out;
                color_g_nxt = color_g_out;
                color_y_nxt = color_y_out;
                
                rnd_col_en_nxt = 1'b0;
                rand_next = 1'b0;
            end
            MOVE_NXT: begin
                color_r_nxt = color_mv[63:0];
                color_b_nxt = color_mv[127:64];     
                color_g_nxt = color_mv[191:128];
                color_y_nxt = color_mv[255:192];
                
                points_nxt = points_out; 
                move_en_nxt = 1'b1;
                move_ch_nxt = 1'b1;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                rand_next = 1'b0;
            end
            MOVE_M: begin
                color_r_nxt = color_r_out;
                color_b_nxt = color_b_out;     
                color_g_nxt = color_g_out;
                color_y_nxt = color_y_out; 
                
                points_nxt = points_out;
                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                disp_en_nxt = 1'b0;   
                move_ch_nxt = 1'b0;    
                rand_next = 1'b0;
            end
            DISAPPEAR: begin
                move_en_nxt = 1'b0;
                disp_en_nxt = 1'b1;
                color_r_nxt = color_r_out;
                color_b_nxt = color_b_out;     
                color_g_nxt = color_g_out;
                color_y_nxt = color_y_out; 
                
                points_nxt = points_out;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                move_ch_nxt = 1'b0;    
                rand_next = rand;
            end
            DISP_NXT: begin
                color_r_nxt = color_disp[63:0];
                color_b_nxt = color_disp[127:64];  
                color_g_nxt = color_disp[191:128];
                color_y_nxt = color_disp[255:192];
                
                points_nxt = points_out; 
                disp_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                move_ch_nxt = 1'b0;  
                move_en_nxt = 1'b0;  
                rand_next = 1'b0;
            end
            GAME_END: begin 
                color_r_nxt = 0;
                color_b_nxt = 0;     
                color_g_nxt = 0;
                color_y_nxt = 0; 

                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                disp_en_nxt = 1'b0; 
                move_ch_nxt = 1'b0;  
                rand_next = 1'b0;
                points_nxt = points_out;
            end        
            default: begin
                color_r_nxt = 64'h0;
                color_b_nxt = 64'h0;     
                color_g_nxt = 64'h0;
                color_y_nxt = 64'h0; 
                
                points_nxt = 1'b0;
                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
                rand_next = 1'b0;
            end            
        endcase
    end    
    
endmodule 