module Control_Unit(inst,BrEq,BrLT,PCSel,ImmSel,RegWEn,BrUn,BSel,ASel,ALUSel,MemRW,RSel,WSel,WBSel);
input [31:0]inst;
input BrEq,BrLT;
reg [19:0]data; //cau truc: PCSel_ImmSel_RegWEn_BrUn_BSel_ASel_ALUSel_MemRW_RSel_WSel_WBSel
output reg PCSel,RegWEn,BrUn,BSel,ASel,MemRW;
output reg [2:0]ImmSel,RSel;
output reg [1:0]WSel,WBSel;
output reg [3:0]ALUSel;
//type
localparam R=5'b01100;
localparam Ic=5'b00100;
localparam Il=5'b00000;
localparam S=5'b01000;
localparam B=5'b11000;
localparam J=5'b11011;
localparam Jr=5'b11001;
//command
localparam add_sub =3'b000; localparam addi =3'b000; localparam lb =3'b000;
localparam beq =3'b000; localparam jalr =3'b000; localparam sb =3'b000;
localparam sll =3'b001; localparam slli =3'b001;  localparam sh =3'b001; localparam bne =3'b001;
localparam slt= 3'b010; localparam slti = 3'b010; localparam lh = 3'b010; localparam sw= 3'b010;
localparam sltu= 3'b011; localparam sltiu= 3'b011;  localparam lw= 3'b011;
localparam _xor= 3'b100; localparam _xori= 3'b100; localparam lbu= 3'b100; localparam blt= 3'b100;
localparam srl_sra= 3'b101; localparam srli_srai= 3'b101; localparam bge= 3'b101; 
localparam _or = 3'b110; localparam _ori = 3'b110; localparam lhu = 3'b110; localparam bltu = 3'b110;
localparam _and = 3'b111; localparam _andi = 3'b111; localparam bgeu = 3'b111;
//operation
always @ (*) begin
case(inst[6:2])
	R: begin 
		case(inst[14:12])
		add_sub: begin 
				if (inst[30]) data<=20'b0_101_1_0_0_0_0001_0_111_11_01;
				else data<=20'b0_101_1_0_0_0_0000_0_111_11_01;
			end
		sll: data<=20'b0_101_1_0_0_0_0010_0_111_11_01;
		slt: data<=20'b0_101_1_0_0_0_0011_0_111_11_01;
		sltu: data<=20'b0_101_1_0_0_0_0100_0_111_11_01;
		_xor: data<=20'b0_101_1_0_0_0_0101_0_111_11_01;
		srl_sra: begin 
				if (inst[30]) data<=20'b0_101_1_0_0_0_0110_0_111_11_01;
				else data<=20'b0_101_1_0_0_0_0111_0_111_11_01;
			end			
		_or: data<=20'b0_101_1_0_0_0_1000_0_111_11_01;
		_and: data<=20'b0_101_1_0_0_0_1001_0_111_11_01;
		endcase
	   end
	Ic: begin
		case(inst[14:12])
		addi: data<=20'b0_000_1_0_1_0_0000_0_111_11_01;
		slti: data<=20'b0_000_1_0_1_0_0011_0_111_11_01;
		sltiu: data<=20'b0_000_1_0_1_0_0100_0_111_11_01;
		_xori: data<=20'b0_000_1_0_1_0_0101_0_111_11_01;
		_or: data<=20'b0_000_1_0_1_0_1000_0_111_11_01;
		_andi: data<=20'b0_000_1_0_1_0_1001_0_111_11_01;
		slli: if (inst[30]==0) data<=20'b0_001_1_0_1_0_0010_0_111_11_01;
		srli_srai: begin
				if(inst[30]) data<=20'b0_001_1_0_1_0_0111_0_111_11_01;
				else data<=20'b0_001_1_0_1_0_0110_0_111_11_01;
			end
	     	endcase
	     end
	Il:  begin
		case(inst[14:12])
		lb: data<= 20'b0_000_1_0_1_0_0000_0_001_11_00;
		lh: data<= 20'b0_000_1_0_1_0_0000_0_010_11_00;
		lw: data<= 20'b0_000_1_0_1_0_0000_0_000_11_00;
		lbu: data<= 20'b0_100_1_0_1_0_0000_0_101_11_00;
		lhu: data<= 20'b0_100_1_0_1_0_0000_0_110_11_00;
		endcase
	     end
	S:  begin
		case(inst[14:12])
		sb: data<= 20'b0_010_0_0_1_0_0000_1_111_01_00;
		sh: data<= 20'b0_010_0_0_1_0_0000_1_111_10_00;
		sw: data<= 20'b0_010_0_0_1_0_0000_1_111_00_00;
	    	endcase
	    end
	B: begin
		case(inst[14:12])
		beq: begin
			 BrUn=1'b1;
			 if(BrEq) data<= 20'b1_011_0_1_1_1_0000_0_111_11_00;
			 else data<= 20'b0_101_0_1_0_0_0000_0_111_11_00;
		     end
		bne: begin
			BrUn=1'b1;
			 if(BrEq==0) data<= 20'b1_011_0_1_1_1_0000_0_111_11_00;
			 else data<= 20'b0_101_0_1_0_0_0000_0_111_11_00;
		      end
		blt: begin
			BrUn=1'b1;
			 if(BrEq==0 && BrLT==1) data<= 20'b1_011_0_1_1_1_0000_0_111_11_00;
			 else data<= 20'b0_101_0_1_0_0_0000_0_111_11_00;
		      end
		bge: begin
			BrUn=1'b1;
			 if(BrEq==1 || BrLT==0) data<= 20'b1_011_0_1_1_1_0000_0_111_11_00;
			 else data<= 20'b0_101_0_1_0_0_0000_0_111_11_00;
		      end
		bltu: begin
			 BrUn=1'b0;
			 if(BrEq==0 && BrLT==1) data<= 20'b1_111_0_0_1_1_0000_0_111_11_00;
			 else data<= 20'b0_101_0_1_0_0_0000_0_111_11_00;
		       end
		bgeu: begin
			 BrUn=1'b0;
			 if(BrEq==1 || BrLT==0) data<= 20'b1_111_0_0_1_1_0000_0_111_11_00;
			 else data<= 20'b0_101_0_1_0_0_0000_0_111_11_00;
		      end
		endcase
	     	end
	J: data <= 20'b1_110_1_0_1_1_0000_0_111_11_10;
	Jr: data <= 20'b1_000_1_0_1_0_0000_0_111_11_10;
endcase
PCSel<= data[19];
ImmSel <=data[18:16];
RegWEn <=data[15];
BrUn <= data [14];
BSel <= data [13];
ASel <= data [12];
ALUSel <= data [11:8];
MemRW <= data[7];
RSel <= data[6:4];
WSel <= data[3:2];
WBSel <= data[1:0];
end
endmodule
