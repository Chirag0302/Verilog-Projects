////////////--------Task based Testbench for PISO-----------///////////

module piso_tb();
	//input port 
	reg clk, rst;
	reg load;
	reg [3:0]pdata;
	
	//output 
	wire d_out;
	
	//design instantiate 
	piso DUT (.clk(clk), .rst(rst), .load(load), .pdata(pdata), .d_out(d_out));
	
	//clock generation 
	initial 
		begin 
			clk = 1'b0;
			forever 
				#5 clk = ~ clk;
		end 
	
	//task for reset 
	task rst_dut();
		begin 
			@(negedge clk)
				rst = 1'b1;
			@(negedge clk)
				rst = 1'b0;
		end 
	endtask
	
	//task for stimulus 
	task load_data (input[3:0]i);
		begin 
			load = 1'b1;
			pdata <= i;
			@(posedge clk);
			load = 1'b0;
		end 
	endtask 
	
	//task shift 
	task shift_bit(input integer n);
		integer i;
			begin
				for(i=0; i<n; i=i+1)
					#10;
			end 
	endtask
	
	//---------Test
	initial begin 
		clk = 1'b0;
		rst = 1'b0;
		load = 1'b0;
		pdata = 1'b0;
		
		rst_dut();
		
		@(posedge clk);
		
		load_data(4'b1011);
		
		shift_bit(4);
		
		@(posedge clk);
		
		load_data(4'b1110);
		
		shift_bit(3);
		
		#10 $finish;
	end 
	
	//Monitor 
	initial begin 
		$monitor("T=%0t | load=%b | pdata=%b | d_out=%b",
					$time, load, pdata, d_out);
	end 
endmodule 