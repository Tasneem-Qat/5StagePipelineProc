module Instruction_Memory(PC, instruction);
	input [31:0] PC; 
	output [31:0] instruction; 
	reg [31:0] instruction; 
	reg [31:0] IM [255:0]; 
	initial begin 
		 IM[0] = 32'h00C02083;
		 IM[1] = 32'h00402103;
		 IM[2] = 32'h06402183;
		 IM[3] = 32'h000052B7;
		 IM[4] = 32'h00518333;
               IM[5] = 32'hFFFFF2B7;
		 IM[6] = 32'h00300493;
		 IM[7] = 32'h80028393;
		 IM[8] = 32'h00618463;
		 IM[9] = 32'h00335863;
		 IM[10] = 32'h01900393;
               IM[11] = 32'h0063ABA3;
		 IM[12] = 32'h03C000E7;
		 IM[13] = 32'h0020C033;
		 IM[14] = 32'hFE90D8E3;
		 IM[15] = 32'h03002283;


	end 
	always @ (PC ) 
		#15 instruction = IM[PC>>2]; 
endmodule 
