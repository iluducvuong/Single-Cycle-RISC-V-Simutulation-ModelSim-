`timescale 1ps/1ps 
module PC(clk,reset,
	  pc_in,
          pc_out);

//parameter
parameter PC_WIDTH_LENGTH=32;


//inputs
input clk, reset;
reg soft_reset;
input [PC_WIDTH_LENGTH-1:0] pc_in;

initial soft_reset=1;

//outputs
output reg [PC_WIDTH_LENGTH-1:0] pc_out;


//main function
always@(posedge clk) begin
   if (reset==1) soft_reset=1;
   if (soft_reset==1)
        begin
           pc_out = 32'b00000000_00000000_00000000_00000000;
	   soft_reset=0;
        end
   else 
        begin
           pc_out=pc_in;
        end 
end
endmodule
