module imm_gen (imm_in, ImmSel, imm_out);
input [31:7] imm_in;
input [2:0] ImmSel;
output reg [31:0] imm_out;
always @(imm_in or ImmSel)
begin	
     case (ImmSel)
     3'b000:
	     begin
	           imm_out[11:0] <= imm_in[31:20];
	           if (imm_in[31]==1'b0) imm_out[31:12] <= 20'h00000;
	           else imm_out[31:12] <= 20'hFFFFF;
	     end
     3'b001:
	     begin
               imm_out[4:0] <= imm_in[24:20];
	           if (imm_in[24]==1'b0) imm_out[31:5] <= 27'h0000000;
	           else imm_out[31:5] <=27'h7FFFFFF;
	     end
     3'b010:
         begin
               imm_out[11:5] <= imm_in[31:25];
               imm_out[4:0] <= imm_in[11:7];
	           if (imm_in[31]==1'b0) imm_out[31:12] <= 20'h00000;
	           else imm_out[31:12] <= 20'hFFFFF;
	     end
	 3'b011:
	     begin
                   imm_out[12] <= imm_in[31];
                   imm_out[10:5] <= imm_in[30:25];
		   imm_out[4:1] <= imm_in[11:8];
                   imm_out[11] <= imm_in[7];
                   imm_out[0] <= 1'b0;
	           if (imm_in[31]==1'b0) imm_out[31:13] <= 19'h00000;
	           else imm_out[31:13] <= 19'h7FFFF;
	     end
	 3'b100:
	     begin
	           imm_out[11:0] <= imm_in[31:20];
	           imm_out[31:12] <= 20'h00000;
	     end
	 3'b110:
	     begin
                   imm_out[20] <= imm_in[31];
                   imm_out[10:1] <= imm_in[30:21];
                   imm_out[11] <= imm_in[20];
                   imm_out[19:12] <= imm_in[19:12];
                   imm_out[0] <= 1'b0;
	           if (imm_in[31]==1'b0) imm_out[31:21] <= 11'h000;
	           else imm_out[31:21] <= 11'h7FF;
	     end
	 3'b111:
	     begin
                   imm_out[12] <= imm_in[31];
                   imm_out[10:5] <= imm_in[30:25];
		   imm_out[4:1] <= imm_in[11:8];
                   imm_out[11] <= imm_in[7];
                   imm_out[0] <= 1'b0;
	           imm_out[31:13] <= 19'h00000;
	     end      
     endcase
end
	endmodule	
