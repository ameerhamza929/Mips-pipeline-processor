`timescale 1ns / 1ps

module Instruction_memory( input rst,input [31:0]address, output reg [31:0] instruction); 	
	reg [31:0] memory [7:0]; 

	initial begin
		//memory [0] = 32'b000001_00001_00000_00010_00000_000000;
		//memory [1] = 32'b100011_00000_00011_00000_00000_000001; //add $1, $2, $3
		//memory [2] = 32'b001100_00000_00000_00000_00000_000101;
		//memory [3] = 32'b000001_00001_00011_01011_00000_000000;
		//memory [4] = 32'b100011_00000_00001_00000_00000_000001; //add $1, $2, $3
		//memory [5] = 32'b111010_00000_00001_00111_00000_000000;
		//memory [6] = 32'b000001_00000_00000_01000_00000_000010;
		
		memory[0] = 32'b000001_00010_00011_00001_00000_000000; // add $1, $2, $3
		memory[1] = 32'b100011_00001_00100_00000_00000_000010; // lw $4, 0($1)
		memory[2] = 32'b000100_00001_00100_00000_00000_000101; // beq $1, $4, offset 2 (branch if equal)
		memory[3] = 32'b111000_00001_00010_00101_00000_101010; // slt $5, $1, $2
		memory[4] = 32'b111010_00000_00010_00110_00010_000000; // sll $6, $2, 2
		memory[5] = 32'b101000_00001_00111_00000_00000_000010; // addi $7, $1, 2
		memory[6] = 32'b101011_00001_00111_00000_00000_000001; // sw $7, 4($1)
		memory[7] = 32'b000001_00010_00011_01000_00000_000000; // add $8, $2, $3
		
	end
 

	always@(*)begin
		if(rst)begin
			instruction=0;
		end
		else
			instruction = memory [address];
	end


endmodule
