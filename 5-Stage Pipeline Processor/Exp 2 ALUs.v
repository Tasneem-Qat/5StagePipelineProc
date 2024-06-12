//Name:
//ID:

module ALU_1(result, sum, Cout, Cin, a, b, less, m); 
output result, sum, Cout; 
input Cin, a, b, less; 
input [2:0] m; 

wire w0, w1, w2, w4, w5, x;

OR o1(w0, a, b);
AND a1(w1, a, b);
XOR xor1(w2, a, b);
XOR xor2(x, m[2], b);
FullAdder fa(Cout, sum, x, a, Cin); 
NOR nor1(w4, a, b);
NAND nand1(w5, a, b);
Mux_8_to_1 mux(result, m, {sum, less, w5, w4, sum, w2, w1, w0});

endmodule 

///////////////////////////////////////////////////////////////////

module ALU_8(result, sum, Cout, Cin, a, b, less, m);
  output [7:0]result, sum;
  output Cout;
  input  Cin;
  input  [7:0]a, b, less;
  input  [2:0] m;

  wire [6:0] cout;

ALU_1 alu0(result[0], sum[0], cout[0], Cin, a[0], b[0], less[0], m); 
ALU_1 alu1(result[1], sum[1], cout[1], cout[0], a[1], b[1], less[1], m);
ALU_1 alu2(result[2], sum[2], cout[2], cout[1], a[2], b[2], less[2], m);
ALU_1 alu3(result[3], sum[3], cout[3], cout[2], a[3], b[3], less[3], m);
ALU_1 alu4(result[4], sum[4], cout[4], cout[3], a[4], b[4], less[4], m);
ALU_1 alu5(result[5], sum[5], cout[5], cout[4], a[5], b[5], less[5], m);
ALU_1 alu6(result[6], sum[6], cout[6], cout[5], a[6], b[6], less[6], m);
ALU_1 alu7(result[7], sum[7], Cout, cout[6], a[7], b[7], less[7], m);

endmodule

///////////////////////////////////////////////////////////////////

module ALU_32(result, a, b, m); 
output [31:0]result; 
input [31:0]a, b; 
input [2:0] m; 

wire [31:0] sum;
wire [3:0] cout;

ALU_8 alu0(result[7:0], sum[7:0], cout[0], m[2], a[7:0], b[7:0], {7'b0, sum[31]}, m);
ALU_8 alu1(result[15:8], sum[15:8], cout[1], cout[0], a[15:8], b[15:8], 8'b0, m);
ALU_8 alu2(result[23:16], sum[23:16], cout[2], cout[1], a[23:16], b[23:16], 8'b0, m);
ALU_8 alu3(result[31:24], sum[31:24], cout[3], cout[2], a[31:24], b[31:24], 8'b0, m);


endmodule 

///////////////////////////////////////////////////////////////////
