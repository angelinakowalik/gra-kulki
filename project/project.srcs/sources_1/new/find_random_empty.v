`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2018 08:37:52 PM
// Design Name: 
// Module Name: find_random_empty
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

module find_random_empty(
    input wire clk,
    input wire reset,
    input wire find_en,
    input wire [`COLOR_BUS_SIZE - 1:0] color_in,
    input wire [20:0] random_number,
    input wire [5:0] random_color,
    output wire [`COLOR_BUS_SIZE - 1:0] color_out
    );
    
    `COLOR_INPUT(color_in)
    `COLOR_OUT_REG
    `COLOR_OUTPUT(color_out)
    
    integer idx;
    reg [1:0] n;
    reg [7:0] counter;
    reg [63:0] ball_reg_temp_1, ball_reg_temp_2, ball_reg_temp_3, ball_reg_in;
    reg [63:0] clr0_temp1, clr0_temp2, clr0_temp3, clr1_temp1, clr1_temp2, clr1_temp3;
    reg [63:0] clr2_temp1, clr2_temp2, clr2_temp3, clr3_temp1, clr3_temp2, clr3_temp3;
    reg [63:0] color_r_nxt, color_b_nxt, color_g_nxt, color_y_nxt;
    reg [20:0] random_empty;//, random_empty_nxt;
   
    always @(posedge clk) begin
        if(reset) begin
            color_r_out <= 64'b0;
            color_b_out <= 64'b0;
            color_g_out <= 64'b0;
            color_y_out <= 64'b0;
//            random_empty <= 0;
        end
        else begin
            color_r_out <= color_r_nxt;
            color_b_out <= color_b_nxt;
            color_g_out <= color_g_nxt;
            color_y_out <= color_y_nxt;
//            random_empty <= random_empty_nxt;
        end
    end
    
    
    always @* begin
    if(find_en) begin
        counter = -1;
        n=0;
        ball_reg_in = color_r_in | color_b_in | color_g_in | color_y_in;
        for(idx=0; idx<=63; idx=idx+1) begin 
            if(!ball_reg_in[idx])begin
                counter = counter +1;
                if((counter == random_number[6:0]) | (counter == random_number[13:7]) | (counter == random_number[20:14])) begin
                    n = n+1;
                    case(n)
                        1: begin random_empty[6:0] = idx;
//                                 random_empty_nxt[13:7] = 0;
//                                 random_empty_nxt[20:14] = 0;
                           end
                        2: begin 
//                                random_empty_nxt[6:0] = random_empty[6:0];
                                random_empty[13:7] = idx;
//                                random_empty_nxt[20:14] = random_empty[20:14];
                           end
                        3: begin
//                                random_empty_nxt[6:0] = random_empty[6:0];
//                                random_empty_nxt[13:7] = random_empty[13:7];
                                random_empty[20:14] = idx;
                           end
//                        default: begin
//                                random_empty_nxt[6:0] = random_empty[6:0];
//                                random_empty_nxt[13:7] = random_empty[13:7];
//                                random_empty_nxt[20:14] = random_empty[20:14];
//                        end
                    endcase
                end
//                else begin
//                    random_empty_nxt[6:0] = random_empty[6:0];
//                    random_empty_nxt[13:7] = random_empty[13:7];
//                    random_empty_nxt[20:14] = random_empty[20:14];
//                end
            end
//                else begin
//                random_empty_nxt[6:0] = random_empty[6:0];
//                random_empty_nxt[13:7] = random_empty[13:7];
//                random_empty_nxt[20:14] = random_empty[20:14];
//            end
        end    
     
        ball_reg_temp_1 = 1'b1 << random_empty[6:0];
        ball_reg_temp_2 = 1'b1 << random_empty[13:7];
        ball_reg_temp_3 = 1'b1 << random_empty[20:14];      
     
         case(random_color[1:0]) 
             2'b00: begin 
                clr0_temp1 = ball_reg_temp_1;
                clr1_temp1 = 63'b0;
                clr2_temp1 = 63'b0;
                clr3_temp1 = 63'b0;
            end
            2'b01: begin
                clr1_temp1 = ball_reg_temp_1;  
                clr0_temp1 = 63'b0;
                clr2_temp1 = 63'b0;
                clr3_temp1 = 63'b0;
            end 
            2'b10: begin 
                clr0_temp1 = 63'b0;
                clr1_temp1 = 63'b0;
                clr2_temp1 = ball_reg_temp_1;
                clr3_temp1 = 63'b0;
            end
            2'b11: begin
                clr1_temp1 = 63'b0;  
                clr0_temp1 = 63'b0;
                clr2_temp1 = 63'b0;
                clr3_temp1 = ball_reg_temp_1;
            end 
        endcase
     
        case(random_color[3:2]) 
            2'b00: begin 
                clr0_temp2 = ball_reg_temp_2;
                clr1_temp2 = 63'b0;
                clr2_temp2 = 63'b0;
                clr3_temp2 = 63'b0;
            end
            2'b01: begin
                clr1_temp2 = ball_reg_temp_2;  
                clr0_temp2 = 63'b0;
                clr2_temp2 = 63'b0;
                clr3_temp2 = 63'b0;
            end 
            2'b10: begin 
                clr0_temp2 = 63'b0;
                clr1_temp2 = 63'b0;
                clr2_temp2 = ball_reg_temp_2;
                clr3_temp2 = 63'b0;
            end
            2'b11: begin
                clr1_temp2 = 63'b0;  
                clr0_temp2 = 63'b0;
                clr2_temp2 = 63'b0;
                clr3_temp2 = ball_reg_temp_2;
            end   
        endcase
        
        case(random_color[5:4]) 
            2'b00: begin 
                clr0_temp3 = ball_reg_temp_3;
                clr1_temp3 = 63'b0;
                clr2_temp3 = 63'b0;
                clr3_temp3 = 63'b0;
            end
            2'b01: begin
                clr1_temp3 = ball_reg_temp_3;  
                clr0_temp3 = 63'b0;
                clr2_temp3 = 63'b0;
                clr3_temp3 = 63'b0;
            end 
            2'b10: begin 
                clr0_temp3 = 63'b0;
                clr1_temp3 = 63'b0;
                clr2_temp3 = ball_reg_temp_3;
                clr3_temp3 = 63'b0;
            end
            2'b11: begin
                clr1_temp3 = 63'b0;  
                clr0_temp3 = 63'b0;
                clr2_temp3 = 63'b0;
                clr3_temp3 = ball_reg_temp_3;
            end   
        endcase
          
        color_r_nxt = color_r_in | clr0_temp1 | clr0_temp2 | clr0_temp3;
        color_b_nxt = color_b_in | clr1_temp1 | clr1_temp2 | clr1_temp3;
        color_g_nxt = color_g_in | clr2_temp1 | clr2_temp2 | clr2_temp3;
        color_y_nxt = color_y_in | clr3_temp1 | clr3_temp2 | clr3_temp3;
    
    end
    else begin
        color_r_nxt = color_r_in;
        color_b_nxt = color_b_in;
        color_g_nxt = color_g_in;
        color_y_nxt = color_y_in;  
    end
    end
    
    
endmodule
