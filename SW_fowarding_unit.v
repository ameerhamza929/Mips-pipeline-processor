`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:28 05/28/2024 
// Design Name: 
// Module Name:    SW_fowarding_unit 
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
module SW_fowarding_unit( 
	input forwarding,
	input reg_write_memwb,
	input mem_write_exmem ,
	input [4:0] writebackreg_memwb,
	input [4:0] writebackreg_exmem,
	output reg [1:0]forwardBE,
	output reg [1:0]forwardAE
    );
	 
	 always@(*)begin
			forwardBE=2'b00;
			if(forwarding)begin
				if (reg_write_memwb && mem_write_exmem &&(writebackreg_memwb != 5'b00000) && (writebackreg_memwb == writebackreg_exmem))
						forwardBE = 2'b10;
			end		
					
	 end
endmodule
