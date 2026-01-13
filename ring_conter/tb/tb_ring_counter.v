`timescale 1ns/1ps

module tb_ring_counter;

    parameter N = 4;

    // in/op signals
    reg clk;
    reg rst;
    reg load;
    reg [N-1:0] d_in;
    wire [N-1:0] count;

    // DUT instantiation
    ring_conter #(N) DUT (.clk(clk), .rst(rst), .load(load), .d_in(d_in), .count(count));

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // ================= TASKS =================
    // Reset task
    task apply_reset;
        begin
            rst = 1;
            load = 0;
            d_in = 0;
            @(posedge clk);
            rst = 0;
        end
    endtask

    // Load task
    task load_data(input [N-1:0] data);
        begin
            load = 1;
            d_in = data;
            @(posedge clk);
            load = 0;
        end
    endtask
	
    // ================= TEST SEQUENCE =================
    initial begin
        // Initialize signals
        clk  = 0;
        rst  = 0;
        load = 0;
        d_in = 0;

        // Apply reset
        apply_reset;

        // Observe default ring rotation
		repeat(5)@(posedge clk);

        // Load custom value
        load_data(4'b0100);
        repeat(5)@(posedge clk);

        // Load another value
        load_data(4'b1000);
        repeat(5)@(posedge clk);

        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | rst=%b load=%b d_in=%b count=%b",
                  $time, rst, load, d_in, count);
    end

endmodule
