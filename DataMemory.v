module DataMemory(address, clock, Data, out, readEnable, writeEnable);

	input [31:0] address, Data;
	input clock, readEnable, writeEnable;
	output reg[31:0] out;
	
	reg[31:0] DM [31:0];
	
	always begin @(posedge clock) if (readEnable && writeEnable)
		out=DM[address];
	end
	
	always begin @(negedge clock) if (writeEnable && readEnable)
		DM[address]= Data;
	end
	
endmodule