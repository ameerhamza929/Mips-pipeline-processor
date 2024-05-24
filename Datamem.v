`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:12 05/18/2024 
// Design Name: 
// Module Name:    Datamem 
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
module Datamem( input [31:0]address, 
	input [31:0]data_in, 
	output reg [31:0] data_out,  
	input clk,
	input rst,
	input we,
	input mem_read_exmem
	); 

	reg [31:0] memory [4:0]; 
   
	
	initial begin
		memory [0] = 32'd13; 
		memory [1] = 32'd10;
		memory [2] = 32'd15;
		memory[3]=32'd20;
	end
	
   always @(*) begin
		if(mem_read_exmem)
			data_out=memory[address];

	end
	
	//assign data_out = memory [address]; 
	
	always @(posedge clk )begin
		//if(rst)
		//	data_out=0;
		if (we)
			memory [address] <= data_in; 	
	end



endmodule
