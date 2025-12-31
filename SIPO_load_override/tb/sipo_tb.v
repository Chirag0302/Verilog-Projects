///////////------Testbench-----------////////

module sipo_tb();
	//input port 
	reg clk, rst;
	reg enb;
	reg sovr;
	reg sin;
	reg pload;
	reg [3:0] data;
	
	//output port 
	wire [3:0] data_out;
	
	//design instantiate 
	sipo DUT (.clk(clk), .rst(rst), .enb(enb), .sovr(sovr), .sin(sin), .pload(pload), .data(data), .data_out(data_out));
	
	//clock generation 
	initial begin 
		clk = 1'b0;
		forever 
			#5 clk = ~clk;
	end 
	
	initial begin 
		//initial value 
			clk = 0;
			rst = 1;
			enb = 0;
			sovr = 0;
			sin = 0;
			pload = 0;
			data = 0;
			
		//apply reset 
		@(posedge clk);
			rst = 0;
			enb = 1;
			
		//load data parallel
		data = 4'b1100;
		pload = 1'b1;
		@(posedge clk);
		pload = 1'b0;
		
		//serial shift 
		sovr = 1'b1;
		sin = 1'b1; @(posedge clk);
		sin = 1'b1; @(posedge clk);
		sin = 1'b0; @(posedge clk);
		sovr = 1'b0;
		
		//Hold data
		@(posedge clk);
		
		$finish;
	end 
	
	//monitor 
	initial begin 
		$monitor("T=%0t | rst=%b enb=%b sovr=%b pload=%b sin=%b data=%b data_out=%b",
                  $time, rst, enb, sovr, pload, sin, data, data_out);
	end 
endmodule 
