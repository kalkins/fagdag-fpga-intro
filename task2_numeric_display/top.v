`include "display.v"

// Step 1: Fix cu.pcf to make seven_segment and seven_segment_select available
module top (
    input        clk,
    input        rst_n,
    output [7:0] led,
    output [6:0] seven_segment,
    output [3:0] seven_segment_select
);

    reg   [32:0] count = 0;

    display display_mod(
        .clk                    (clk),
        .rst_n                  (rst_n),
        .value                  (count[15:0]),
        .seven_segment          (seven_segment),
        .seven_segment_select   (seven_segment_select)
    );

    // Step 4: Count, and show it on the display

endmodule
