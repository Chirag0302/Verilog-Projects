//------------------- barrel_shifter -------------------//

module barrel_shifter (data_in, shift_amt, mode, data_out);
    input  [7:0] data_in;    // Input data
    input  [2:0] shift_amt;   // Shift amount (0 to 7)
    input  [1:0] mode;        // 00: LSL, 01: LSR, 10: ASR
    output reg [7:0] data_out; // Shifted output

    always @(*) begin
        case (mode)
            2'b00: data_out = data_in << shift_amt;          // Logical Left Shift
            2'b01: data_out = data_in >> shift_amt;          // Logical Right Shift
            2'b10: data_out = $signed(data_in) >>> shift_amt;// Arithmetic Right Shift
            default: data_out = data_in;
        endcase
    end

endmodule
