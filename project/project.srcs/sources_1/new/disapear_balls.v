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


module disappear_balls(
    input wire clk,
	input wire rst,
    input wire disp_en,
    input wire [63:0] color_0_in,
    input wire [63:0] color_1_in,
    input wire [63:0] color_2_in,
    input wire [63:0] color_3_in,
    input wire [9:0] points_in,
	
    output reg [63:0] color_0_out,
    output reg [63:0] color_1_out,
    output reg [63:0] color_2_out,
    output reg [63:0] color_3_out,
    output reg [9:0] points_out
//    output reg set_new
    );
    
    integer i,n;
    reg [7:0] counter_x0, counter_y0;
    reg [7:0] counter_x1, counter_y1;
    reg [7:0] counter_x2, counter_y2;
    reg [7:0] counter_x3, counter_y3;
    reg [6:0] four_counter0, four_counter1, four_counter2, four_counter3;
    reg [63:0] color_0_nxt, color_1_nxt, color_2_nxt, color_3_nxt;
	reg [9:0] points_nxt;
	reg set_new_nxt;
	
	always @(posedge clk)
	begin
		if(rst)
		begin
			color_0_out <= 0;
			color_1_out <= 0;
			color_2_out <= 0;
            color_3_out <= 0;
			points_out <= 0;
//			set_new <= 0;
//		    four_counter0 = 7'b0;
//            four_counter1 = 7'b0;
//            four_counter2 = 7'b0;
//            four_counter3 = 7'b0;
		end
		else begin
			color_0_out <= color_0_nxt;
			color_1_out <= color_1_nxt;
			color_2_out <= color_2_nxt;
            color_3_out <= color_3_nxt;
			points_out <= points_nxt;
//			set_new <= set_new_nxt;
		end
	end
    
    always @* begin    
		if(disp_en)
		begin
			four_counter0=0;
			four_counter1=0;
			four_counter2=0;
            four_counter3=0;
			color_0_nxt = color_0_in;
			color_1_nxt = color_1_in;
			color_2_nxt = color_2_in;
            color_3_nxt = color_3_in;
			
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
					if(color_0_in[(n*8)+i]) 
						counter_x0 = counter_x0 + 1;
					else counter_x0 = 0;                 
					if(color_0_in[(i*8)+n]) 
						counter_y0 = counter_y0 + 1;
					else counter_y0 = 0;   
							
					if(counter_x0 >= 4) begin 
						four_counter0 = four_counter0 + 1; 
						color_0_nxt[(n*8)+i] = 0;
						color_0_nxt[(n*8)+(i-1)] = 0;
						color_0_nxt[(n*8)+(i-2)] = 0;
						color_0_nxt[(n*8)+(i-3)] = 0;
					end  
					if(counter_y0 >=4) begin 
						four_counter0 = four_counter0 + 1; 
						color_0_nxt[((i)*8)+ n] = 0;
						color_0_nxt[((i-1)*8)+ n] = 0;
						color_0_nxt[((i-2)*8)+ n] = 0;
						color_0_nxt[((i-3)*8)+ n] = 0;                  
					end      
	               
					
				// liczenie i niszczenie color_1 
					if(color_1_in[(n*8)+i]) 
						counter_x1 = counter_x1 + 1;
					else counter_x1 = 0;
					if(color_1_in[(i*8)+n]) 
						counter_y1 = counter_y1 + 1;
					else counter_y1 = 0;
					
					if(counter_x1 >= 4) begin 
						four_counter1 = four_counter1 + 1; 
						color_1_nxt[(n*8)+i] = 0;
						color_1_nxt[(n*8)+i-1] = 0;
						color_1_nxt[(n*8)+i-2] = 0;
						color_1_nxt[(n*8)+i-3] = 0;
					end  
					if(counter_y1 >=4) begin 
						four_counter1 = four_counter1 + 1; 
						color_1_nxt[((i)*8)+ n] = 0;
                        color_1_nxt[((i-1)*8)+ n] = 0;
                        color_1_nxt[((i-2)*8)+ n] = 0;
                        color_1_nxt[((i-3)*8)+ n] = 0;
					end   
					
				// liczenie i niszczenie color_2 
                   if(color_2_in[(n*8)+i]) 
                        counter_x2 = counter_x2 + 1;
                   else counter_x2 = 0;
                   if(color_2_in[(i*8)+n]) 
                        counter_y2 = counter_y2 + 1;
                   else counter_y2 = 0;
                        
                   if(counter_x2 >= 4) begin 
                        four_counter2 = four_counter2 + 1; 
                        color_2_nxt[(n*8)+i] = 0;
                        color_2_nxt[(n*8)+i-1] = 0;
                        color_2_nxt[(n*8)+i-2] = 0;
                        color_2_nxt[(n*8)+i-3] = 0;
                  end  
                  if(counter_y2 >=4) begin 
                       four_counter2 = four_counter2 + 1; 
					   color_2_nxt[((i)*8)+ n] = 0;
                       color_2_nxt[((i-1)*8)+ n] = 0;
                       color_2_nxt[((i-2)*8)+ n] = 0;
                       color_2_nxt[((i-3)*8)+ n] = 0;
                  end      
                  
				// liczenie i niszczenie color_3
                 if(color_3_in[(n*8)+i]) 
                    counter_x3 = counter_x3 + 1;
                 else counter_x3 = 0;
                 if(color_3_in[(i*8)+n]) 
                    counter_y3 = counter_y3 + 1;
                 else counter_y3 = 0;
                                
                 if(counter_x3 >= 4) begin 
                    four_counter3 = four_counter3 + 1; 
                    color_3_nxt[(n*8)+i] = 0;
                    color_3_nxt[(n*8)+i-1] = 0;
                    color_3_nxt[(n*8)+i-2] = 0;
                    color_3_nxt[(n*8)+i-3] = 0;
                 end  
                 if(counter_y3 >=4) begin 
                   four_counter3 = four_counter3 + 1; 
				   color_3_nxt[((i)*8)+ n] = 0;
                   color_3_nxt[((i-1)*8)+ n] = 0;
                   color_3_nxt[((i-2)*8)+ n] = 0;
                   color_3_nxt[((i-3)*8)+ n] = 0;
                end                                                                
				end               
			end 
		points_nxt = points_in + four_counter0 + four_counter1 + four_counter2 + four_counter3;   
//        set_new_nxt = (points_nxt > points_in) ? 0 : 1;
        end
        
        else begin
        color_0_nxt = color_0_out;
        color_1_nxt = color_1_out;
        color_2_nxt = color_2_out;
        color_3_nxt = color_3_out;
        end
    end    

    
endmodule
