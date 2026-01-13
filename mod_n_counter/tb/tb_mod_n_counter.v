module tb_mod_n_counter;

parameter N = 10;

reg clk;
reg rst;
wire [N-1:0] count;

mod_n_counter #(.N(N)) dut (
    .clk(clk),
    .rst(rst),
    .count(count)
);

// Clock generation: 10 time units period
always #5 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;

    #12 rst = 0;        // Deassert reset

    #200 $finish;
end

initial begin
    $monitor("Time=%0t | Reset=%b | Count=%0d", $time, rst, count);
end

endmodule
