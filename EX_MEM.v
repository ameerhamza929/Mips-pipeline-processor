`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:30:07 05/18/2024 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(input clk,rst, 
 input mem_read_idex,
 mem_write_idex,
 mem_to_reg_idex,
 reg_dst_idex,
 reg_write_idex,
 jump_idex,
 branch_idex,
 zero,
 input [31:0]alu_result,
 input [31:0]rt_data_idex,
 input [4:0] rt_idex,
 input [4:0] rd_idex,
 input [31:0] signextend_idex,
 output reg[4:0] writebackreg_exmem,
 output reg[31:0] alu_result_exmem,
 output reg [31:0] signextend_exmem,
 output reg[31:0] rt_data_exmem,
 output reg mem_read_exmem,
 mem_write_exmem,
 mem_to_reg_exmem,
 reg_write_exmem,
 jump_exmem,
 branch_exmem,
 zero_exmem
 
 
    );
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			 writebackreg_exmem<=0;
			 alu_result_exmem<=0;
			 rt_data_exmem<=0;
			 mem_read_exmem<=0;
			 mem_write_exmem<=0;
			 mem_to_reg_exmem<=0;
			 reg_write_exmem<=0;
			 jump_exmem<=0;
			 branch_exmem<=0;
			 zero_exmem<=0;
			signextend_exmem<=0;
		end
		else begin
			if(reg_dst_idex)
				writebackreg_exmem<=rd_idex;
			else
				writebackreg_exmem<=rt_idex;
			mem_read_exmem<=mem_read_idex;
			mem_write_exmem<=mem_write_idex;
			mem_to_reg_exmem<= mem_to_reg_idex;
			reg_write_exmem<=reg_write_idex;
			jump_exmem<=jump_idex;
			branch_exmem<=branch_idex;
			zero_exmem<=zero;
		   signextend_exmem<= signextend_idex;
			rt_data_exmem<=rt_data_idex;
			alu_result_exmem<=alu_result;
		end
	end

endmodule
