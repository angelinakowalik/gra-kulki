`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2018 18:35:29
// Design Name: 
// Module Name: random_places
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


module random_places(
    input wire clk,
    input wire rst,
    input wire find_en,
    input wire [6:0] empty_places,
    output reg [20:0] random_numbers
    );
    
    wire [6:0] random_number_1, random_number_2, random_number_3;
    reg end_places;
    reg [20:0] random_numbers_nxt; 
    
    random 
        #(  .WIDTH(7),
            .DIV(7)
        )
        my_random_1 (
            .clk(clk),
            .rst(rst),
            .divider(empty_places),
            .random_number1(random_number_1),
            .random_number2(random_number_2),
            .random_number3(random_number_3)
        );

 always @(posedge clk)
        begin
            if(rst)
                random_numbers <= 21'b0;
            else begin
                if(find_en) random_numbers <= {random_number_3, random_number_2, random_number_1};       
                else random_numbers <= 21'b0;
            end
        end

        
    
endmodule
