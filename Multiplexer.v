module Multiplexer(a, b, s, out);
	input [31:0] a, b;
	input s;
	output reg[31:0] out;

	always @(s) begin
		if (s == 0)
			out <= a;
		else
			out <= b;
	end
endmodule