`timescale 1ps/1ps 
module Datapath(reset,clk);
input reset;
input clk;
wire [31:0] pc_in, pc_out, pc_plus4_out, inst, rsd, rs1_out,rs2_out, imm_out, alumux1_out, alumux2_out,
alu_out,dmem_out,wb_out;
wire BrEq,BrLT,PCSel,RegWEn,BrUn,ASel,BSel,MemRW;
wire [3:0] ALUSel;
wire [2:0] ImmSel,RSel;
wire [1:0] WBSel,WSel;

mux2 muxPC(PCSel,pc_plus4_out,alu_out,pc_in);
PC PC(clk,reset,pc_in,pc_out);
PCplus4 PCplus4(pc_out,pc_plus4_out);
IMEM IMEM(inst,pc_out);
Reg Reg(clk,RegWEn,inst,wb_out,rs1_out,rs2_out);
imm_gen imm_gen(inst[31:7], ImmSel, imm_out);
BranchComp BranchComp(rs1_out, rs2_out, BrUn, BrEq, BrLT);
mux2 alumux1(ASel,rs1_out,pc_out,alumux1_out);
mux2 alumux2(BSel,rs2_out,imm_out,alumux2_out);
ALU ALU(ALUSel, alumux1_out, alumux2_out, alu_out);
DMEM DMEM(dmem_out,rs2_out,alu_out,WSel,RSel,MemRW,clk);
mux3 wbmux(WBSel,dmem_out,alu_out,pc_plus4_out,wb_out);
Control_Unit CPU(inst,BrEq,BrLT,PCSel,ImmSel,RegWEn,BrUn,BSel,ASel,ALUSel,MemRW,RSel,WSel,WBSel);
endmodule

