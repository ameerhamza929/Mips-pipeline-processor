`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:59:38 05/18/2024 
// Design Name: 
// Module Name:    registermem 
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
module registermem(  input [4:0] rs,
    input [4:0] rt,
    input [4:0] writebackreg,
	 input rst,
    input regwrite,
	  input [31:0] data_towrite_memwb,
    input clk,
    output reg [31:0] RD1,
    output reg [31:0] RD2
	 );

    reg [31:0] memory[31:0];

    initial begin
        memory[0] = 32'b00000000000000000000000000000001; // add $1, $2, $3
        memory[1] = 32'b00000000000000000000000000000010;
        memory[2] = 32'b00000000000000000000000000000001;
		  memory[3] = 32'b00000000000000000000000000000100;
		  memory[4] = 32'b00000000000000000000000000001000;
		  memory[5] = 32'b00000000000000000000000000010000;
		  memory[6] = 32'b00000000000000000000000000100000;
		  memory[7] = 32'b00000000000000000000000001000000;
		  memory[8] = 32'b00000000000000000000000000001000;
		  memory[9] = 32'b00000000000000000000000000000010;
		  memory[10] = 32'b00000000000000000000000000000100;
		  memory[11] = 32'b00000000000000000000000000111000;
		  
    end
	
    always @(posedge clk ) begin
		
        if (regwrite) begin
					memory[writebackreg]<=data_towrite_memwb;
        end
	 end	 
				
		
   
    always @* begin
			if(rst) begin
				RD1=0;
		      RD2=0;
		    end
       else begin
            RD1 = memory[rs];
            RD2 = memory[rt];
		end		
    end

endmodule
