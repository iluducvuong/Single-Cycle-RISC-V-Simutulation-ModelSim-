module PCplus4(pc_out,pc_plus4_out);

//parameters
parameter PC_WIDTH_LENGTH=32;

//inputs
input [PC_WIDTH_LENGTH-1:0] pc_out;

//output
output [PC_WIDTH_LENGTH-1:0] pc_plus4_out;
reg [PC_WIDTH_LENGTH-1:0] pc_plus4_out;
//main function
always@(pc_out)
  pc_plus4_out = pc_out + 4;
endmodule
