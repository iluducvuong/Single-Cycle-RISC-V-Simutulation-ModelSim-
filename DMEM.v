`timescale 1ps/1ps
module DMEM(DataR,DataW,Addr,WSel,RSel,MemRW,clk);
parameter 	DATA_WIDTH =  32;
parameter	MEM_DEPTH = 1<<18;

output reg 	[DATA_WIDTH-1:0]DataR;

input 		[DATA_WIDTH-1:0]Addr,DataW;
input		[2:0]RSel;
input		[1:0]WSel;
input 		MemRW,clk;

reg    		[DATA_WIDTH-1:0] DMEM [0:MEM_DEPTH-1];

wire		[DATA_WIDTH-1:0]tempR,tempW;
wire		[17:0]pWord;
wire		[1:0]pByte;

assign		pWord = Addr[19:2];
assign		pByte = Addr[1:0];
assign		tempW = DMEM[pWord];
assign		tempR = DMEM[pWord];	

always@(posedge clk) 
begin 
#5
   	if (MemRW) begin				//Write
		if (pByte == 2'b00) begin
		case (WSel)
		2'b00:	DMEM[pWord] <= DataW;
		2'b01:	DMEM[pWord] <= (tempW & 32'hffffff00) | (DataW & 32'h000000ff); 
		2'b10:	DMEM[pWord] <= (tempW & 32'hffff0000) | (DataW & 32'h0000ffff); 
		endcase
		end
		end
	else begin					//Read		
		if (pByte == 2'b00) begin			
		case (RSel)
		3'b000: DataR <= tempR; 
		3'b001: DataR <= {{24{tempR[7]}},tempR[7:0]}; 
		3'b010: DataR <= {{16{tempR[7]}},tempR[15:0]}; 	
		3'b101: DataR <= {{24{1'b0}},tempR[7:0]}; 
		3'b110: DataR <= {{16{1'b0}},tempR[15:0]}; 	      
		endcase
		end
	end
end

endmodule

