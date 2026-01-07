// tb_mux_barrel_shifter.v
`timescale 1ns/1ps

module tb_barrel_shifter;

    reg  [7:0] data_in;
    reg  [2:0] shift_amt;
    reg  [1:0] mode;   // 0 = logical, 1 = arithmetic
    wire [7:0] data_out;

    // DUT instantiation
    barrel_shifter dut (
        .data_in   (data_in),
        .shift_amt (shift_amt),
        .mode  (mode),
        .data_out  (data_out)
    );

    initial begin
        // ---------------- Logical Right Shift ----------------
        mode = 0;
        data_in  = 8'b0010_1101;
        shift_amt = 1;  #10;
        shift_amt = 3;  #10;

        // ---------------- Arithmetic Right Shift ----------------
        mode = 1;
        data_in  = 8'b1010_1101; // negative number
        shift_amt = 1;  #10;
        shift_amt = 4;  #10;

        // ---------------- No Shift ----------------
        mode = 0;
        shift_amt = 0;  #10;

        $finish;
    end
	
	initial 
		$monitor("%4t |   %b   |   %0d   | %b | %b",
                  $time, mode, shift_amt, data_in, data_out);
endmodule
