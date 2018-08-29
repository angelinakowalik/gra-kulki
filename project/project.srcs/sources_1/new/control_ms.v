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


module control_ms(
    input wire clk,
    input wire reset,
    input wire go,
    
    input wire [63:0] color_0_find, color_0_mv, color_0_dsp,
    input wire [63:0] color_1_find, color_1_mv, color_1_dsp,
    input wire [63:0] color_2_find, color_2_mv, color_2_dsp,
    input wire [63:0] color_3_find, color_3_mv, color_3_dsp,
//    input wire set_ball,
//    input wire [9:0] points_in,
    input wire find_end,
    input wire move_end,
//    input wire set_new,
//    input wire dsp_end,
    
    output reg [63:0] color_0_out,
    output reg [63:0] color_1_out,
    output reg [63:0] color_2_out,
    output reg [63:0] color_3_out,
    
    output reg rnd_col_en, find_en, move_en, disp_en
//    output reg [20:0] random_empty
    
//    output reg [9:0] points_out

    );
    
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
            MOVE_M = 4'b1011;

    
    reg [3:0] state_nxt, state;    
    reg [63:0] color_0_nxt, color_1_nxt, color_2_nxt, color_3_nxt;
    reg [8:0] random_colors_in, random_colors_out, random_colors_nxt;
    reg rnd_col_en_nxt, find_en_nxt, move_en_nxt, disp_en_nxt, rnd_end;
    reg check, check_nxt, move_ch, move_ch_nxt, move_ch_nxt1, move_ch_nxt2, move_ch_nxt3, move_ch_nxt4;
                
    always @(posedge clk) begin
        if(reset)begin
        state <= 0;
        rnd_col_en <= 0;
        find_en <= 0;
        move_en <= 0;
        check <= 0;
        move_ch <= 0;
        
        color_0_out <= 0;
        color_1_out <= 0;
        color_2_out <= 0;
        color_3_out <= 0;  
//        points_out <= 0; 
        end
        
        else begin
        state <= state_nxt;
        color_0_out <= color_0_nxt;
        color_1_out <= color_1_nxt;
        color_2_out <= color_2_nxt;
        color_3_out <= color_3_nxt;        
//        random_colors_in <= random_colors_nxt;
//        points_out <= points_in;
        rnd_col_en <= rnd_col_en_nxt;
        find_en <= find_en_nxt;
        move_en <= move_en_nxt;
        disp_en <= disp_en_nxt;
        
        check <= check_nxt;
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
            RANDOM: state_nxt = find_en ? RANDOM_M : RANDOM;  //find_end ?
            RANDOM_M: state_nxt = find_end ? RANDOM_NXT : RANDOM_M;
            RANDOM_NXT: state_nxt = MOVE;
            
            MOVE: state_nxt = MOVE_NXT;//move_en ? MOVE_NXT : MOVE;
            MOVE_NXT: state_nxt =  move_end ? MOVE_M : MOVE_NXT;
            MOVE_M: state_nxt = move_ch ? DISAPPEAR : MOVE_M;
            
            DISAPPEAR: state_nxt = disp_en ? DISP_NXT : DISAPPEAR;
            DISP_NXT: state_nxt = RANDOM;
            default: state_nxt = IDLE;
        endcase
    end
    
              
    always @* begin
//        color_0_nxt = color_0_out;
//        color_1_nxt = color_1_out;
//        color_2_nxt = color_2_out;
//        color_3_nxt = color_3_out;
//        rnd_col_en_nxt = rnd_col_en;
//        find_en_nxt = find_en;
//        move_en_nxt = move_en;
//        disp_en_nxt = disp_en;
//        check_nxt = check;
        case(state)
            IDLE: begin
//                set_ball = 1'b0;
//                set_new = 1'b0;
                color_0_nxt = 64'h0;
                color_1_nxt = 64'h0;     
                color_2_nxt = 64'h0;
                color_3_nxt = 64'h0; 
                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                check_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
            end
            START: begin
                color_0_nxt = 64'h0;
                color_1_nxt = 64'h0;     
                color_2_nxt = 64'h0;
                color_3_nxt = 64'h0; 
//                random_empty = 64;
                rnd_col_en_nxt = 1'b1;
                move_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                check_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
            end
            RANDOM: begin
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b1;

                color_0_nxt = color_0_out;
                color_1_nxt = color_1_out;
                color_2_nxt = color_2_out;
                color_3_nxt = color_3_out;
                
                move_en_nxt = 1'b0;
                check_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
            end
            RANDOM_M: begin 
                find_en_nxt = 1'b1;
                check_nxt = 1'b0;
                color_0_nxt = color_0_out;
                color_1_nxt = color_1_out;
                color_2_nxt = color_2_out;
                color_3_nxt = color_3_out;
                
                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
                end
            RANDOM_NXT: begin
                color_0_nxt = color_0_find;
                color_1_nxt = color_1_find;  
                color_2_nxt = color_2_find;
                color_3_nxt = color_3_find;    
                check_nxt = 1'b1;   
                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                disp_en_nxt = 1'b0; 
                move_ch_nxt = 1'b0;  
            end
            MOVE: begin
                find_en_nxt = 1'b0;
                move_en_nxt = 1'b1;
                disp_en_nxt = 1'b0;
                move_ch_nxt = 1'b0; 
                color_0_nxt = color_0_out;
                color_1_nxt = color_1_out;
                color_2_nxt = color_2_out;
                color_3_nxt = color_3_out;
                
                rnd_col_en_nxt = 1'b0;
                check_nxt = 1'b0;
            end
            MOVE_NXT: begin
                color_0_nxt = color_0_mv;
                color_1_nxt = color_1_mv;     
                color_2_nxt = color_2_mv;
                color_3_nxt = color_3_mv;      
                
                move_en_nxt = 1'b1;
                move_ch_nxt = 1'b1;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                check_nxt = 1'b0;
                disp_en_nxt = 1'b0;
                
            end
            MOVE_M: begin
                color_0_nxt = color_0_out;
                color_1_nxt = color_1_out;     
                color_2_nxt = color_2_out;
                color_3_nxt = color_3_out; 
                move_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                check_nxt = 1'b0;
                disp_en_nxt = 1'b0;   
                move_ch_nxt = 1'b0;    
            end
            DISAPPEAR: begin
                move_en_nxt = 1'b0;
                disp_en_nxt = 1'b1;
                color_0_nxt = color_0_out;
                color_1_nxt = color_1_out;     
                color_2_nxt = color_2_out;
                color_3_nxt = color_3_out; 
                
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                check_nxt = 1'b0;
                move_ch_nxt = 1'b0;    
            end
            DISP_NXT: begin
                color_0_nxt = color_0_dsp;
                color_1_nxt = color_1_dsp;  
                color_2_nxt = color_2_dsp;
                color_3_nxt = color_3_dsp;  
                disp_en_nxt = 1'b0;
                rnd_col_en_nxt = 1'b0;
                find_en_nxt = 1'b0;
                check_nxt = 1'b0;
                move_ch_nxt = 1'b0;  
                move_en_nxt = 1'b0;  
            end
            //default: state_nxt = IDLE;
        endcase
    end    
    
endmodule 