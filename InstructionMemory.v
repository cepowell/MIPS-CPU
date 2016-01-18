module InstructionMemory(address, clock, instruction);
	
	input[31:0] address;
	input clock;
	output reg[31:0] instruction;
	
	reg[31:0] mem [255:0];
	
	initial begin	
		$readmemh("test.txt", mem);
		//mem[0] = 00221820;
		//mem[1] = 45683382;
		//mem[2] = 95453833;
		//mem[3] = 54328345;
		
		//mem[0]=127;
	end
	always @(posedge clock) begin
		instruction = mem[address[31:0]];
	end
endmodule
