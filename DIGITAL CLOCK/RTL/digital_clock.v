module digital_clock(clk, reset, second, minute, hour);

	input clk,reset;
	output reg [2:0]second;
	output reg [2:0]minute;
	output reg [2:0]hour;

always@(posedge clk)
	begin
		if (reset)begin
			second=0;
			minute=0;
			hour=0;
		end
		else
			second=second+1;
			if (second==6) begin
				 second=0;
				 minute=minute+1;
					if (minute==6)begin
						 minute=0;
						 hour=hour+1;
							if (hour==6)begin
								 hour=0;
						   end
					end
			end
	end
endmodule

