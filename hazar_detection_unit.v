`timescale 1ns / 1ps

module hazard_detection_unit(
	input stalling,
	 input forwarding,
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rt_idex,
	 input [4:0] rd_idex,
	 input reg_write_exmem,
	 input reg_write_memwb,
	 input [4:0] writebackreg_exmem,
	 input mem_write_idex,
	 input [4:0]writebackreg_memwb,
	 input [4:0]rs_idex,
    input mem_read_idex,
    input branch,
    input branchtaken,
	 input reg_write_idex,
	 input jump,
    output reg pc_write,
    output reg ifid_write,
    output reg control_mux,
    output reg ifid_flush
);
    always @(*) begin
	 
        // Default values
        pc_write = 1;
        ifid_write = 1;
        control_mux = 1;
        ifid_flush = 0;
		if(stalling)begin
			  // Load-use hazard detection
			  if (mem_read_idex && ((rt_idex == rs) || (rt_idex == rt))) begin
					pc_write = 0;
					ifid_write = 0;
					control_mux = 0; // Select NOP for control signals
			  end

			  // Branch taken hazard detection
			  if (branch && branchtaken && !((rd_idex == rs) || (rd_idex == rt))) begin
					ifid_write = 0;
					ifid_flush = 1;
					control_mux = 0;
			  end

			  // Branch with dependency hazard detection
			  if (branch && reg_write_idex && ((rd_idex == rs) || (rd_idex == rt))) begin
					pc_write = 0;
					ifid_write = 0;
					control_mux = 0;
			  end
			  if (branch && mem_read_idex && ((rt_idex == rs) || (rt_idex == rt))) begin
					pc_write = 0;
					ifid_write = 0;
					control_mux = 0;
			  end
			  
				if (branch && branchtaken && mem_read_idex && !((rt_idex == rs) || (rt_idex == rt))) begin
					ifid_write = 0;
					ifid_flush = 1;
					control_mux = 0;
			  end
			  if(!forwarding)begin
					if (reg_write_exmem  &&(writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rs))begin
						pc_write = 0;
						ifid_write = 0;
						control_mux = 0;
					end	
					if (reg_write_exmem && !(mem_write_idex) &&(writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rt))begin
						pc_write = 0;
						ifid_write = 0;
						control_mux = 0;
					end
					if (reg_write_memwb && (writebackreg_memwb != 5'b00000) && !(reg_write_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rs_idex)) && (writebackreg_memwb == rs))begin
						pc_write = 0;
						ifid_write = 0;
						control_mux = 0;
					end	
					if (reg_write_memwb && (writebackreg_memwb != 5'b00000) && !(reg_write_exmem && (writebackreg_exmem != 5'b00000) && (writebackreg_exmem == rt_idex)) && (writebackreg_memwb == rt))begin
						pc_write = 0;
						ifid_write = 0;
						control_mux = 0;
					end
					if(reg_write_idex)begin
						if(mem_read_idex && (rt_idex==rs)||(rt_idex==rt) )begin
							pc_write = 0;
							ifid_write = 0;
							control_mux = 0;
						end
						if( !(mem_read_idex)&&((rd_idex==rs)||(rd_idex==rt)) )begin
							pc_write = 0;
							ifid_write = 0;
							control_mux = 0;
						end
					end	
			  end
		 end 
		 else begin
			if(branch&&branchtaken)begin
				ifid_write = 0;
            ifid_flush = 1;
            control_mux = 0;
			end
		 
		 end
		  if(jump)begin
				ifid_write = 0;
            ifid_flush = 1;
            control_mux = 0;
		  end
    end

endmodule
