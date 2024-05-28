`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:12:41 05/18/2024 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB( input clk ,rst, 
input mem_to_reg_exmem,
 reg_write_exmem,
 input [31:0]memdata,
 input [31:0] alu_result_exmem,
 input [4:0] writebackreg_exmem,
 input mem_read_exmem,
 output reg [4:0] writebackreg_memwb,
 output reg reg_write_memwb,
 output reg mem_read_memwb,
 output reg[31:0] data_towrite_memwb
    );
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			writebackreg_memwb<=0;
			reg_write_memwb<=0;
			data_towrite_memwb<=0;
			mem_read_memwb<=0;
		end
		else begin
			if(mem_to_reg_exmem)
				data_towrite_memwb<=alu_result_exmem;
			else
				data_towrite_memwb<=memdata;
			
			writebackreg_memwb<=writebackreg_exmem;
			reg_write_memwb<=reg_write_exmem;
			mem_read_memwb<=mem_read_exmem;
		end
	end

endmodule
