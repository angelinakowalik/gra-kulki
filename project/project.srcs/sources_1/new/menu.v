`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.06.2018 15:37:02
// Design Name: 
// Module Name: menu
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


module menu (
	input wire pclk,
	input wire rst,
	input wire game_en,
	input wire end_en,
	input wire mouse_left,

	output reg start_mode,
	output reg game_mode,
	output reg end_mode
	);

localparam	STATE_BITS	= 2;

localparam	START	= 2'b00,
			GAME	= 2'b01,
			END  	= 2'b10;

reg [STATE_BITS - 1 : 0] state, state_nxt;
reg start_mode_nxt, game_mode_nxt, end_mode_nxt;

	always @(posedge pclk) begin
		if(rst) begin
			state        <= 0;
			start_mode   <= 0;
			game_mode    <= 0;
			end_mode     <= 0;
		end
		else begin
			state        <= state_nxt;
			start_mode   <= start_mode_nxt;
			game_mode    <= game_mode_nxt;
			end_mode     <= end_mode_nxt;
		end
	end

	always @* begin
		case(state)
			START:   state_nxt = game_en     ?   GAME : START;
			GAME:    state_nxt = end_en      ?   END  : GAME;
			END:     state_nxt = mouse_left  ?   START : END;
			default: state_nxt =                 START;
		endcase
	end
	always @*
	begin
	   start_mode_nxt = start_mode;
	   game_mode_nxt = game_mode;
	   
		case(state)
			START:  begin
                        start_mode_nxt = 1'b1;
                        game_mode_nxt = 1'b0;
				        end_mode_nxt = 1'b0;
                    end
			GAME:   begin
                        start_mode_nxt = 1'b0;
				        game_mode_nxt = 1'b1;
				        end_mode_nxt = 1'b0;
			        end
			END :   begin
				        start_mode_nxt = 1'b0;
				        game_mode_nxt = 1'b0;
				        end_mode_nxt = 1'b1;
			        end
			default:begin
				        start_mode_nxt = 1'b1;
				        game_mode_nxt = 1'b0;
				        end_mode_nxt = 1'b0;
			         end
		endcase
	end
endmodule
