//Name:
//ID:

module Adder32bit (out, a, b); 
input [31:0] a, b; 
output [31:0] out; 

assign #50 out = a+b;

endmodule 
//////////////////////////////////////////////////////
module SignExtend (SEout, in, Iformat, LW, SW, BEQ, LUI, JAL, JALR);
input [31:0] in;
input Iformat, LW, SW, BEQ, JAL, JALR, LUI;
output [31:0] SEout;
reg [31:0] SEout;

always @(in)
begin
#3; 
if (Iformat || LW || JALR)
  SEout = {{20{in[31]}},in[31:20]};
else if (SW)
  SEout = {{20{in[31]}},in[31:25],in[11:7]};
else if (BEQ)
  SEout = {{21{in[31]}},in[7],in[30:25],in[11:8]};
else if (JAL)
  SEout = {{13{in[31]}},in[19:12],in[20],in[30:21]};
else if(LUI)                                                                    //Addition to prepare rd of LUI instruction: rd = {imm[31:12], 12’b0}
  SEout = {in[31:12], 12'b0};
end
endmodule 
//////////////////////////////////////////////////////
module Comparator32bit (equal, greater, a, b);                                  //Additional output signal greater for BGE instruction
input [31:0] a, b; 
output equal, greater; 
reg equal, greater;

always @(a or b)
#10 begin
if(a==b)
  equal = 1'b1;
else
  equal = 1'b0;

if(a>b)                                                                         //Additional logic conditions to check if a is greater than b
  greater = 1'b1;
else
  greater = 1'b0;
end

endmodule 
//////////////////////////////////////////////////////
module ShiftLeft32_by1(out, in); 
input [31:0] in; 
output [31:0] out; 

assign out = in<<1;

endmodule 
//////////////////////////////////////////////////////
module Mux_2_to_1_32bit(out, s, i1, i0); 
input [31:0] i1, i0; 
input s; 
output [31:0]out; 
reg [31:0] out;

 always @(s or i1 or i0)
 begin
 #6 case(s)
 1'b0 : out = i0;
 1'b1 : out = i1;
 default : out = 32'b0;
 endcase

 end

endmodule 
//////////////////////////////////////////////////////
module Mux_3_to_1_32bit(out, s, i2, i1, i0); 
 input [31:0] i2, i1, i0; 
 input [1:0]s; 
 output [31:0]out; 
 reg [31:0] out;

 always @(s or i2 or i1 or i0)
 begin
 #6 case(s)
 2'b00 : out = i0;
 2'b01 : out = i1;
 2'b10 : out = i2;
 default : out = 32'b0;
 endcase

 end
endmodule 





