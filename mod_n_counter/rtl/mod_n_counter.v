module mod_n_counter #(
    parameter N = 10
)(
    input  wire clk,
    input  wire rst,
    output reg  [N-1:0] count
);

always @(posedge clk) begin
    if (rst)
        count <= 0;
    else if (count == N-1)
        count <= 0;
    else
        count <= count + 1;
end

endmodule
