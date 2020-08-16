module BranchComp (rs1_out, rs2_out, BrUn, BrEq, BrLT);
input [31:0] rs1_out, rs2_out;
input BrUn;
output reg BrEq, BrLT;
always @(BrUn or rs1_out or rs2_out)
begin	
		       if((rs1_out[31]!=rs2_out[31]) && (BrUn==1'b1) )
				 begin
				           BrEq <= 1'b0;
				           if(rs1_out[31]==1) BrLT <= 1'b1;
					       else BrLT <= 1'b0;
				 end
		       else
                 begin 
		                   if(rs1_out==rs2_out) BrEq <= 1'b1;
		                   else BrEq <= 1'b0; 
		                   if(rs1_out<rs2_out) BrLT <= 1'b1;
		                   else BrLT <= 1'b0;
                 end
end
	endmodule	
