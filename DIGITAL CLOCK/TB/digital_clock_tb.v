module digital_clock_tb();

reg reset;
reg clk;
wire [2:0]second;
wire [2:0]minute;
wire [2:0]hour;


//instantiation

digital_clock DUT(.reset(reset),.clk(clk),.second(second),.minute(minute),.hour(hour));


//clock generation

`timescale 1s/1ms

initial begin

clk=1'b0;
forever
#5 clk=~clk;  //1hz frequency mate
end


initial begin

reset=1;
#10;
reset=0;

end


endmodule
