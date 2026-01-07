//////////////---------- Parameterized Up Counter------------////////////////

module up_count #(parameter N = 4)(clk, rst, count);
	//input port 
	input clk;
	input rst;   //sync. reset
	
	//output port
	output reg[N-1:0]count;
	
	always@(posedge clk)
		begin 
			if(rst)
				count <= {N{1'b0}};
			else 
				count <= count + 1'b1;
		end 
endmodule 