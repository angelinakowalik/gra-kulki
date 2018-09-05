`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2018 10:03:31 PM
// Design Name: 
// Module Name: disappear_balls
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

module disappear_balls(
    input wire clk,
	input wire rst,
    input wire disp_en,
    input wire [`COLOR_BUS_SIZE - 1:0] color_in,
    input wire [9:0] points_in,
	
	output wire [`COLOR_BUS_SIZE - 1:0] color_out,
    output reg [9:0] points_out
    );
    
    `COLOR_INPUT(color_in)
    `COLOR_OUT_REG
    `COLOR_OUTPUT(color_out)
    
    integer i,n;
    reg [7:0] counter_x0, counter_y0;
    reg [7:0] counter_x1, counter_y1;
    reg [7:0] counter_x2, counter_y2;
    reg [7:0] counter_x3, counter_y3;
    reg [6:0] four_counter0, four_counter1, four_counter2, four_counter3;
    reg [63:0] color_r_nxt, color_b_nxt, color_g_nxt, color_y_nxt;
	reg [9:0] points_nxt;
	reg set_new_nxt;
	
	always @(posedge clk)
	begin
		if(rst)
		begin
			color_r_out <= 0;
			color_b_out <= 0;
			color_g_out <= 0;
            color_y_out <= 0;
			points_out <= 0;
		end
		else begin
			color_r_out <= color_r_nxt;
			color_b_out <= color_b_nxt;
			color_g_out <= color_g_nxt;
            color_y_out <= color_y_nxt;
			points_out <= points_nxt;
		end
	end
    
    always @* begin    
		if(disp_en)
		begin
			four_counter0=0;
			four_counter1=0;
			four_counter2=0;
            four_counter3=0;
			color_r_nxt = color_r_in;
			color_b_nxt = color_b_in;
			color_g_nxt = color_g_in;
            color_y_nxt = color_y_in;
			
			for(n=0; n<8; n=n+1)
			begin     
				counter_x0=0; 
				counter_y0=0;  
				counter_x1=0; 
				counter_y1=0;  
				counter_x2=0; 
                counter_y2=0; 
				counter_x3=0; 
                counter_y3=0; 
  
				
				for(i=0; i<8; i=i+1)
				begin
				// liczenie i niszczenie color_0
					if(color_r_in[(n*8)+i]) 
						counter_x0 = counter_x0 + 1;
					else counter_x0 = 0;                 
					if(color_r_in[(i*8)+n]) 
						counter_y0 = counter_y0 + 1;
					else counter_y0 = 0;   
							
					if((counter_x0 >= 4)&&(i>=3)) begin 
						four_counter0 = four_counter0 + 1; 
						color_r_nxt[(n*8)+i] = 0;
						color_r_nxt[(n*8)+(i-1)] = 0;
						color_r_nxt[(n*8)+(i-2)] = 0;
						color_r_nxt[(n*8)+(i-3)] = 0;
					end  
					if((counter_y0 >=4)&&(i>=3)) begin 
						four_counter0 = four_counter0 + 1; 
						color_r_nxt[((i)*8)+ n] = 0;
						color_r_nxt[((i-1)*8)+ n] = 0;
						color_r_nxt[((i-2)*8)+ n] = 0;
						color_r_nxt[((i-3)*8)+ n] = 0;                  
					end      
	               
					
				// liczenie i niszczenie color_1 
					if(color_b_in[(n*8)+i]) 
						counter_x1 = counter_x1 + 1;
					else counter_x1 = 0;
					if(color_b_in[(i*8)+n]) 
						counter_y1 = counter_y1 + 1;
					else counter_y1 = 0;
					
					if((counter_x1 >= 4)&&(i>=3)) begin 
						four_counter1 = four_counter1 + 1; 
						color_b_nxt[(n*8)+i] = 0;
						color_b_nxt[(n*8)+i-1] = 0;
						color_b_nxt[(n*8)+i-2] = 0;
						color_b_nxt[(n*8)+i-3] = 0;
					end  
					if((counter_y1 >=4)&&(i>=3)) begin 
						four_counter1 = four_counter1 + 1; 
						color_b_nxt[((i)*8)+ n] = 0;
                        color_b_nxt[((i-1)*8)+ n] = 0;
                        color_b_nxt[((i-2)*8)+ n] = 0;
                        color_b_nxt[((i-3)*8)+ n] = 0;
					end   
					
				// liczenie i niszczenie color_2 
                   if(color_g_in[(n*8)+i]) 
                        counter_x2 = counter_x2 + 1;
                   else counter_x2 = 0;
                   if(color_g_in[(i*8)+n]) 
                        counter_y2 = counter_y2 + 1;
                   else counter_y2 = 0;
                        
                   if((counter_x2 >= 4)&&(i>=3)) begin 
                        four_counter2 = four_counter2 + 1; 
                        color_g_nxt[(n*8)+i] = 0;
                        color_g_nxt[(n*8)+i-1] = 0;
                        color_g_nxt[(n*8)+i-2] = 0;
                        color_g_nxt[(n*8)+i-3] = 0;
                  end  
                  if((counter_y2 >=4)&&(i>=3)) begin 
                       four_counter2 = four_counter2 + 1; 
					   color_g_nxt[((i)*8)+ n] = 0;
                       color_g_nxt[((i-1)*8)+ n] = 0;
                       color_g_nxt[((i-2)*8)+ n] = 0;
                       color_g_nxt[((i-3)*8)+ n] = 0;
                  end      
                  
				// liczenie i niszczenie color_3
                 if(color_y_in[(n*8)+i]) 
                    counter_x3 = counter_x3 + 1;
                 else counter_x3 = 0;
                 if(color_y_in[(i*8)+n]) 
                    counter_y3 = counter_y3 + 1;
                 else counter_y3 = 0;
                                
                 if((counter_x3 >= 4)&&(i>=3)) begin 
                    four_counter3 = four_counter3 + 1; 
                    color_y_nxt[(n*8)+i] = 0;
                    color_y_nxt[(n*8)+i-1] = 0;
                    color_y_nxt[(n*8)+i-2] = 0;
                    color_y_nxt[(n*8)+i-3] = 0;
                 end  
                 if((counter_y3 >=4)&&(i>=3)) begin 
                   four_counter3 = four_counter3 + 1; 
				   color_y_nxt[((i)*8)+ n] = 0;
                   color_y_nxt[((i-1)*8)+ n] = 0;
                   color_y_nxt[((i-2)*8)+ n] = 0;
                   color_y_nxt[((i-3)*8)+ n] = 0;
                end                                                                
				end               
			end 
		points_nxt = points_in + four_counter0 + four_counter1 + four_counter2 + four_counter3;  
        end
        
        else begin
        color_r_nxt = color_r_out;
        color_g_nxt = color_g_out;
        color_b_nxt = color_b_out;
        color_y_nxt = color_y_out;
        points_nxt = points_in;
        end
    end    

    
endmodule
