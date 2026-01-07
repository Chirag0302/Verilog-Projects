//////////////---------- Parameterized Up Counter TB------------////////////////

module up_count_tb();
	//input port 
	reg clk;
	reg rst;
	
	//output port
	wire count;
	
	//design instantiate 
	up_count DUT (.clk(clk), .rst(rst), .count(count));
	
	//clock generation 
	initial 
		begin 
			clk = 1'b0;
			forever 
			#5 clk = ~clk;
		end 
	
	//reset task 
	task rst_dut();
		begin 
			rst = 1'b1;
			@(posedge clk);
			rst = 1'b0;
		end 
	endtask 
	
	//task input 
	task stimulus(input integer n);
		integer i;
			begin 
				for(i=0; i<n; i=i+1)
					@(posedge clk);
			end 
	endtask
	
	initial begin
		// Initial values
		rst = 0;

		// Apply reset
		rst_dut();

		// Let counter run
		stimulus(10);

		// Apply reset again
		rst_dut();

		// Run again
		stimulus(6);

		$finish;
	end 
	
	initial 
		$monitor("TIME=%0t | RST=%b | COUNT=%0d",
					$time, rst, count);
endmodule 