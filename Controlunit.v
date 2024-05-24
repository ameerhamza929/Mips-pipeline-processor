`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:17:40 05/18/2024 
// Design Name: 
// Module Name:    Controlunit 
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
module Controlunit(
    input [5:0] opcode, // 6-bit opcode
    input rst, clk,
    output reg reg_dst, reg_write, alu_src, mem_read, mem_write, pc_src, jump, branch,
    output reg mem_to_reg,
    output reg [1:0] alu_op
);

    // Always block triggered by the clock or reset
    always @(*) begin
        if (rst) begin
            // Reset all outputs to 0
            reg_dst     = 1'b0;
            reg_write   = 1'b0;
            alu_src     = 1'b0;
            mem_read    = 1'b0;
            mem_write   = 1'b0;
            mem_to_reg  = 1'b0;
            pc_src      = 1'b0;
            jump        = 1'b0;
            branch      = 1'b0;
            alu_op      = 2'b00;
        end else begin
            // Default values
            reg_dst     = 1'b0;
            reg_write   = 1'b0;
            alu_src     = 1'b0;
            mem_read    = 1'b0;
            mem_write   = 1'b0;
            mem_to_reg  = 1'b0;
            pc_src      = 1'b0;
            jump        = 1'b0;
            branch      = 1'b0;
            alu_op      = 2'b00;

            // Opcode decoding
            case (opcode)
                6'b000001: begin // R-type instructions
                    reg_dst     = 1'b1;
                    reg_write   = 1'b1; 
                    alu_op      = 2'b10;
                    mem_to_reg  = 1'b1;
                end
                6'b100011: begin // LW
                    reg_write   = 1'b1;
                    alu_src     = 1'b1;
                    mem_read    = 1'b1;
                    mem_to_reg  = 1'b1;
                    alu_op      = 2'b11;
                end
                6'b101011: begin // SW
                    alu_src     = 1'b1;
                    mem_write   = 1'b1;
                    alu_op      = 2'b11; // ADD
                end
                6'b000100: begin // BEQ
                    branch      = 1'b1;
                    alu_op      = 2'b01;
                end
                6'b001100: begin // Jump
                    jump        = 1'b1;
                end
            endcase
        end
    end

endmodule
