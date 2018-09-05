// This is the ROM for the 'AGH48x64.png' image.
// The image size is 48 x 64 pixels.
// The input 'address' is a 12-bit number, composed of the concatenated
// 6-bit y and 6-bit x pixel coordinates.
// The output 'rgb' is 12-bit number with concatenated
// red, green and blue color values (4-bit each)
module image_rom (
    input wire clk ,
    input wire [1:0] color_in,
    input wire [11:0] address,  // address = {addry[5:0], addrx[5:0]}
	
    output reg [11:0] rgb
);

localparam	IMAGE_SIZE = 4000;

reg [11:0] red [0:IMAGE_SIZE];
reg [11:0] blue [0: IMAGE_SIZE];
reg [11:0] green [0: IMAGE_SIZE];
reg [11:0] yellow [0: IMAGE_SIZE];


initial $readmemh("ball_r.data", red); 
initial $readmemh("ball_b.data", blue); 
initial $readmemh("ball_g.data", green); 
initial $readmemh("ball_y.data", yellow); 

	always @(posedge clk)
	begin
		case(color_in)
			2'b00:	rgb <= red[address];
			2'b01:	rgb <= blue[address];
			2'b10:	rgb <= green[address];
			2'b11:	rgb <= yellow[address];
		endcase
	end
endmodule
