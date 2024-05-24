`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:28:21 05/18/2024 
// Design Name: 
// Module Name:    Integration 
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
module Integration(input clk,rst, output [31:0]pc_out,
	 output [31:0]instruction
    );
	
	 wire[5:0]opcode;
	 wire[5:0]func;
    wire[31:0]jump_address;
    wire[4:0]rs;
	 wire[4:0]rt;
    wire[4:0]rd;
    wire[31:0]signextend;
	 wire reg_dst,reg_write, alu_src, mem_read, mem_write, pc_src,jump,branch;
	 wire  mem_to_reg;
    wire [1:0] alu_op;
	 wire[31:0] rs_data;
	 wire [31:0]rt_data;
	 wire  reg_dst_idex,reg_write_idex,alu_src_idex, mem_read_idex,mem_write_idex,pc_src_idex,jump_idex,branch_idex,
    mem_to_reg_idex;
	 wire [1:0]alu_op_idex;
	 wire [4:0] rd_idex;
	 wire [4:0] rt_idex;
	  wire [4:0] rs_idex;
	 wire [31:0] signextend_idex;
	 wire [5:0] func_idex;
	 wire [31:0]rs_data_idex;
	 wire [31:0]rt_data_idex;
	 wire[3:0]alu_control;
	 wire [31:0]alu_result;
	 wire zero;
	 wire[4:0] writebackreg_exmem;
	 wire[31:0] alu_result_exmem;
    wire [31:0] signextend_exmem;
    wire[31:0] rt_data_exmem;
    wire mem_read_exmem,
    mem_write_exmem,
    mem_to_reg_exmem,
    reg_write_exmem,
    jump_exmem,
    branch_exmem,
    zero_exmem;
	 wire [31:0]data_out;
	 wire [4:0] writebackreg_memwb;
	 wire [31:0]memdata_memwb;
	 wire [31:0] alu_result_memwb;
	 wire mem_to_reg_memwb,
    reg_write_memwb;
	 wire [31:0]data_towrite_memwb;
	 wire[1:0]forwardA;
	 wire[1:0]forwardB;
	 pc PC(
    .jump_address(signextend_exmem), 
    .pc_out(pc_out), 
    .jump(jump_exmem), 
    .clk(clk), 
    .rst(rst)
    );
	 Instruction_memory instmem (
	 .rst(rst),
    .address(pc_out), 
    .instruction(instruction)
    );

	IF_ID ifid (
    .instruction(instruction), 
    .clk(clk), 
    .rst(rst), 
    .opcode(opcode), 
    .func(func), 
    .jump_address(jump_address), 
    .rs(rs), 
    .rt(rt), 
    .rd(rd), 
    .signextend(signextend)
    );
	Controlunit controlunit (
    .opcode(opcode), 
    .rst(rst), 
    .reg_dst(reg_dst), 
    .reg_write(reg_write), 
    .alu_src(alu_src), 
    .mem_read(mem_read), 
    .mem_write(mem_write), 
    .pc_src(pc_src), 
    .jump(jump), 
    .branch(branch), 
    .mem_to_reg(mem_to_reg), 
    .alu_op(alu_op)
    );
   
  registermem regmem (
    .rs(rs),
    .rt(rt), 
    .writebackreg(writebackreg_memwb), 
    .rst(rst),
		.clk(clk),
    .regwrite(reg_write_memwb), 
    .data_towrite_memwb(data_towrite_memwb),
    .RD1(rs_data), 
    .RD2(rt_data)
    );
	
	ID_EX idex (
    .reg_dst(reg_dst), 
    .reg_write(reg_write), 
    .alu_src(alu_src), 
    .mem_read(mem_read), 
    .mem_write(mem_write), 
    .pc_src(pc_src), 
    .jump(jump), 
    .branch(branch), 
    .mem_to_reg(mem_to_reg), 
    .alu_op(alu_op), 
    .clk(clk), 
    .rst(rst), 
    .signextend(signextend), 
    .func(func), 
    .rs_data(rs_data), 
    .rt_data(rt_data), 
    .reg_dst_idex(reg_dst_idex), 
    .reg_write_idex(reg_write_idex), 
    .alu_src_idex(alu_src_idex), 
    .mem_read_idex(mem_read_idex), 
    .mem_write_idex(mem_write_idex), 
    .pc_src_idex(pc_src_idex), 
    .jump_idex(jump_idex), 
    .branch_idex(branch_idex), 
    .mem_to_reg_idex(mem_to_reg_idex), 
    .alu_op_idex(alu_op_idex), 
    .rd(rd), 
    .rt(rt), 
	 .rs(rs),
    .rd_idex(rd_idex), 
    .rt_idex(rt_idex), 
	 .rs_idex(rs_idex),
    .signextend_idex(signextend_idex), 
    .func_idex(func_idex), 
    .rs_data_idex(rs_data_idex), 
    .rt_data_idex(rt_data_idex)
    );
	 forwarding_unit forwarded (
    .writebackreg_memwb(writebackreg_memwb), 
    .reg_write_memwb(reg_write_memwb), 
    .reg_write_exmem(reg_write_exmem), 
    .writebackreg_exmem(writebackreg_exmem), 
    .rt_idex(rt_idex), 
    .rs_idex(rs_idex), 
    .forwardA(forwardA), 
    .forwardB(forwardB)
    );
	 
	 Alu_control alucontrol (
    .clk(clk), 
    .rst(rst), 
    .func_idex(func_idex), 
    .alu_op_idex(alu_op_idex), 
    .alu_control(alu_control)
    );
	ALU alu (
    .rs_data_idex(rs_data_idex), 
    .rt_data_idex(rt_data_idex), 
    .alu_src_idex(alu_src_idex), 
    .signextend_idex(signextend_idex), 
    .alu_control(alu_control), 
    .rst(rst), 
	 .forwardA(forwardA),
	 .forwardB(forwardB),
	 .data_towrite_memwb(data_towrite_memwb),
	 .alu_result_exmem(alu_result_exmem),
    .alu_result(alu_result), 
    .zero(zero)
    );
	EX_MEM exmem (
    .clk(clk), 
    .rst(rst), 
    .mem_read_idex(mem_read_idex), 
    .mem_write_idex(mem_write_idex), 
    .mem_to_reg_idex(mem_to_reg_idex), 
    .reg_dst_idex(reg_dst_idex), 
    .reg_write_idex(reg_write_idex), 
    .jump_idex(jump_idex), 
    .branch_idex(branch_idex), 
    .zero(zero), 
    .alu_result(alu_result), 
    .rt_data_idex(rt_data_idex), 
    .rt_idex(rt_idex), 
    .rd_idex(rd_idex), 
    .signextend_idex(signextend_idex), 
    .writebackreg_exmem(writebackreg_exmem), 
    .alu_result_exmem(alu_result_exmem), 
    .signextend_exmem(signextend_exmem), 
    .rt_data_exmem(rt_data_exmem), 
    .mem_read_exmem(mem_read_exmem), 
    .mem_write_exmem(mem_write_exmem), 
    .mem_to_reg_exmem(mem_to_reg_exmem), 
    .reg_write_exmem(reg_write_exmem), 
    .jump_exmem(jump_exmem), 
    .branch_exmem(branch_exmem), 
    .zero_exmem(zero_exmem)
    );
	Datamem datamem (
    .address(alu_result_exmem), 
    .data_in(rt_data_exmem), 
    .data_out(data_out), 
    .clk(clk), 
    .we(mem_write_exmem),
		.rst(rst),
    .mem_read_exmem(mem_read_exmem)
    );
	 MEM_WB memwb (
    .clk(clk), 
    .rst(rst), 
    .mem_to_reg_exmem(mem_to_reg_exmem), 
    .reg_write_exmem(reg_write_exmem), 
    .memdata(data_out), 
    .alu_result_exmem(alu_result_exmem), 
    .writebackreg_exmem(writebackreg_exmem), 
    .writebackreg_memwb(writebackreg_memwb),  
    .reg_write_memwb(reg_write_memwb),
	 .data_towrite_memwb(data_towrite_memwb)
    );





endmodule
