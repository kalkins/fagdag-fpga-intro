`include "seven_segment_formatter.v"
`include "bin2bcd.v"

module display (
    input clk,
    input sel_clk,
    input rst_n,
    input [15:0] value,
    output [6:0] seven_segment,
    output [3:0] seven_segment_select
);

    // Step 2: Select display and show something
    reg [3:0] selected = 0;
    reg [15:0] bcd;

    always @(posedge sel_clk) begin
        if (selected == 0) begin
            selected = 4'b0001;
        end else begin
            selected <= selected << 1 ;
        end
    end

    assign seven_segment_select = ~selected;

    bin2bcd #(15) bcd1(
        .bin(value),
        .bcd(bcd)
    );
    wire   [3:0] digitOnes = bcd[3:0];
    wire   [3:0] digitTens = bcd[7:4];
    wire   [3:0] digitHnrs = bcd[11:8];
    wire   [3:0] digitThsn = bcd[15:12];
    wire   [3:0] digit;

    assign digit =  selected[0] ? (digitThsn) : 
                   (selected[1] ? (digitHnrs) :
                   (selected[2] ? (digitTens) : (digitOnes)));

    seven_segment_formatter formatter_mod (
        .value(digit),
        .segments(seven_segment)
    );

    // Step 5: Use all four displays

endmodule
