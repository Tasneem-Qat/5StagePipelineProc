// Name:
// ID:

module Comparator5bit (equal, a, b);
input [4:0] a, b;
output equal;

wire w0, w1, w2, w3, w4, w5, w6;

XNOR x0(w0, a[0], b[0]);
XNOR x1(w1, a[1], b[1]);
XNOR x2(w2, a[2], b[2]);
XNOR x3(w3, a[3], b[3]);
XNOR x4(w4, a[4], b[4]);
AND3 a0(w5, w0, w1, w2);
AND3 a1(w6, w3, w4, 1'b1);
AND a2(equal, w5, w6);

endmodule 
//////////////////////////////////////////////////////

module ForwardingUnit(ForwardA, ForwardB, EXMEM_Rd, MEMWB_Rd, IDEX_Rs1, IDEX_Rs2, EXMEM_RegWrite, MEMWB_RegWrite);
input [4:0] EXMEM_Rd, MEMWB_Rd, IDEX_Rs1, IDEX_Rs2;
input EXMEM_RegWrite, MEMWB_RegWrite;
output [1:0] ForwardA, ForwardB;

wire w0, w1, w2, w3, w4, w5, w6, w7;

Comparator5bit comp0(w0, EXMEM_Rd, IDEX_Rs1);
OR8 or0(w1, EXMEM_Rd[0], EXMEM_Rd[1], EXMEM_Rd[2], EXMEM_Rd[3], EXMEM_Rd[4], 1'b0, 1'b0, 1'b0);
AND3 and0(ForwardA[0], w0, w1, EXMEM_RegWrite);

Comparator5bit comp1(w2, EXMEM_Rd, IDEX_Rs2);
AND3 and1(ForwardB[0], w2, w1, EXMEM_RegWrite);

Comparator5bit comp2(w3, MEMWB_Rd, IDEX_Rs1);
OR8 or1(w4, MEMWB_Rd[0], MEMWB_Rd[1], MEMWB_Rd[2], MEMWB_Rd[3], MEMWB_Rd[4], 1'b0, 1'b0, 1'b0);
INV inv0(w5, ForwardA[0]);
AND4 and2(ForwardA[1], w3, w4, MEMWB_RegWrite, w5);

Comparator5bit comp3(w6, MEMWB_Rd, IDEX_Rs2);
INV inv1(w7, ForwardB[0]);
AND4 and2(ForwardB[1], w6, w4, MEMWB_RegWrite, w7);

endmodule









