`timescale 1ns / 1ps

module Controlunit(
    input [5:0] opcode, // 6-bit opcode
    input rst, clk,
	 input branchtaken,
    output reg reg_dst, reg_write, alu_src, mem_read, mem_write, pc_src, jump, branch,
    output reg mem_to_reg,
    output reg [2:0] alu_op
	 
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
            alu_op      = 3'b000;
			
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
            alu_op      = 3'b000;
				
            // Opcode decoding
            case (opcode)
                6'b000001: begin // R-type instructions
                    reg_dst     = 1'b1;
                    reg_write   = 1'b1; 
                    alu_op      = 3'b010;
                    mem_to_reg  = 1'b1;
                end
                6'b100011: begin // LW
                    reg_write   = 1'b1;
                    alu_src     = 1'b1;
                    mem_read    = 1'b1;
                    mem_to_reg  = 1'b0;
                    alu_op      = 3'b011;
                end
                6'b101011: begin // SW
                    alu_src     = 1'b1;
                    mem_write   = 1'b1;
                    alu_op      = 3'b011; // ADD
                end
                6'b000100: begin // BEQ
                    branch      = 1'b1;
                    alu_op      = 3'b001;
						 
                end
                6'b001100: begin // Jump
                    jump        = 1'b1;
					 end	  
					 6'b111000: begin   //slt
						  reg_dst     = 1'b1;
                    reg_write   = 1'b1; 
                    alu_op      = 3'b100;
                    mem_to_reg  = 1'b1;
					 end
					 6'b111010: begin   //sll
						  reg_dst     = 1'b1;
                    reg_write   = 1'b1; 
                    alu_op      = 3'b110;
                    mem_to_reg  = 1'b1;
					 end
					 
					  6'b101000: begin   //addi
                    reg_write   = 1'b1; 
                    alu_op      = 3'b011;
                    mem_to_reg  = 1'b1;
					 end
                
            endcase
        end
    end

endmodule
