module top (
    input        clk,
    input        rst_n,
    output [7:0] led,
    output [6:0] seven_segment,
    output [3:0] seven_segment_select
);

    localparam CLOCK_SPEED = 100000000;

    wire [32:0] count;
    wire counter_clk;

    clock #(CLOCK_SPEED / 20) counter_clk_mod (
        .clk        (clk),
        .rst_n      (rst_n),
        .clk_out    (counter_clk)
    );

    counter counter_mod (
        .clk        (counter_clk),
        .rst_n      (rst_n),
        .count      (count)
    );

    display #(CLOCK_SPEED) display_mod (
        .clk                    (clk),
        .rst_n                  (rst_n),
        .value                  (count[15:0]),
        .seven_segment          (seven_segment),
        .seven_segment_select   (seven_segment_select)
    );
endmodule
