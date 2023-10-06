`include "seven_segment_formatter.v"

module display (
    input clk,
    input rst_n,
    input [15:0] value,
    output [6:0] seven_segment,
    output [3:0] seven_segment_select
);

    // Step 2: Select display and show something

    wire   [3:0] digit = value[3:0];

    seven_segment_formatter formatter_mod (
        .value(digit),
        .segments(seven_segment)
    );

    // Step 5: Use all four displays

endmodule
