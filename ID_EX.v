`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:10:33 05/18/2024 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(input reg_dst,reg_write, alu_src, mem_read, mem_write, pc_src,jump,branch,mem_to_reg,
 input [1:0]alu_op,
 input clk,
 input rst,
 input [31:0] signextend,
 input [5:0] func,
 input [31:0]rs_data,
 input [31:0]rt_data,
 output reg reg_dst_idex,reg_write_idex,
 alu_src_idex,
 mem_read_idex,
 mem_write_idex,
 pc_src_idex,
 jump_idex,
 branch_idex,
 mem_to_reg_idex,
 output reg [1:0]alu_op_idex,
 input [4:0]rd,
 input [4:0]rt,
 input [4:0]rs,
 output reg [4:0] rd_idex,
 output reg [4:0] rt_idex,
 output reg[4:0]rs_idex,
 output reg [31:0] signextend_idex,
 output reg [5:0] func_idex,
 output reg [31:0]rs_data_idex,
 output reg [31:0]rt_data_idex
    );
	always@(posedge clk or posedge rst)begin
		if(rst)begin
			reg_dst_idex<=0;
			reg_write_idex<=0;
			alu_src_idex<=0;
			mem_read_idex<=0;
			mem_write_idex<=0;
			pc_src_idex<=0;
			jump_idex<=0;
			branch_idex<=0;
			mem_to_reg_idex<=0;
			signextend_idex<=0;
			func_idex<=0;
			rt_idex<=0;
			rd_idex<=0;
			alu_op_idex<=0;
			rs_data_idex<=0;
			rt_data_idex<=0;
			rs_idex<=0;
		end
		else begin
			reg_dst_idex<=reg_dst;
			reg_write_idex<=reg_write;
			alu_src_idex<=alu_src;
			mem_read_idex<=mem_read;
			mem_write_idex<=mem_write;
			pc_src_idex<=pc_src;
			jump_idex<=jump;
			branch_idex<=branch;
			mem_to_reg_idex<=mem_to_reg;
			signextend_idex<=signextend;
			func_idex<=func;
			rs_data_idex<=rs_data;
			rt_data_idex<=rt_data;
			alu_op_idex<=alu_op;
			rt_idex<=rt;
			rd_idex<=rd;
			rs_idex<=rs;
		end
	end

endmodule
