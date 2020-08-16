`timescale 1ps/1ps 
module tb();

reg clk,rst;
Datapath Datapath(rst,clk);

initial begin
rst=0;
clk=0;
end

always
	begin
		#50
                clk = !clk;
	end
endmodule

