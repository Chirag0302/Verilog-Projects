module timer_tb();

parameter WIDTH=5;

reg reset,clk,load;
reg [WIDTH-1:0]time_data;
wire [WIDTH-1:0]sec;
wire [WIDTH-1:0]cycle;
wire time_out;


//instantiation
timer DUT(.reset(reset),.clk(clk),.load(load),.time_data(time_data),.sec(sec),.cycle(cycle),.time_out(time_out));


//clock generation
initial begin
	clk=1'b0;
	forever
	#5 clk=~clk;
end

task rst();
begin
@(posedge clk);
reset=1'b1;
@(posedge clk);
reset=1'b0;
end
endtask

task cycle_delay(input integer i);
begin
repeat (i) @(posedge clk);
end
endtask

task dataload(); 
input [WIDTH-1:0]in;
begin
@(posedge clk)
load=1'b1;
time_data=in;
@(posedge clk)
load=1'b0;
end
endtask


initial begin
rst();
cycle_delay(10);
rst();
dataload(5'b1111);
end

endmodule