`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:04:51 05/18/2024 
// Design Name: 
// Module Name:    Instruction_memory 
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
module Instruction_memory( input rst,input [31:0]address, output reg [31:0] instruction); 	
	reg [31:0] memory [6:0]; 

	initial begin
		memory [0] = 32'b000001_00001_00000_00010_00000_000000;
		memory [1] = 32'b000001_00001_00000_00011_00000_000010; //add $1, $2, $3
		memory [2] = 32'b000001_00011_00000_00011_00000_000000;
		memory [3] = 32'b000001_00001_00011_00011_00000_000000;
		memory [4] = 32'b100011_00001_00000_00000_00000_000001; //add $1, $2, $3
		memory [5] = 32'b000001_00001_00000_00111_00000_000000;
		memory [6] = 32'b101011_00000_01000_00000_00000_000001;
	end

	always@(*)begin
		if(rst)begin
			instruction=0;
		end
		else
			instruction = memory [address];
	end


endmodule
