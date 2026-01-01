//////////////------------Write a verilog code for PISO load > Shift(LSB)----------------///////////////

module piso (clk, rst, load, pdata, d_out);
	//input port 
	input clk, rst;
	input load;
	input[3:0]pdata;
	
	//output port 
	output reg d_out;
	
	reg [3:0]d_in;
	
	always@(posedge clk)
		begin 
			if(rst)
				begin 
					d_out <= 1'b0;
					d_in <= 1'b0;
				end 
			else if(load)
				begin 
					d_in <= pdata;   //load the data 
				end 
			else 
				begin 
					d_out <= d_in[0];  //shift LSB
					d_in <= {1'b0, d_in[3:1]};
				end 
		end 
endmodule 