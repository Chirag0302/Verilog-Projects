module johnson (clk, reset, count);
	parameter N = 4;
	input clk;
	input reset;
	output reg [N-1:0] count;
	
	always@(posedge clk or posedge reset)
		begin 
			if(reset)
				//count <= {3'b000, 1'b1};   ring counter
				count <= {4'b0000};
			else 
				//count <= {count[0], count[N-1:1]}; ring counter
				count <= {~count[0], count[N-1:1]};
		end 
endmodule 