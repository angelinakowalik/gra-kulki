`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2018 05:20:29 PM
// Design Name: 
// Module Name: num_to_dig
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


module num_to_dig(
    input wire [9:0] number,
    output wire [11:0] digits
    );
    
    integer n;
    reg [9:0] num_reg;
    reg [3:0] units, tens, hundreds;

    always @(number) begin
        //digits = 12'b0;
        num_reg = number;
        units = 'b0;
        tens = 'b0;
        hundreds = 'b0;        

        units = num_reg%'d10;
        num_reg = num_reg - units;
        num_reg = num_reg/'d10;
        
        tens = num_reg%'d10;
        num_reg = num_reg - tens;
        num_reg = num_reg/'d10;
        
        hundreds = num_reg%'d10;       
    end
    
    assign digits[3:0] = units;
    assign digits[7:4] = tens;
    assign digits[11:8] = hundreds;
    
endmodule
