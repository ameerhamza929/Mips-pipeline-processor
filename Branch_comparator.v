`timescale 1ns / 1ps

module Branch_comparator(input rst,input [31:0]rs_data,
input [31:0]rt_data,
input [31:0]data_out,
input [1:0]forwardAD,
input [1:0]forwardBD,
input [31:0]alu_result_exmem,
input [31:0] data_towrite_memwb,
output reg branchtaken
    );
	reg [31:0]input1;
	reg [31:0]input2;
	reg [31:0]result;
	always@(*)begin
		case(forwardAD)
			2'b00:input1=rs_data;
			2'b01:input1=alu_result_exmem;
			2'b10:input1=data_out;
			2'b11:input1=data_towrite_memwb;
	   endcase
		case(forwardBD)
			2'b00:input2=rt_data;
			2'b01:input2=alu_result_exmem;
			2'b10:input2=data_out;
			2'b11:input2=data_towrite_memwb;
		endcase	
	end
	
	always@(*)begin
		result=input1-input2;
		 if (result == 0) begin
             branchtaken=1'b1;
        end else begin
            branchtaken= 1'b0;
        end
	end
	
endmodule
