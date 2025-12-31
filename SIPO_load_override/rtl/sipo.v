///////////////------------SIPO with parallel load + serial override------------////////////

module sipo (clk, rst, enb, sovr, sin, pload, data, data_out);
	//input port 
	input clk;
	input rst;   //sync. active high
	input enb;
	input sovr;  //serial override
	input sin;   //serial input 
	input pload; //parallel load
	input [3:0]data;  //parallel data
	
	//output port
	output reg[3:0]data_out;
	
	always@(posedge clk)
		begin 
			if(rst)
				data_out <= 4'd0;
			else if(enb)
				begin 
					if(sovr)
						begin 
							data_out <= {data_out[2:0], sin};   //left shift 
						end 
					else if(pload)
						begin 
							data_out <= data; //parallel load
						end 
					else 
						data_out <= data_out;  //Hold
				end 
		end 
endmodule 