module RegFile (Read1, Read2, WriteReg, WriteData, RegWrite, Data1, Data2, clock);
	input [5:0] Read1, Read2, WriteReg;
	input [31:0] WriteData;
	input RegWrite, clock;
	
	output [31:0] Data1, Data2;
	reg[31:0] RF [31:0];
	
	assign Data1=RF[Read1];
	assign Data2=RF[Read2];
	
	always begin @(posedge clock) if (RegWrite) RF[WriteReg] <= WriteData;
	end
endmodule