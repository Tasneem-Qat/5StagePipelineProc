//Name:
//ID:

module Decoder2to4 (out, in, enable); 
input enable; 
input [1:0]in; 
output [3:0]out; 

wire w0, w1;

INV inv0(w0, in[0]);
INV inv1(w1, in[1]);

AND3 a0(out[0], w1, w0, enable);
AND3 a1(out[1], w1, in[0], enable);
AND3 a2(out[2], in[1], w0, enable);
AND3 a3(out[3], in[1], in[0], enable);

endmodule 

///////////////////////////////////////////////////////////////////

module Decoder3to8 (out, in, enable); 
input enable; 
input [2:0]in; 
output [7:0]out; 

wire w0,w1,w2;

INV inv0(w0, in[0]);
INV inv1(w1, in[1]);
INV inv2(w2, in[2]);

AND4 a0(out[0], w2,w1,w0, enable);
AND4 a1(out[1], w2, w1, in[0], enable);
AND4 a2(out[2], w2, in[1], w0, enable);
AND4 a3(out[3], w2, in[1], in[0], enable);
AND4 a4(out[4], in[2], w1, w0, enable);
AND4 a5(out[5], in[2], w1, in[0], enable);
AND4 a6(out[6], in[2], in[1], w0, enable);
AND4 a7(out[7], in[2], in[1], in[0], enable);


endmodule 

///////////////////////////////////////////////////////////////////

module Decoder5to32 (out, in, enable); 
input enable; 
input [4:0]in; 
output [31:0]out; 

wire [3:0] en;

Decoder2to4 dec0(en[3:0], in[4:3], enable);
 
Decoder3to8 dec10(out[7:0], in[2:0], en[0]); 
Decoder3to8 dec11(out[15:8], in[2:0], en[1]); 
Decoder3to8 dec12(out[23:16], in[2:0], en[2]); 
Decoder3to8 dec13(out[31:24], in[2:0], en[3]); 

endmodule 

///////////////////////////////////////////////////////////////////

module RegFile(readdata1 ,readdata2, readreg1, readreg2, writedata, writereg, regwrite, clk, reset); 
input regwrite, clk, reset; 
input [4:0]readreg1, readreg2, writereg; 
input [31:0]writedata; 
output [31:0]readdata1, readdata2; 
wire [31:0] regen ,w31, w30, w29, w28, w27, w26, w25, w24, w23, w22, w21, w20, w19, w18, w17, w16, w15, w14, w13, w12, w11, w10, w9, w8, w7, w6, w5, w4, w3, w2, w1, w0;

Decoder5to32 dec(regen, writereg, regwrite);

REG32negclk X0(w0, writedata, clk, reset, 1'b0);
REG32negclk X1(w1, writedata, clk, reset, regen[1]);
REG32negclk X2(w2, writedata, clk, reset, regen[2]);
REG32negclk X3(w3, writedata, clk, reset, regen[3]);
REG32negclk X4(w4, writedata, clk, reset, regen[4]);
REG32negclk X5(w5, writedata, clk, reset, regen[5]);
REG32negclk X6(w6, writedata, clk, reset, regen[6]);
REG32negclk X7(w7, writedata, clk, reset, regen[7]);
REG32negclk X8(w8, writedata, clk, reset, regen[8]);
REG32negclk X9(w9, writedata, clk, reset, regen[9]);
REG32negclk X10(w10, writedata, clk, reset, regen[10]);
REG32negclk X11(w11, writedata, clk, reset, regen[11]);
REG32negclk X12(w12, writedata, clk, reset, regen[12]);
REG32negclk X13(w13, writedata, clk, reset, regen[13]);
REG32negclk X14(w14, writedata, clk, reset, regen[14]);
REG32negclk X15(w15, writedata, clk, reset, regen[15]);
REG32negclk X16(w16, writedata, clk, reset, regen[16]);
REG32negclk X17(w17, writedata, clk, reset, regen[17]);
REG32negclk X18(w18, writedata, clk, reset, regen[18]);
REG32negclk X19(w19, writedata, clk, reset, regen[19]);
REG32negclk X20(w20, writedata, clk, reset, regen[20]);
REG32negclk X21(w21, writedata, clk, reset, regen[21]);
REG32negclk X22(w22, writedata, clk, reset, regen[22]);
REG32negclk X23(w23, writedata, clk, reset, regen[23]);
REG32negclk X24(w24, writedata, clk, reset, regen[24]);
REG32negclk X25(w25, writedata, clk, reset, regen[25]);
REG32negclk X26(w26, writedata, clk, reset, regen[26]);
REG32negclk X27(w27, writedata, clk, reset, regen[27]);
REG32negclk X28(w28, writedata, clk, reset, regen[28]);
REG32negclk X29(w29, writedata, clk, reset, regen[29]);
REG32negclk X30(w30, writedata, clk, reset, regen[30]);
REG32negclk X31(w31, writedata, clk, reset, regen[31]);

Mux_32_to_1_32bit mux1(readdata1, readreg1, {w31, w30, w29, w28, w27, w26, w25, w24, w23, w22, w21, w20, w19, w18, w17, w16, w15, w14, w13, w12, w11, w10, w9, w8, w7, w6, w5, w4, w3, w2, w1, w0}); 
Mux_32_to_1_32bit mux2(readdata2, readreg2, {w31, w30, w29, w28, w27, w26, w25, w24, w23, w22, w21, w20, w19, w18, w17, w16, w15, w14, w13, w12, w11, w10, w9, w8, w7, w6, w5, w4, w3, w2, w1, w0});
 
endmodule 







