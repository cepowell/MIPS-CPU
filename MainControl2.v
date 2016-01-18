module MainControl2 (OpCode, RFwe, DMwe, DMre, ALUS, s1, s2, s3, s4);
	input [5:0] OpCode;
	output reg[1:0] ALUS;
	output reg RFwe, DMwe, DMre, s1, s2, s3, s4;
	
	always @(OpCode) begin	
		if (OpCode == 0) begin
			s1<=0;
			s2<=1;
			s3<=0;
			s4<=0;
			RFwe<=1;
			DMwe<=0;
			DMre<=0;
			ALUS<=2;
		end
		else if (OpCode == 35) begin
			s1<= 0;
			s2<=0;
			s3<=1;
			s4<=1;
			RFwe<=1;
			DMwe<=0;
			DMre<=1;
			ALUS<=0;
		end
		else if (OpCode == 43) begin
			s1<=0;
			s3<=1;
			RFwe<=0;
			DMwe<=1;
			DMre<=0;
			ALUS<=0;
		end
		else if (OpCode == 4) begin
			s1<=1;
			s3<=0;
			RFwe<=0;
			DMwe<=0;
			DMre<=0;
			ALUS<=1;
		end
	end
endmodule
 		
		