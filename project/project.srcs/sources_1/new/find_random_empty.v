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


module find_random_empty(
    input wire clk,
    input wire reset,
    input wire find_en,
    input wire [63:0] color_0_in, color_1_in, color_2_in, color_3_in,
    input wire [20:0] random_number,
    input wire [5:0] random_color,
    output reg [20:0] random_empty,
    output reg [63:0] color_0_out, color_1_out, color_2_out, color_3_out
//    output reg find_end
    );
    
    integer idx;
    reg [1:0] n;
    reg [7:0] counter;
    reg [63:0] ball_reg_temp_1, ball_reg_temp_2, ball_reg_temp_3, ball_reg_in;
    reg [63:0] clr0_temp1, clr0_temp2, clr0_temp3, clr1_temp1, clr1_temp2, clr1_temp3;
    reg [63:0] clr2_temp1, clr2_temp2, clr2_temp3, clr3_temp1, clr3_temp2, clr3_temp3;
    reg [63:0] color_0_nxt, color_1_nxt, color_2_nxt, color_3_nxt;
//    reg find_end_nxt;
    
    always @(posedge clk) begin
        if(reset) begin
            color_0_out <= 64'b0;
            color_1_out <= 64'b0;
            color_2_out <= 64'b0;
            color_3_out <= 64'b0;
//            find_end <= 0;
            //random_empty <=0;
        end
        else begin
//            if(find_en) begin
            color_0_out <= color_0_nxt;
            color_1_out <= color_1_nxt;
            color_2_out <= color_2_nxt;
            color_3_out <= color_3_nxt;
//            find_end <= find_end_nxt;
//            end
//            else begin
//            color_0_out <= color_0_in;
//            color_1_out <= color_1_in;
//            color_2_out <= color_2_in;
//            color_3_out <= color_3_in;  
//            end
        end
    end
    
    
    always @* begin
    if(find_en) begin
        counter = -1;
        /////
        n=0;
        ball_reg_in = color_0_in | color_1_in | color_2_in | color_3_in;
        for(idx=0; idx<=63; idx=idx+1) begin 
            if(!ball_reg_in[idx])begin
                counter = counter +1;
                if((counter == random_number[6:0]) | (counter == random_number[13:7]) | (counter == random_number[20:14])) begin
                    n = n+1;
                    case(n)
                        1: random_empty[6:0]=idx;
                        2: random_empty[13:7]=idx;
                        3: random_empty[20:14]=idx;
                    endcase
                end
            end
        end    
     
        ball_reg_temp_1 = 1'b1 << random_empty[6:0];
        ball_reg_temp_2 = 1'b1 << random_empty[13:7];
        ball_reg_temp_3 = 1'b1 << random_empty[20:14];      
     
//        color_0_nxt = color_0_out;
//        color_1_nxt = color_1_out;
//        color_2_nxt = color_2_out;
//        color_3_nxt = color_3_out;
     
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
          
        color_0_nxt = color_0_in | clr0_temp1 | clr0_temp2 | clr0_temp3;
        color_1_nxt = color_1_in | clr1_temp1 | clr1_temp2 | clr1_temp3;
        color_2_nxt = color_2_in | clr2_temp1 | clr2_temp2 | clr2_temp3;
        color_3_nxt = color_3_in | clr3_temp1 | clr3_temp2 | clr3_temp3;
//        if(( color_3_nxt[0] == 1) || (color_3_nxt[0] == 1)) find_end_nxt = 1;
//        else find_end_nxt = 0;
     //ball_reg_out = ball_reg_in | ball_reg_temp_1 | ball_reg_temp_2 | ball_reg_temp_3;
    
    end
    else begin
        color_0_nxt = color_0_in;
        color_1_nxt = color_1_in;
        color_2_nxt = color_2_in;
        color_3_nxt = color_3_in;  
    end
    end
    
    
endmodule
