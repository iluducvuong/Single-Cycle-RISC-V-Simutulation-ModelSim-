module ALU(ALUSel, alumux1_out, alumux2_out, alu_out);

//parameter
parameter SIGNAL_WIDTH = 32;
integer i;

//inputs
input [3:0] ALUSel;
input [SIGNAL_WIDTH-1:0] alumux1_out, alumux2_out;

//outputs
output reg[SIGNAL_WIDTH-1:0] alu_out;
//sra sr1_(.index(alumux2_out),.in(alumux1_out),.out(tem));
//main function
always@(*)
  case(ALUSel)
    0: // ADD
        alu_out = alumux1_out + alumux2_out;
    
    1: // SUB
        alu_out = alumux1_out - alumux2_out;         
    
    2: //SLL shift left logic
        alu_out = (alumux2_out < 32)? alumux1_out << alumux2_out : 0 ;   
    
    3: //SLT signed comparison
        alu_out = ($signed(alumux1_out) < $signed(alumux2_out)) ? 1:0; 
    
    4: //SLTU unsigned comparison
        alu_out = (alumux1_out < alumux2_out) ? 1:0;
    
    5: //XOR
        alu_out = alumux1_out ^ alumux2_out;
    
    6: //SRL shift right logic
        alu_out = (alumux2_out < 32)? alumux1_out >> alumux2_out : 0 ;
    
    7: //SRA dich phai arithmatic
	if (alumux1_out[31]==1'b0)
              alu_out = (alumux2_out < 32)? alumux1_out >> alumux2_out : 0;
        else if (alumux2_out >= 32)
              alu_out = 32'hFFFFFFFF;
        else 
             begin 
                alu_out = alumux1_out >> alumux2_out;
                for (i=0; i<alumux2_out ; i=i+1)
                    alu_out[31-i]=1;
             end

    8: //OR
        alu_out = alumux1_out | alumux2_out;
    
    9: //AND
        alu_out = alumux1_out & alumux2_out;
  endcase
endmodule

