module Connector (clock, reset, pctest, instructiontest);

	input clock, reset;
	output[31:0] pctest, instructiontest;
	
	wire[31:0] incomingInstruction, RegOutData1, RegOutData2, ALUOut, DMOut, ALUCtl, MemRead, MemWrite, RegWrite, PCIMwire; 
	wire[4:0] ALUOp, MUXOut1, MUXOut2, MUXOut3, MUXOut4;
	wire m1sel, m2sel, m3sel, m4sel, ALUZero;
	
	assign pctest = PCIMwire;
	assign instructiontest = incomingInstruction;
	
	PC pc(
		.clk(clock),
		.rst(reset),
		.PCin(MUXOut4),
		.PCout(PCIMwire)
	);
	
	InstructionMemory im(
		.address(PCIMwire),
		.clock(clock),
		.instruction(incomingInstruction)
	);
	
	RegFile rf(
		.Read1(incomingInstruction[25:21]),
		.Read2(incomingInstruction[20:16]),
		.WriteReg(MUXOut),
		.WriteData(MUXOut3), 
		.RegWrite(RegWrite), 
		.Data1(RegOutData1),
		.Data2(RegOutData2),
		.clock(clock),
	);
	
	Multiplexer m1 ( // MULTIPLEXER 2
		.a(incomingInstruction[20:16]),
		.b(incomingInstruction[15:11]),
		.s(m2sel), 
		.out(MUXOut1)
	);

	Multiplexer m2 ( // MULTIPLEXER 3
		.a(RegOutData2),
		.b((0000000000000000000000000000) & (incomingInstruction[15:0])),
		.s(m3sel), 
		.out(MUXOut2)
	);
	
	ALU a (
		.ALUctl(ALUCtl), 
		.ALUOut(ALUOut),
		.A(MUXOut2),
		.B(RegOutData1),
		.Zero(ALUZero) 
	);
	
	DataMemory dm (
		.address(ALUOut),
		.clock(clock), 
		.Data(RegOutData2), 
		.out(DMOut), 
		.readEnable(MemRead),
		.writeEnable(MemWrite) 
	);
	
	Multiplexer m3 ( // MULTIPLEXER 4
		.a(DMOut),
		.b(ALUOut),
		.s(m4sel), 
		.out(MUXOut3)
	);
	
	Multiplexer m4 ( // MULTIPLEXER 1
		.a(PCIMwire),
		.b(((0000000000000000000000000000) & (incomingInstruction[15:0]))+PCIMwire),
		.s(m1sel && ALUZero), 
		.out(MUXOut4)
	);	
	
	ALUControl( 
		.ALUOp(ALUOp), 
		.FuncCode(incomingInstruction[5:0]), 
		.ALUCtl(ALUCtl)
	);
	
	MainControl2(
		.OpCode(incomingInstruction[31:26]), 
		.RFwe(RegWrite), 
		.DMwe(MemWrite), 
		.DMre(MemRead), 
		.ALUS(ALUOp), 
		.s1(m1sel), 
		.s2(m2sel), 
		.s3(m3sel), 
		.s4(m4sel)
	);
	
	

endmodule