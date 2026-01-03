/////////////----------Universal shift register (All mode)-----------//////////////

module universal_reg(clk, rst, sel, sin_l, sin_r, pin, q_out);
	input clk, rst;
	input [1:0]sel;  //Mod select 
	input sin_l, sin_r;  //serial input left and right 
	input [3:0] pin;  //parallel out 
	
	output reg [3:0] q_out;
	
	always@(posedge clk)
		begin 
			if(rst)
				q_out <= 4'd0;
			else 
				begin
					case(sel)
						2'b00 : q_out <= q_out;   //hold same data
						2'b01 : q_out <= {sin_r, q_out[3:1]};   //shifr the data in right side 
						2'b10 : q_out <= {q_out[2:0], sin_l};   //shift the data in left side 
						2'b11 : q_out <= pin;   //parallel load data
						
						default : q_out <= q_out;
					endcase 
				end 
		end 
endmodule 
						