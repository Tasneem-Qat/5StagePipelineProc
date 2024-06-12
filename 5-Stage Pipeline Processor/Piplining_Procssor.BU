//Name:
//ID:

module PipelinedProcessor(clk, reset, enable);
input clk, reset, enable; 

wire [31:0] PCout, SEout, inst, PC4, PCin, writedata, readdata, readdata1, readdata2, ALUout, ALUinA, ALUin, ShiftOut, BTA, muxOut, readdata1X, readdata2X, SEoutX, mux1out;
wire [31:0] instF, PCoutF, PC4F, ALUoutM, readdata2M, readdataW, ALUoutW; 
wire [31:0] PC4X, PC4M, PC4W, muxAout, muxBout;
wire [2:0] aluop, aluopX;
wire [1:0] memtoreg, pcsrc, memtoregX, memtoregM, memtoregW;
wire [1:0] pcsrcX, ForwardA, ForwardB;
wire [4:0] writereg, readreg1X, readreg2X, writeregX, writeregM;
wire Flush1, Flush2, memtoregAND, alusrc, regwrite, memread, memwrite, branch, Iformat, LW, SW, BEQ, BGE, LUI, LUIX, JAL, JALR, equal, greater, branchsel, branchsel2, greaterORequal, memwriteX, memreadX, alusrcX, mux1sel, regwriteX, regwriteM, memwriteM, memreadM, regwriteW;


 //ProgramCounter (Q, D, clk, reset, enable);
   ProgramCounter PC(PCoutF, PCin, clk, reset, enable);

 //Instruction_Memory(PC, instruction);
   Instruction_Memory IM (PCoutF, instF); 

 //Adder32bit (out, a, b);  for PC + 4
   Adder32bit PCadd4 (PC4F, PCoutF, 32'b0100);

 //IFID (Q, D, clk, reset, enable);
   IFID ifid({PC4, PCout, inst}, {PC4F, PCoutF, instF}, clk, Flush1, enable);

 //OR3 (out, in1, in2, in3);
   OR3 flush_1(Flush1, reset, mux1sel, pcsrcX[1]);

 //ControlUnit(aluop, …, JALR, opcode, func3, func7); 
   ControlUnit CU (aluop, alusrc, pcsrc, memtoreg, regwrite ,memread, memwrite, branch, Iformat, LW, SW, BEQ, BGE, LUI, JAL, JALR, inst[6:0], inst[14:12],inst[31:25]); 
     
 //SignExtend SE (SEout, inst, Iformat, LW, SW, BEQ, JAL, JALR);
   SignExtend SE(SEout, inst, Iformat, LW, SW, BEQ, LUI, JAL, JALR);                                          //NEW IMPLEMENTATION for sign extend unit

 //RegFile(readdata1 ,readdata2, ………, clk, reset);
   RegFile RF (readdata1 ,readdata2, inst[19:15], inst[24:20], writedata,writereg , regwriteW, clk, reset);

 //IDEX (Q, D, clk, reset, enable);
   IDEX idex({PC4X[31:0], pcsrcX[1], LUIX, regwriteX, memtoregX[1:0], memwriteX, memreadX, aluopX[2:0], alusrcX, readdata1X[31:0], readdata2X[31:0], SEoutX[31:0], readreg2X[4:0], readreg1X[4:0], writeregX[4:0]}, {PC4[31:0], pcsrc[1], LUI ,regwrite, memtoreg[1:0], memwrite, memread, aluop[2:0], alusrc, readdata1[31:0], readdata2[31:0], SEout[31:0], inst[24:20], inst[19:15], inst[11:7]}, clk, Flush2, enable);
  
 //OR (out, in1, in2);
   OR flush_2(Flush2, reset, pcsrcX[1]);

 //ForwardingUnit(ForwardA, ForwardB, EXMEM_Rd, MEMWB_Rd, IDEX_Rs1, IDEX_Rs2, EXMEM_RegWrite, MEMWB_RegWrite);
   ForwardingUnit FU(ForwardA, ForwardB, writeregM, writereg, readreg1X, readreg2X, regwriteM, regwriteW);

 //Mux_3_to_1_32bit(out, s, i2, i1, i0);
   Mux_3_to_1_32bit muxforwardA(muxAout, ForwardA, writedata, ALUoutM, readdata1X);
   Mux_3_to_1_32bit muxforwardB(muxBout, ForwardB, writedata, ALUoutM, readdata2X);
  
 //Mux_2_to_1_32bit(out, s, i1, i0);                                                                                    //ADDITIONAL MUX FOR ALU INPUT A
   Mux_2_to_1_32bit ALU_A (ALUinA, LUIX, 32'b0, muxAout); 

 //Mux_2_to_1_32bit(out, s, i1, i0); for the input b of the ALU
   Mux_2_to_1_32bit ALU_B (ALUin, alusrcX, SEoutX, muxBout); 

 //ALU_32(result, a, b, m);                                                                                             //ALU NOW TAKES ALUinA AND ALUin(B)
   ALU_32 ALU (ALUout , ALUinA, ALUin , aluopX);

 //ShiftLeft32_by1(out, in);
   ShiftLeft32_by1 shifter (ShiftOut, SEout);

 //Adder32bit (out, a, b); branch/jal target Address
   Adder32bit BTAddress (BTA, PCout, ShiftOut); 

 //Comparator32bit (equal, a, b);                                                                     // NEW IMPLEMENTATION: Comparator32bit (equal, greater, a, b);
   Comparator32bit comp (equal, greater, readdata1, readdata2);

 //AND (out, in1, in2);
   AND andbranch (branchsel, branch, equal);

 //AND (out, in1, in2);                                                                               //ADDITION FOR FLUSH LOGIC
   AND andbranch2(branchsel2, BGE, greater);

 //OR (out, in1, in2);                                                                                //ADDITION FOR FLUSH LOGIC
   OR branchselOR(greaterORequal, branchsel, branchsel2);

 //OR (out, in1, in2);
   OR mux1select(mux1sel, greaterORequal, pcsrc[0]);                                                  //Now takes PCSRC[0] OR greaterORequal instead of just branchANDequal

 //Mux_2_to_1_32bit(out, s, i1, i0);
   Mux_2_to_1_32bit mux1(mux1out, mux1sel, BTA, PC4F);

 //Mux_2_to_1_32bit(out, s, i1, i0);
   Mux_2_to_1_32bit mux2 (PCin, pcsrcX[1], ALUout, mux1out);

 //EXMEM (Q, D, clk, reset, enable);
   EXMEM exmem({PC4M[31:0], regwriteM, memtoregM[1:0], memwriteM, memreadM, ALUoutM[31:0], readdata2M[31:0], writeregM[4:0]}, {PC4X[31:0], regwriteX, memtoregX[1:0], memwriteX, memreadX, ALUout[31:0], muxBout, writeregX[4:0]}, clk, reset, enable);

 //Data_Memory(readdata , address, ……., clk );
   Data_Memory DM(readdata , ALUoutM, readdata2M , memwriteM , memreadM , clk);

 //MEMWB (Q, D, clk, reset, enable)
   MEMWB memwb({PC4W[31:0], regwriteW, memtoregW[1:0],readdataW[31:0], ALUoutW[31:0], writereg[4:0]}, {PC4M[31:0], regwriteM, memtoregM[1:0],readdata, ALUoutM[31:0], writeregM[4:0]}, clk, reset, enable);

 //Mux_3_to_1_32bit(out, s, i2, i1, i0);
   Mux_3_to_1_32bit muxFinal (writedata, memtoregW, PC4W, readdataW, ALUoutW);

endmodule


