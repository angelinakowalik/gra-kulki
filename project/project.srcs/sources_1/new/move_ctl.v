`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2018 13:57:12
// Design Name: 
// Module Name: move_ctl
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


module move_ctl(
    input wire          pclk,
    input wire          rst,
    input wire          empty,
    input wire          in_range,
    input wire          mouse_left,
    input wire          move_en,
    input wire [3:0]    column_in,
    input wire [3:0]    row_in,
    input wire [1:0]    transfer_color_in,
    
    output reg          transfer,
    output reg          write,
    output reg          delete,
    output reg [1:0]    transfer_color_out,
    output reg [3:0]    column_out,
    output reg [3:0]    row_out,
    output reg [3:0]    column_del,
    output reg [3:0]    row_del,
    output reg          move_end
    );
    
    localparam  IDLE        = 3'b000,
                CHECK       = 3'b001,
                SELECT      = 3'b010,
                PUT         = 3'b011,
                SET         = 3'b100,
                BACK        = 3'b101,
                END         = 3'b110,
                END_END     = 3'b111;
    
    localparam  STATE_SIZE = 3;
    
    reg [STATE_SIZE - 1 :0] state, state_nxt;
    reg transfer_nxt, write_nxt, delete_nxt;
    reg [3:0] column_temp, row_temp, column_temp_nxt, row_temp_nxt;
    reg [3:0] column_nxt, row_nxt, column_del_nxt, row_del_nxt;
    reg [1:0] transfer_color_nxt;
    reg move_end_nxt, move_end_nxt1;
    
    always @(posedge pclk)
    begin
        if(rst)
        begin
            state       <= IDLE;
            
            transfer    <= 0;
            write       <= 0;
            delete      <= 0;
            move_end    <= 0;
                        
            column_out  <= 0;
            row_out     <= 0;
            column_del  <= 0;
            row_del     <= 0;
            column_temp <= 0;
            row_temp    <= 0;
            
            transfer_color_out <= 0;
        end
        else begin
            state       <= state_nxt;
            
            transfer    <= transfer_nxt;
            write       <= write_nxt;
            delete      <= delete_nxt;
            //move_end_nxt1 <= move_end_nxt;
            move_end    <= move_end_nxt;
            
            column_out  <= column_nxt;
            row_out     <= row_nxt;
            column_del  <= column_del_nxt;
            row_del     <= row_del_nxt;
            column_temp <= column_temp_nxt;
            row_temp    <= row_temp_nxt;
            
            transfer_color_out <= transfer_color_nxt;
        end
    end
    
    always @*
    begin
        case(state)
            IDLE:   state_nxt = (move_en && mouse_left && in_range && (!empty)) ? CHECK:IDLE;
            CHECK:  state_nxt = (!empty)                 ? SELECT:IDLE;
            SELECT: state_nxt =                            PUT;
            PUT:    begin
                        if(!mouse_left)
                            state_nxt = (empty && in_range) ? SET:BACK;
                        else
                            state_nxt = PUT;
                    end
            SET:    state_nxt =                            END;
            BACK:   state_nxt =                            IDLE;
            END:    state_nxt =                            END_END;
            END_END:state_nxt =                            IDLE;
            default: state_nxt =                           IDLE;
        endcase
    end
    
    always @*
    begin
//        transfer_nxt = transfer;
//        write_nxt = write;
//        delete_nxt = delete;
//        move_end_nxt = move_end;
        
        transfer_color_nxt = transfer_color_out;
        
//        column_nxt = column_out;
//        row_nxt = row_out;
//        column_del_nxt = column_del;
//        row_del_nxt = row_del;
//        column_temp_nxt = column_temp;
//        row_temp_nxt = row_temp;
        
        case(state)
            IDLE:   begin
//                        column_temp = column_in;
//                        row_temp    = row_in;
                        transfer_nxt = 1'b0;
                        write_nxt = 1'b0;
                        delete_nxt = 1'b0;
                        move_end_nxt = 1'b0;      
                        column_temp_nxt = column_in;
                        row_temp_nxt = row_in;
                        transfer_color_nxt = transfer_color_in;
                        
                        column_nxt = column_out;
                        row_nxt = row_out;
                        column_del_nxt = column_del;
                        row_del_nxt = row_del;              
                    end
            CHECK:  begin
                        transfer_color_nxt = transfer_color_in;
                        column_temp_nxt = column_in;
                        row_temp_nxt = row_in;
                        
                        move_end_nxt = 1'b0;
                        delete_nxt = 1'b0;  
                        write_nxt = 1'b0;
                        transfer_nxt = 1'b0;
                        
                        column_nxt = column_out;
                        row_nxt = row_out;
                        column_del_nxt = column_del;
                        row_del_nxt = row_del;
                    end
            SELECT: begin
                        column_del_nxt = column_temp;
                        row_del_nxt = row_temp;
//                        column_nxt = column_in;
//                        row_nxt = row_in;                        
                        transfer_nxt = 1'b1;
                        delete_nxt = 1'b1;
                        
                        write_nxt = 1'b0;
                        move_end_nxt = 1'b0; 
                        transfer_color_nxt = transfer_color_out;
                        
                        column_nxt = column_out;
                        row_nxt = row_out;
                        column_temp_nxt = column_temp;
                        row_temp_nxt = row_temp;
                    end 
            PUT:    begin
                        delete_nxt = 1'b1;
                        
                        write_nxt = 1'b0;
                        move_end_nxt = 1'b0; 
                        transfer_nxt = 1'b1;
                        transfer_color_nxt = transfer_color_out;
                        
                        column_nxt = column_out;
                        row_nxt = row_out;
                        column_del_nxt = column_del;
                        row_del_nxt = row_del;
                        column_temp_nxt = column_temp;
                        row_temp_nxt = row_temp;
                    end  
            SET:    begin
                        column_nxt = column_in;
                        row_nxt = row_in;
                        transfer_nxt = 1'b0;
                        write_nxt = 1'b1;
                        
                        delete_nxt = 1'b0;
                        move_end_nxt = 1'b0; 
                        transfer_color_nxt = transfer_color_out;
                        
                        column_del_nxt = column_del;
                        row_del_nxt = row_del;
                        column_temp_nxt = column_temp;
                        row_temp_nxt = row_temp;
                    end
            BACK:   begin
                        column_nxt = column_temp;
                        row_nxt = row_temp;
                        transfer_nxt = 1'b0;
                        write_nxt = 1'b1;
                        
                        delete_nxt = 1'b0; 
                        move_end_nxt = 1'b0;      
                        transfer_color_nxt = transfer_color_out;      
                        
                        column_del_nxt = column_del;
                        row_del_nxt = row_del;
                        column_temp_nxt = column_temp;
                        row_temp_nxt = row_temp;                
                        end
            END:    begin
                        move_end_nxt = 1'b0;
                        write_nxt = 1'b1;
                        
                        delete_nxt = 1'b0; 
                        transfer_nxt = 1'b0;
                        transfer_color_nxt = transfer_color_out;
                        
                        column_nxt = column_out;
                        row_nxt = row_out;
                        column_del_nxt = column_del;
                        row_del_nxt = row_del;
                        column_temp_nxt = column_temp;
                        row_temp_nxt = row_temp;
                    end
            END_END: begin
                        move_end_nxt = 1'b1;
                        
                        write_nxt = 1'b0;
                        delete_nxt = 1'b0; 
                        transfer_nxt = 1'b0;
                        transfer_color_nxt = transfer_color_out;
                        
                        column_nxt = column_out;
                        row_nxt = row_out;
                        column_del_nxt = column_del;
                        row_del_nxt = row_del;
                        column_temp_nxt = column_temp;
                        row_temp_nxt = row_temp;
                     end
        endcase
    end
endmodule
