module ControlUnit(aluop, alusrc, pcsrc, memtoreg, regwrite ,memread, memwrite, branch, Iformat, LW, SW, BEQ, BGE, LUI, JAL, JALR, opcode, func3, func7);
  input [6:0] opcode, func7; 
  input [2:0] func3;
  output [2:0] aluop;
  output [1:0] memtoreg, pcsrc;
  output alusrc, regwrite, memread, memwrite, branch, Iformat, LW, SW, BEQ, BGE, LUI, JAL, JALR;		
  wire Rformat;

  assign #2 LW = ~opcode[6] & ~opcode[5] & ~opcode[4];
  assign #2 SW = ~opcode[6] & opcode[5] & ~opcode[4];
  assign #2 Iformat = ~opcode[6] & ~opcode[5] & opcode[4];
  assign #2 Rformat = ~opcode[6] & opcode[5] & opcode[4] & ~opcode[2];                        //Addition of ~opcode[2]
  assign #2 BEQ = opcode[6] & ~opcode[2];
  assign #2 JAL = opcode[6] & opcode[3];
  assign #2 JALR = opcode[6] & ~opcode[3] & opcode[2];
  assign #2 BGE = opcode[6] & ~opcode[2];                                                     //Addition: new assign statement for new output BGE
  assign #2 LUI = opcode[2] & ~opcode[6];                                                     //Addition: new assign statement for new output LUI

  assign #4 memread = LW;
  assign #4 memwrite = SW;
  assign #4 branch = BEQ | BGE;                                                               //Addition of LUI
  assign #4 alusrc = Iformat | LW | SW | JALR | LUI;                                          //Addition of LUI
  assign #4 regwrite = Rformat | Iformat | LW | JAL | JALR | LUI;
  assign #4 memtoreg[1] = JAL | JALR;
  assign #4 memtoreg[0] = LW;
  assign #4 pcsrc[1] = JALR;
  assign #4 pcsrc[0] = JAL;
  assign #4 aluop[2] = (Rformat & (func7[5]|(~func3[2]&func3[1]))) | (Iformat & (~func3[2]&func3[1]));
  //change in aluop[1] below, LUI added to logic condition
  assign #4 aluop[1] = (Rformat & (func7[5]|(~func3[2]&func3[1])|(~func3[2]&~func3[1]&~func3[0])|(func3[2]&~func3[1]))) | (Iformat & ((~func3[2]&func3[1])|(~func3[2]&~func3[1]&~func3[0])|(func3[2]&~func3[1]))) | LW | SW | JALR | LUI;
  assign #4 aluop[0] = (Rformat & (func7[5]|(~func3[2]&~func3[1])|(func3[1]&func3[0]))) | (Iformat & ((~func3[2]&~func3[1])|(func3[1]&func3[0]))) | LW | SW | JALR;


endmodule
