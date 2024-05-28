`timescale 1ns / 1ps

module Datamem( input [31:0]address,  
	output reg [31:0] data_out,  
	input clk,
	input rst,
	input we,
	input mem_read_exmem,
	input [31:0]rt_data_exmem,
	input [31:0]data_towrite_memwb,
	input [1:0]forwardBE
	); 
	reg [31:0]data_in;
	reg [31:0] memory [8:0]; 
   
	
	initial begin
		memory [0] = 32'd13; 
		memory [1] = 32'd10;
		memory [2] = 32'b00000000000000000000000000000001;
		memory[3]=32'd20;
		memory[4]=32'b00000000000000000000000000000101;
		memory[5]=32'b00000000000000000000000000001101;
		memory[6]=32'b00000000000000000000000000000100;
		memory[7]=32'b00000000000000000000000000000011;
		memory[8]=32'b00000000000000000000000000000111;
	end
	
   always @(*) begin
		if(rst)
			data_out=0;
		else begin	
			if(mem_read_exmem)
				data_out=memory[address];
		end		

	end
	always@(*)begin
		case(forwardBE)
			2'b00:data_in=rt_data_exmem;
			2'b10:data_in=data_towrite_memwb;
		endcase	
	end
	//assign data_out = memory [address]; 
	
	always @(posedge clk )begin
		
		if (we)
			memory [address] <= data_in; 	
	end



endmodule
