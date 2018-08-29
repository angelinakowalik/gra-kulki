`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2018 07:20:08 PM
// Design Name: 
// Module Name: random
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


module random_c #(parameter WIDTH = 2, DIV = 2) (
    input wire clk,
    input wire rst,
//    input wire enable,
    input wire [(DIV - 1):0] divider,
    output wire [(WIDTH - 1):0] random_number1,
    output wire [(WIDTH - 1):0] random_number2,
    output wire [(WIDTH - 1):0] random_number3
    
//    output reg done
    );
    
//    reg [(WIDTH - 1) : 0] random_number_nxt, random_number_temp;
    
    reg [6:0] random, random_next, random_done;
    reg [3:0] count, count_next; //to keep track of the shifts
    
    wire feedback = random[6] ^ random[3] ^ random[2] ^ random[0]; 
     
    always @ (posedge clk)
    begin
         if (rst)
         begin
//         done <= 0;
          random <= 7'hF; //An LFSR cannot have an all 0 state, thus reset to FF
          count <= 0;
         end
          
         else
         begin
          random <= random_next;
          count <= count_next;
         end
    end
     
    always @ (*)
//    if(enable) begin
    begin
     random_next = random; //default state stays the same
     count_next = count;
       
      random_next = {random[5:0], feedback}; //shift left the xor'd every posedge clock
      count_next = count + 1;
     
     if (count >= 7)
     begin
      count_next = 0;
      random_done = random; //assign the random number to output after 13 shifts
//      done = 1'b1;
//     end
      end
    end
          
    assign random_number1 = random_done % divider;
    assign random_number2 = {random_done[3:1],feedback,random_done[6:4]} % divider;
    assign random_number3 = {feedback, random_done[1:0], random_done[4:1]} % divider;
     
    endmodule
    