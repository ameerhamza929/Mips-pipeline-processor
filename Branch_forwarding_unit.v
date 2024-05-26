`timescale 1ns / 1ps


module Branch_forwarding_unit( input [4:0] writebackreg_exmem,
input reg_write_exmem,
input branch,
input mem_read_exmem,
input reg_write_memwb,
input [4:0] writebackreg_memwb,
input [4:0]rs_idex,
input [4:0]rt_idex,
input [4:0]rs,
input [4:0]rt,
output reg [1:0] forwardAD,
output reg [1:0] forwardBD
    );
	 
	 always @(*) begin
        // Default values to prevent latches
        forwardAD = 2'b00;
        forwardBD = 2'b00;
		 if (branch && reg_write_exmem && !(mem_read_exmem) && (writebackreg_exmem != 5'b00000)) begin
            if (writebackreg_exmem == rs) 
                forwardAD = 2'b01;
            if (writebackreg_exmem == rt) 
                forwardBD = 2'b01;
        end
		  if (branch&& mem_read_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rs))
					forwardAD = 2'b10;
		  if (branch&& mem_read_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rt))
					forwardBD = 2'b10;	

			if (reg_write_memwb && (writebackreg_memwb != 5'b00000) && !(reg_write_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rs_idex)) && (writebackreg_memwb == rs))
            forwardAD = 2'b11;
        if (reg_write_memwb && (writebackreg_memwb != 5'b00000) && !(reg_write_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rt_idex)) && (writebackreg_memwb == rt))
            forwardBD = 2'b11;
	 end

endmodule
