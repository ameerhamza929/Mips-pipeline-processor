`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:09:41 05/18/2024 
// Design Name: 
// Module Name:    pc 
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
module pc( jump_address, pc_out, jump,pc_write,branch ,branchtaken,   clk, rst); 
		
		 
		
		input clk, rst, jump,pc_write,branch,branchtaken;
		input [31:0] jump_address;
		output reg [31:0] pc_out; 
		
		always @(posedge clk or posedge rst)
		begin
			if (rst)
				pc_out <=0; 
			else begin
				if(pc_write)begin
					if (jump) pc_out <= jump_address;
					else if(branch && branchtaken)pc_out <=jump_address;
				
					else 
						pc_out <= pc_out + 1; 
				end		
			end
		end


endmodule
