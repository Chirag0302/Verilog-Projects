`timescale 1ns/1ns
module test();
	reg src_clk, reset;
	wire clk_40_40, clk_20_40, clk_20_20;
	
	clk_divider DUT (src_clk, reset, clk_20_20, clk_20_40, clk_40_40);
	
	initial begin 
		src_clk = 0;
		forever #5 src_clk = ~src_clk;
	end
	
	task rst_dut();
		begin 
			@(negedge src_clk)
				reset <= 1;
			@(negedge src_clk)
				reset <= 0;
		end 
	endtask  
	
	initial begin 
		rst_dut();
		#200;
		$finish;
	end 
endmodule 