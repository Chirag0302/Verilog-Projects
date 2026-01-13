module timer(clk,reset,load,time_data,time_out,sec,cycle);

parameter N=32;
parameter WIDTH=5;

//port diraction
input clk,reset,load;
input  [WIDTH-1:0]time_data;
output reg time_out;
output reg [WIDTH-1:0]sec;
output reg [WIDTH-1:0]cycle;

always @(posedge clk)
begin

if (reset) begin
cycle<=5'b0;
sec<=5'b11111;
time_out<=5'b0;
end
else  if (cycle==4) begin
		cycle <= 5'b0;
		sec<=sec-5'b1;
		end
		else cycle<=cycle+5'b1;	 
	 
	if (load)begin   //load the data in counter
	sec<=time_data;
	cycle<=5'b0;
	end
		if (sec==5'b0)
		begin 
		if (cycle==4)
		time_out<=5'b1;
	end
	end
endmodule



