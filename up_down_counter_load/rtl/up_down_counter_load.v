module up_down_counter_load #(parameter WIDTH = 4)(clk, rst, enb, mode, load, data_in, count);
    //input port
	 input  clk;
    input  rst;       // synchronous reset
    input  enb;        // enable
    input  mode;      // 1 = up, 0 = down
    input  load;      // load enable
    input  [WIDTH-1:0] data_in;  // value to load
    
	//output port
	output reg  [WIDTH-1:0] count;

	always @(posedge clk) begin
		if (rst)
			count <= {WIDTH{1'b0}};
		else if (load)
			count <= data_in;            // load has priority
		else if (enb) begin
			if (mode)
				count <= count + 1'b1;    // UP
			else
				count <= count - 1'b1;    // DOWN
		end
	end

endmodule
