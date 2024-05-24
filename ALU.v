`timescale 1ns / 1ps

module ALU(  input [31:0] rs_data_idex, rt_data_idex,
	 input alu_src_idex,	
	 input[31:0] signextend_idex,	 
    input [3:0] alu_control, // alu control
	 input rst,
	 input [1:0]forwardA,
	 input [1:0]forwardB,
	 input[31:0]data_towrite_memwb,
	 input[31:0]alu_result_exmem,
    output reg [31:0] alu_result,
	 output reg zero
    );
	 reg [31:0]input1;
	 reg [31:0]input2;
	 always @(*)begin
		case(forwardA)
			2'b00:input1=rs_data_idex;
			2'b01:input1=data_towrite_memwb;
			2'b10:input1=alu_result_exmem;
		endcase
		case(forwardB)
			2'b00:begin
				if(alu_src_idex)
					input2=signextend_idex;
				else
					input2=rt_data_idex;
			end	
			2'b01:input2=data_towrite_memwb;
			2'b10:input2=alu_result_exmem;
		endcase	
	 end
	 always@(*)begin
	 if(rst)begin
		alu_result=0;
		zero=0;
	 end
	 
	 else begin
		case(alu_control)
			 4'b0010: alu_result = input1 + input2;//add
          4'b0110: alu_result = input1 - input2;//sub
          4'b0000: alu_result = input1 & input2;//AND
          4'b0001: alu_result = input1 | input2;//OR
          4'b1100: alu_result = ~(input1 | input2);//NOR
          4'b1001: alu_result = input2 << input1 ;//sll
			default:alu_result=0;
		endcase
	 end
		 if (alu_result == 0) begin
            zero = 1'b1;
        end else begin
            zero = 1'b0;
        end
		  
	 end
		


endmodule
