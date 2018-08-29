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


module random_colors(
    input wire clk,
    input wire rst,
    input wire enable,
    
    output reg [5:0] random_numbers
//    output reg find_en
    );
    
        wire [1:0] random_number_1, random_number_2, random_number_3;
    
    
    random_c
        #(  .WIDTH(2),
            .DIV(3)
        )
        my_random_1 (
            .clk(clk),
            .rst(rst),
            .divider(4'd4),
            .random_number1(random_number_1),
            .random_number2(random_number_2),
            .random_number3(random_number_3)
        );
        
        
        always @(posedge clk)
        begin
            if(rst)
            begin
                random_numbers <= 6'b0;
            end
            else begin
                if(enable) begin
                    random_numbers <= {random_number_3, random_number_2, random_number_1};
                end
            end
        end
                
endmodule            