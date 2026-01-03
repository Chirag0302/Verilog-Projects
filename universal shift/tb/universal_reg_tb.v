////////////////------Testbench-universal shift reg---------///////////

module universal_reg_tb();
	//input port 
	reg clk, rst;
	reg sin_l, sin_r;
	reg [1:0]sel;
	reg [3:0]pin;
	//output port 
	wire [3:0] q_out;
	
	//design instantiate 
	universal_reg DUT (.clk(clk), .rst(rst), .sin_l(sin_l), .sin_r(sin_r), .sel(sel), .pin(pin), .q_out(q_out));
	
	//clock generation 
	always #5 clk = ~clk;
	
	//----Test 
	initial begin 
		//Initialize all input 
		clk=0; rst=1; sel=0; sin_l=0; sin_r=0; pin=0;
		
		//apply reset
		@(posedge clk);
		rst = 0;
		
		//Parallel load 
		@(posedge clk);
		sel = 2'b11;
		pin = 4'b1010;
		
		//HOld 
		@(posedge clk);
		sel = 2'b00;
		
		//shift left 
		@(posedge clk);
		sel = 2'b10;
		sin_l = 1'b1;
		@(posedge clk);
		sin_l = 1'b0;
		@(posedge clk);
		sin_l = 1'b1;
		
		//shift right 
		@(posedge clk);
		sel = 2'b01;
		sin_r = 1'b1;
		@(posedge clk);
		sin_r = 1'b0;
		@(posedge clk);
		sin_r = 1'b1;
	
		#50; $finish;
	end 
	
	initial 
		$monitor("Time=%0t | sel = %0b | sin_l = %0b | sin_r = %0b | pin = %0b | q_out = %0b",$time, sel, sin_l, sin_r, pin, q_out);
		
endmodule 