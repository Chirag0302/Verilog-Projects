/////////////////////  clock divider by diffrent freq and duty cycle /////////////////
`timescale 1ns/1ns
module clk_divider(src_clk, reset, clk_20_20, clk_20_40, clk_40_40);
	input src_clk, reset;
	output clk_20_20, clk_20_40, clk_40_40;
	
	reg[2:0]count;
	reg a1, a2, a3;
	
	always@(posedge src_clk)
		begin 
			if(reset)
				count <= 0;
			else 
				begin
					if(count == 4) 
						count <= 0;
					else 
						count <= count + 1'b1;
				end
		end 
	
	always@(posedge src_clk)
		begin 
			if(count == 0)
				a1 <= 1;
			else 
				a1 <= 0;
		end 
		
	always@(negedge src_clk)
		begin 
			if(count == 3)
				a2 <= 1;
			else 
				a2 <= 0;
		end 
	
	always@(posedge src_clk)
		begin 
			if(count == 0 || count == 1)
				a3 <= 1;
			else 
				a3 <= 0;
		end 
		
	assign clk_40_40 = a1 | a2;
	assign clk_20_20 = a1; 
	assign clk_20_40 = a3;
endmodule 
