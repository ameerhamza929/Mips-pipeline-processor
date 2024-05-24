`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:21:34 05/18/2024 
// Design Name: 
// Module Name:    Alu_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Alu_control(input clk,input rst,
	input [5:0]func_idex,
	input[1:0]alu_op_idex,
	output reg[3:0] alu_control
    );
	always @(*) begin
    if (rst) begin
        alu_control = 4'b0000;
    end
    else begin
        case (alu_op_idex)
            2'b10: case (func_idex)
                6'b000000: alu_control = 4'b0010; //Add 
                6'b000001: alu_control = 4'b0110; //SUB
                6'b000010: alu_control = 4'b0000; //AND
					
                default: alu_control = 4'b0010;
            endcase
            2'b11: alu_control = 4'b0010;
				2'b01: alu_control = 4'b0110; 
            default: alu_control = 4'b0010;
        endcase
    end
end

endmodule
