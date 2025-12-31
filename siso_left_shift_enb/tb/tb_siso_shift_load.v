module tb_siso_shift_load;

    reg clk, rst, load, sin;
    reg [3:0] load_data;

    wire [3:0] q_left;

    // Clock generation
    always #5 clk = ~clk;

    // DUT instantiation
    left_shift_siso_load U1 (
        .clk(clk),
        .rst(rst),
        .load(load),
        .sin(sin),
        .load_data(load_data),
        .q(q_left)
    );
	
    initial begin
        // Initial values
        clk = 0;
        rst = 1;
        load = 0;
        sin = 0;
        load_data = 4'b0000;

        #10 rst = 0;

        // Parallel load
        #10 load = 1;
            load_data = 4'b1011;

        #10 load = 0;

        // Serial shifting
        #10 sin = 1;
        #10 sin = 0;
        #10 sin = 1;
        #10 sin = 1;

        #20 $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | Load=%b | Sin=%b | Left=%b",
                  $time, load, sin, q_left);
    end

endmodule

/* module tb_siso_lsb_load_enable;

    reg clk, rst, load, en, sin;
    reg [3:0] pdata;
    wire sout;

    siso_lsb_load_enable dut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .en(en),
        .sin(sin),
        .pdata(pdata),
        .sout(sout)
    );

    always #5 clk = ~clk;

    task load_data(input [3:0] d);
    begin
        load = 1; en = 0;
        pdata = d;
        #10 load = 0;
    end
    endtask

    task shift_bit(input b);
    begin
        en = 1;
        sin = b;
        #10;
    end
    endtask

    initial begin
        clk = 0; rst = 1;
        load = 0; en = 0; sin = 0; pdata = 0;
        #10 rst = 0;

        load_data(4'b1011);   // Load data

        shift_bit(0);
        shift_bit(1);
        shift_bit(1);
        shift_bit(0);

        en = 0;
        #20 $finish;
    end

endmodule */

