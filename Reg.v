`timescale 1ps/1ps
module Reg(clk,RegWEn,inst,DataD,DataA,DataB);

input clk,RegWEn;
input [31:0] inst,DataD;

output [31:0] DataA,DataB;

reg [31:0] data[0:31];
wire [4:0] AddrA,AddrB,AddrD;

integer k;

assign AddrD = inst[11:7];
assign AddrA = inst[19:15];
assign AddrB = inst[24:20];
assign DataA = |AddrA ? data[AddrA] : 0 ;
assign DataB = |AddrB ? data[AddrB] : 0 ;

initial begin
	for (k=0;k<32;k=k+1) data[k]=32'b0; 
end

always @(posedge clk)
begin
	data[0]=32'b0;
	if (RegWEn) data[AddrD] <= DataD;
end
endmodule
