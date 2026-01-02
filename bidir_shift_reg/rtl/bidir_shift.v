/////////////----------Bidirectional shift register (directional control)-----------//////////////

module bidir_shift #(parameter N = 4)(clk, rst, dir, sin_left, sin_right, q_out);
	//input port 
	input clk, rst;  //sync. reset
	input dir;  //1 = shift left , 0 = shift right 
	input sin_left, sin_right;   //serial input for left/right shift 
	
	//output port
	output reg [N-1:0]q_out;
	
	always@(posedge clk)
		begin 
			if(rst)
				q_out <= {N{1'b0}};
			else 
				begin 
					if(dir)
						//left shift 
						q_out <= {q_out[N-2:0], sin_left};
					else
						//right shift 
						q_out <= {sin_right, q_out[N-1:1]};
				end 
		end 
endmodule