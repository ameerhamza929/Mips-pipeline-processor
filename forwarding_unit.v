`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:20 05/23/2024 
// Design Name: 
// Module Name:    forwarding_unit 
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
module forwarding_unit (
    input [4:0] writebackreg_memwb,
    input reg_write_memwb,
    input reg_write_exmem,
    input [4:0] writebackreg_exmem,
    input [4:0] rt_idex,
    input [4:0] rs_idex,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);
    always @(*) begin
        // Default values to prevent latches
        forwardA = 2'b00;
        forwardB = 2'b00;

        // EX Hazard
        if (reg_write_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rs_idex))
            forwardA = 2'b10;
        if (reg_write_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rt_idex))
            forwardB = 2'b10;

        // MEM Hazard
        if (reg_write_memwb && (writebackreg_memwb != 5'b00000) && !(reg_write_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rs_idex)) && (writebackreg_memwb == rs_idex))
            forwardA = 2'b01;
        if (reg_write_memwb && (writebackreg_memwb != 5'b00000) && !(reg_write_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rt_idex)) && (writebackreg_memwb == rt_idex))
            forwardB = 2'b01;
    end
endmodule
