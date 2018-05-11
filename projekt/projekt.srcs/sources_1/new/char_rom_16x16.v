`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2018 17:57:27
// Design Name: 
// Module Name: char_rom_16x16
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


module char_rom_16x16(
    input   wire clk,
    input   wire [7:0] char_xy,
    output  wire [6:0] char_code
    );
    
    reg [7:0] code_data;
    
    assign char_code = code_data[6:0];
    
    always @*
        begin
            case (char_xy)
                //GROUP 1                   //      hex
                    8'h00: code_data = 8'h54;   // T    54
                    8'h01: code_data = 8'h6f;   // o    6f
                    8'h02: code_data = 8'h00;   //      00
                    8'h03: code_data = 8'h6a;   // j    6a
                    8'h04: code_data = 8'h65;   // e    65
                    8'h05: code_data = 8'h73;   // s    73 
                    8'h06: code_data = 8'h74;   // t    74 
                    8'h07: code_data = 8'h00;   //      00
                    8'h08: code_data = 8'h50;   // P    50
                    8'h09: code_data = 8'h49;   // I    49   
                    8'h0a: code_data = 8'h45;   // E    45
                    8'h0b: code_data = 8'h52;   // R    52
                    8'h0c: code_data = 8'h57;   // W    57
                    8'h0d: code_data = 8'h53;   // S    53
                    8'h0e: code_data = 8'h5a;   // Z    5a
                    8'h0f: code_data = 8'h41;   // A    41
                        
                    //GROUP 2                   //      hex
                    8'h10: code_data = 8'h6c;   // l    6c
                    8'h11: code_data = 8'h69;   // i    69
                    8'h12: code_data = 8'h6e;   // n    6e
                    8'h13: code_data = 8'h69;   // i    69
                    8'h14: code_data = 8'h61;   // a    61
                    8'h15: code_data = 8'h2e;   // .    2e
                    8'h16: code_data = 8'h00;   //      00
                    8'h17: code_data = 8'h4e;   // N    4e
                    8'h18: code_data = 8'h61;   // a    61
                    8'h19: code_data = 8'h73;   // s    73
                    8'h1a: code_data = 8'h74;   // t    74
                    8'h1b: code_data = 8'h65;   // e    65
                    8'h1c: code_data = 8'h70;   // p    70
                    8'h1d: code_data = 8'h6e;   // n    6e    
                    8'h1e: code_data = 8'h65;   // e    65
                    8'h1f: code_data = 8'h3a;   // :    3a
                       
                    //GROUP 3                   //      hex
                    8'h20: code_data = 8'h2e;   // .    2e
                    8'h21: code_data = 8'h2e;   // .    2e
                    8'h22: code_data = 8'h2e;   // .    2e
                    8'h23: code_data = 8'h00;   //      00
                    8'h24: code_data = 8'h6b;   // k    6b
                    8'h25: code_data = 8'h6f;   // o    6f
                    8'h26: code_data = 8'h6c;   // l    6c
                    8'h27: code_data = 8'h65;   // e    65
                    8'h28: code_data = 8'h6a;   // j    6a
                    8'h29: code_data = 8'h6e;   // n    6e
                    8'h2a: code_data = 8'h61;   // a    61
                    8'h2b: code_data = 8'h2e;   // .    2e
                    8'h2c: code_data = 8'h2e;   // .    2e
                    8'h2d: code_data = 8'h2e;   // .    2e
                    8'h2e: code_data = 8'h00;   //      00
                    8'h2f: code_data = 8'h00;   //      00
                        
                    //GROUP 4                   //      hex
                    8'h30: code_data = 8'h2e;   // .    2e
                    8'h31: code_data = 8'h2e;   // .    2e
                    8'h32: code_data = 8'h2e;   // .    2e
                    8'h33: code_data = 8'h00;   //      00
                    8'h34: code_data = 8'h6b;   // k    6b
                    8'h35: code_data = 8'h6f;   // o    6f
                    8'h36: code_data = 8'h6c;   // l    6c
                    8'h37: code_data = 8'h65;   // e    65
                    8'h38: code_data = 8'h6a;   // j    6a
                    8'h39: code_data = 8'h6e;   // n    6e
                    8'h3a: code_data = 8'h61;   // a    61
                    8'h3b: code_data = 8'h2e;   // .    2e
                    8'h3c: code_data = 8'h2e;   // .    2e
                    8'h3d: code_data = 8'h2e;   // .    2e
                    8'h3e: code_data = 8'h00;   //      00
                    8'h3f: code_data = 8'h00;   //      00
                         
                    //GROUP 5                   //      hex
                    8'h40: code_data = 8'h2e;   // .    2e
                    8'h41: code_data = 8'h2e;   // .    2e
                    8'h42: code_data = 8'h2e;   // .    2e
                    8'h43: code_data = 8'h00;   //      00
                    8'h44: code_data = 8'h6b;   // k    6b
                    8'h45: code_data = 8'h6f;   // o    6f
                    8'h46: code_data = 8'h6c;   // l    6c
                    8'h47: code_data = 8'h65;   // e    65
                    8'h48: code_data = 8'h6a;   // j    6a
                    8'h49: code_data = 8'h6e;   // n    6e
                    8'h4a: code_data = 8'h61;   // a    61
                    8'h4b: code_data = 8'h2e;   // .    2e
                    8'h4c: code_data = 8'h2e;   // .    2e
                    8'h4d: code_data = 8'h2e;   // .    2e
                    8'h4e: code_data = 8'h00;   //      00
                    8'h4f: code_data = 8'h00;   //      00
                       
                    //GROUP 6                   //      hex
                    8'h50: code_data = 8'h2e;   // .    2e
                    8'h51: code_data = 8'h2e;   // .    2e
                    8'h52: code_data = 8'h2e;   // .    2e
                    8'h53: code_data = 8'h00;   //      00
                    8'h54: code_data = 8'h6b;   // k    6b
                    8'h55: code_data = 8'h6f;   // o    6f
                    8'h56: code_data = 8'h6c;   // l    6c
                    8'h57: code_data = 8'h65;   // e    65
                    8'h58: code_data = 8'h6a;   // j    6a
                    8'h59: code_data = 8'h6e;   // n    6e
                    8'h5a: code_data = 8'h61;   // a    61
                    8'h5b: code_data = 8'h2e;   // .    2e
                    8'h5c: code_data = 8'h2e;   // .    2e
                    8'h5d: code_data = 8'h2e;   // .    2e
                    8'h5e: code_data = 8'h00;   //      00
                    8'h5f: code_data = 8'h00;   //      00
                         
                    //GROUP 7                   //      hex
                    8'h60: code_data = 8'h2e;   // .    2e
                    8'h61: code_data = 8'h2e;   // .    2e
                    8'h62: code_data = 8'h2e;   // .    2e
                    8'h63: code_data = 8'h00;   //      00
                    8'h64: code_data = 8'h6b;   // k    6b
                    8'h65: code_data = 8'h6f;   // o    6f
                    8'h66: code_data = 8'h6c;   // l    6c
                    8'h67: code_data = 8'h65;   // e    65
                    8'h68: code_data = 8'h6a;   // j    6a
                    8'h69: code_data = 8'h6e;   // n    6e
                    8'h6a: code_data = 8'h61;   // a    61
                    8'h6b: code_data = 8'h2e;   // .    2e
                    8'h6c: code_data = 8'h2e;   // .    2e
                    8'h6d: code_data = 8'h2e;   // .    2e
                    8'h6e: code_data = 8'h00;   //      00
                    8'h6f: code_data = 8'h00;   //      00
                        
                    //GROUP 8                   //      hex
                    8'h70: code_data = 8'h2e;   // .    2e
                    8'h71: code_data = 8'h2e;   // .    2e
                    8'h72: code_data = 8'h2e;   // .    2e
                    8'h73: code_data = 8'h00;   //      00
                    8'h74: code_data = 8'h6b;   // k    6b
                    8'h75: code_data = 8'h6f;   // o    6f
                    8'h76: code_data = 8'h6c;   // l    6c
                    8'h77: code_data = 8'h65;   // e    65
                    8'h78: code_data = 8'h6a;   // j    6a
                    8'h79: code_data = 8'h6e;   // n    6e
                    8'h7a: code_data = 8'h61;   // a    61
                    8'h7b: code_data = 8'h2e;   // .    2e
                    8'h7c: code_data = 8'h2e;   // .    2e
                    8'h7d: code_data = 8'h2e;   // .    2e
                    8'h7e: code_data = 8'h00;   //      00
                    8'h7f: code_data = 8'h00;   //      00
                         
                    //GROUP 9                   //      hex
                    8'h80: code_data = 8'h2e;   // .    2e
                    8'h81: code_data = 8'h2e;   // .    2e
                    8'h82: code_data = 8'h2e;   // .    2e
                    8'h83: code_data = 8'h00;   //      00
                    8'h84: code_data = 8'h6b;   // k    6b
                    8'h85: code_data = 8'h6f;   // o    6f
                    8'h86: code_data = 8'h6c;   // l    6c
                    8'h87: code_data = 8'h65;   // e    65
                    8'h88: code_data = 8'h6a;   // j    6a
                    8'h89: code_data = 8'h6e;   // n    6e
                    8'h8a: code_data = 8'h61;   // a    61
                    8'h8b: code_data = 8'h2e;   // .    2e
                    8'h8c: code_data = 8'h2e;   // .    2e
                    8'h8d: code_data = 8'h2e;   // .    2e
                    8'h8e: code_data = 8'h00;   //      00
                    8'h8f: code_data = 8'h00;   //      00
                       
                    //GROUP 10                  //      hex
                    8'h90: code_data = 8'h2e;   // .    2e
                    8'h91: code_data = 8'h2e;   // .    2e
                    8'h92: code_data = 8'h2e;   // .    2e
                    8'h93: code_data = 8'h00;   //      00
                    8'h94: code_data = 8'h6b;   // k    6b
                    8'h95: code_data = 8'h6f;   // o    6f
                    8'h96: code_data = 8'h6c;   // l    6c
                    8'h97: code_data = 8'h65;   // e    65
                    8'h98: code_data = 8'h6a;   // j    6a
                    8'h99: code_data = 8'h6e;   // n    6e
                    8'h9a: code_data = 8'h61;   // a    61
                    8'h9b: code_data = 8'h2e;   // .    2e
                    8'h9c: code_data = 8'h2e;   // .    2e
                    8'h9d: code_data = 8'h2e;   // .    2e
                    8'h9e: code_data = 8'h00;   //      00
                    8'h9f: code_data = 8'h00;   //      00
        
                    //GROUP 11                  //      hex
                    8'ha0: code_data = 8'h2e;   // .    2e
                    8'ha1: code_data = 8'h2e;   // .    2e
                    8'ha2: code_data = 8'h2e;   // .    2e
                    8'ha3: code_data = 8'h00;   //      00
                    8'ha4: code_data = 8'h6b;   // k    6b
                    8'ha5: code_data = 8'h6f;   // o    6f
                    8'ha6: code_data = 8'h6c;   // l    6c
                    8'ha7: code_data = 8'h65;   // e    65
                    8'ha8: code_data = 8'h6a;   // j    6a
                    8'ha9: code_data = 8'h6e;   // n    6e
                    8'haa: code_data = 8'h61;   // a    61
                    8'hab: code_data = 8'h2e;   // .    2e
                    8'hac: code_data = 8'h2e;   // .    2e
                    8'had: code_data = 8'h2e;   // .    2e
                    8'hae: code_data = 8'h00;   //      00
                    8'haf: code_data = 8'h00;   //      00
                         
                    //GROUP 12                  //      hex
                    8'hb0: code_data = 8'h2e;   // .    2e
                    8'hb1: code_data = 8'h2e;   // .    2e
                    8'hb2: code_data = 8'h2e;   // .    2e
                    8'hb3: code_data = 8'h00;   //      00
                    8'hb4: code_data = 8'h6b;   // k    6b
                    8'hb5: code_data = 8'h6f;   // o    6f
                    8'hb6: code_data = 8'h6c;   // l    6c
                    8'hb7: code_data = 8'h65;   // e    65
                    8'hb8: code_data = 8'h6a;   // j    6a
                    8'hb9: code_data = 8'h6e;   // n    6e
                    8'hba: code_data = 8'h61;   // a    61
                    8'hbb: code_data = 8'h2e;   // .    2e
                    8'hbc: code_data = 8'h2e;   // .    2e
                    8'hbd: code_data = 8'h2e;   // .    2e
                    8'hbe: code_data = 8'h00;   //      00
                    8'hbf: code_data = 8'h00;   //      00
                        
                    //GROUP 13                  //      hex
                    8'hc0: code_data = 8'h2e;   // .    2e
                    8'hc1: code_data = 8'h2e;   // .    2e
                    8'hc2: code_data = 8'h2e;   // .    2e
                    8'hc3: code_data = 8'h00;   //      00
                    8'hc4: code_data = 8'h6b;   // k    6b
                    8'hc5: code_data = 8'h6f;   // o    6f
                    8'hc6: code_data = 8'h6c;   // l    6c
                    8'hc7: code_data = 8'h65;   // e    65
                    8'hc8: code_data = 8'h6a;   // j    6a
                    8'hc9: code_data = 8'h6e;   // n    6e
                    8'hca: code_data = 8'h61;   // a    61
                    8'hcb: code_data = 8'h2e;   // .    2e
                    8'hcc: code_data = 8'h2e;   // .    2e
                    8'hcd: code_data = 8'h2e;   // .    2e
                    8'hce: code_data = 8'h00;   //      00
                    8'hcf: code_data = 8'h00;   //      00
                        
                    //GROUP 14                  //      hex
                    8'hd0: code_data = 8'h2e;   // .    2e
                    8'hd1: code_data = 8'h2e;   // .    2e
                    8'hd2: code_data = 8'h2e;   // .    2e
                    8'hd3: code_data = 8'h00;   //      00
                    8'hd4: code_data = 8'h6b;   // k    6b
                    8'hd5: code_data = 8'h6f;   // o    6f
                    8'hd6: code_data = 8'h6c;   // l    6c
                    8'hd7: code_data = 8'h65;   // e    65
                    8'hd8: code_data = 8'h6a;   // j    6a
                    8'hd9: code_data = 8'h6e;   // n    6e
                    8'hda: code_data = 8'h61;   // a    61
                    8'hdb: code_data = 8'h2e;   // .    2e
                    8'hdc: code_data = 8'h2e;   // .    2e
                    8'hdd: code_data = 8'h2e;   // .    2e
                    8'hde: code_data = 8'h00;   //      00
                    8'hdf: code_data = 8'h00;   //      00
                        
                    //GROUP 15                  //      hex
                    8'he0: code_data = 8'h2e;   // .    2e
                    8'he1: code_data = 8'h2e;   // .    2e
                    8'he2: code_data = 8'h2e;   // .    2e
                    8'he3: code_data = 8'h00;   //      00
                    8'he4: code_data = 8'h6b;   // k    6b
                    8'he5: code_data = 8'h6f;   // o    6f
                    8'he6: code_data = 8'h6c;   // l    6c
                    8'he7: code_data = 8'h65;   // e    65
                    8'he8: code_data = 8'h6a;   // j    6a
                    8'he9: code_data = 8'h6e;   // n    6e
                    8'hea: code_data = 8'h61;   // a    61
                    8'heb: code_data = 8'h2e;   // .    2e
                    8'hec: code_data = 8'h2e;   // .    2e
                    8'hed: code_data = 8'h2e;   // .    2e
                    8'hee: code_data = 8'h00;   //      00
                    8'hef: code_data = 8'h00;   //      00
                                       
                    //GROUP 16                  //      hex
                    8'hf0: code_data = 8'h2e;   // .    2e
                    8'hf1: code_data = 8'h2e;   // .    2e
                    8'hf2: code_data = 8'h2e;   // .    2e
                    8'hf3: code_data = 8'h00;   //      00
                    8'hf4: code_data = 8'h6b;   // k    6b
                    8'hf5: code_data = 8'h6f;   // o    6f
                    8'hf6: code_data = 8'h6c;   // l    6c
                    8'hf7: code_data = 8'h65;   // e    65
                    8'hf8: code_data = 8'h6a;   // j    6a
                    8'hf9: code_data = 8'h6e;   // n    6e
                    8'hfa: code_data = 8'h61;   // a    61
                    8'hfb: code_data = 8'h2e;   // .    2e
                    8'hfc: code_data = 8'h2e;   // .    2e
                    8'hfd: code_data = 8'h2e;   // .    2e
                    8'hfe: code_data = 8'h00;   //      00
                    8'hff: code_data = 8'h00;   //      00                
                        
            endcase
        end
endmodule
