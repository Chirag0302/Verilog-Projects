////////////////------Task based TB (Bidirectional reg)---------////////////

module bidir_shift_tb();
	
	parameter N=4;
	//input port 
	reg clk, rst;
	reg dir;
	reg sin_left, sin_right;
	
	//output port 
	wire [N-1:0]q_out;
	
	// DUT instantiate 
    bidir_shift #(N) dut (.clk(clk), .rst(rst), .dir(dir), .sin_left(sin_left), .sin_right(sin_right), .q_out(q_out));
	
	//clock generation 
	initial begin 
		clk = 1'b0;
		forever
			#5 clk=~clk;
	end 
	
	//Task for left shift 
	task left_shift(integer data);
		begin 
			dir = 1'b1;
			sin_left = data;
			@(posedge clk);
		end 
	endtask 
	
	//Task for right shift 
	task right_shift(integer data);
		begin 
			dir = 1'b0;
			sin_right = data;
			@(posedge clk);
		end 
	endtask 
	
	//------Test
	initial begin 
		clk = 0; rst = 1; dir = 0; sin_left = 0; sin_right =0;

		//reset
		@(negedge clk);
		rst = 1'b0;
		
		//left shift seq.
		left_shift(1);
		left_shift(0);
		left_shift(1);
		left_shift(1);
		
		//right shift
		right_shift(0);
		right_shift(1);
		right_shift(0);
		
		#50; $finish;
	end 
	
	// Monitor
		initial
		$monitor("T=%0t | rst=%b | dir=%b | sin_left=%b | sin_right=%b | q_out=%b",
                  $time, rst, dir, sin_left, sin_right, q_out);
endmodule 