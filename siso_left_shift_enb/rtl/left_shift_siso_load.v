module left_shift_siso_load (
    input        clk,
    input        rst,
    input        load,
    input        sin,
    input  [3:0] load_data,
    output reg [3:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b0000;
        else if (load)
            q <= load_data;              // Parallel load
        else
            q <= {q[2:0], sin};          // Left shift
    end

endmodule

/* module siso_lsb_load_enable (
    input        clk,
    input        rst,
    input        load,
    input        en,
    input        sin,
    input  [3:0] pdata,
    output       sout
);

    reg [3:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst)
            shift_reg <= 4'b0000;

        else if (load)
            shift_reg <= pdata;        // Parallel load

        else if (en)
            shift_reg <= {sin, shift_reg[3:1]}; // Right shift (LSB out)

        else
            shift_reg <= shift_reg;    // Hold
    end

    assign sout = shift_reg[0];        // LSB first output

endmodule */

