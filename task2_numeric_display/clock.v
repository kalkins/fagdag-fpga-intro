module clock #(
    parameter DIVISOR = 1
) (
    input      clk,
    input      rst_n,
    output reg clk_out
);

    localparam DIVISOR_WIDTH = $clog2(DIVISOR);

    reg [DIVISOR_WIDTH:0] ticks = 0;

    always @(posedge clk) begin
        if (~rst_n) begin
            ticks <= 0;
            clk_out <= 0;
        end else if (ticks == DIVISOR) begin
            ticks <= 0;
            clk_out <= ~clk_out;
        end else begin
            ticks <= ticks + 1;
        end
    end
endmodule
