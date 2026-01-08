module tb_up_down_counter;

	parameter WIDTH = 4;

	reg clk;   
	reg rst;
	reg enb;
	reg mode;
	reg load;
	reg [WIDTH-1:0] data_in;
	wire [WIDTH-1:0] count;

	// DUT
	up_down_counter_load #(.WIDTH(WIDTH)) dut (.clk(clk), .rst(rst), .enb(enb), .mode(mode), .load(load), .data_in(data_in), .count(count));

	// Clock genberation
	always #5 clk = ~clk;

	//////////////////// TASK DEFINITIONS ////////////////////

	task apply_reset;
		begin
			rst = 1;
			enb  = 0;
			load = 0;
			mode = 0;
			#10;
			rst = 0;
		end
	endtask

	task load_counter(input [WIDTH-1:0] value);
		begin
			data_in = value;
			load = 1;
			#10;
			load = 0;
		end
	endtask

	task count_up(input integer cycles);
		begin
			enb = 1;
			mode = 1;
			repeat (cycles) #10;
		end
	endtask

	task count_down(input integer cycles);
		begin
			enb = 1;
			mode = 0;
			repeat (cycles) #10;
		end
	endtask

	task disable_count;
		begin
			enb = 0;
			#10;
		end
	endtask

//////////////////// TEST SEQUenbCE ////////////////////

initial begin
    clk = 0;
    rst = 0;
    enb  = 0;
    mode = 0;
    load = 0;
    data_in = 0;

    $monitor("T=%0t | rst=%b load=%b data_in=%b enb=%b mode=%b count=%b",
              $time, rst, load, data_in, enb, mode, count);

    apply_reset;                 // Reset counter
    load_counter(4'b1010);       // Load value = 10
    count_up(5);                 // Count UP 5 cycles
    count_down(3);               // Count DOWN 3 cycles
    disable_count;               // Hold value

    $finish;
end
endmodule
