//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2018 21:06:12
// Design Name: 
// Module Name: draw_rect_ctl_test
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


module draw_rect_ctl_test();

    wire mouse_left;
    wire [11:0] mouse_xpos, mouse_ypos, xpos, ypos;
    
    reg clk;
    reg rst;
    
    initial
    begin
        rst = 1'b0;
        #20;
        rst = 1'b1;
        #20;
        rst =1'b0;
    end

    always
    begin
        clk =1'b0;
        #12.5;
        clk = 1'b1;
        #12.5;
    end

draw_rect_ctl_tb my_draw_tb (
    .mouse_left(mouse_left),
    .mouse_xpos(mouse_xpos),
    .mouse_ypos(mouse_ypos)
);

draw_rect_ctl my_draw_ctl (
    .clk(clk),
    .rst(rst),
    .mouse_left(mouse_left),
    .mouse_xpos(mouse_xpos),
    .mouse_ypos(mouse_ypos),
    .xpos(xpos),
    .ypos(ypos)
);

    initial
        begin
            $display("Start of simulation, mouse cursor is set on the top of the screen");
            wait (mouse_left == 1'b0);
            #500
            $display("Simulation is over, check the waveform");
            $stop;
        end
endmodule
