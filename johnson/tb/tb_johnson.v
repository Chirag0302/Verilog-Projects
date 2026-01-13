module tb_johnson;

    parameter N = 4;
    reg clk, reset;
    wire [N-1:0] count;

    johnson #(N) DUT (
        .clk(clk),
        .reset(reset),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        #10 reset = 0;

        #150; $finish;
    end

    initial begin
        $monitor("Time=%0t | count=%b", $time, count);
    end

endmodule
