module display #(
    parameter CLOCK_SPEED = 0
) (
    input clk,
    input rst_n,
    input [15:0] value,
    output [6:0] seven_segment,
    output [3:0] seven_segment_select,
);

    localparam FRAMERATE = 1000;
    localparam FRAME_DIVISOR = CLOCK_SPEED / FRAMERATE / 4;

    wire frame_clk;

    reg [1:0] display_select = 0;

    wire [3:0] current_digit = (
        display_select == 0 ? value[3:0]  :
        display_select == 1 ? value[7:4]  :
        display_select == 2 ? value[11:8] :
                              value[15:12]
    );

    assign seven_segment_select = (
        display_select == 0 ? 4'b0111 :
        display_select == 1 ? 4'b1011 :
        display_select == 2 ? 4'b1101 :
                              4'b1110
    );

    clock #(FRAME_DIVISOR) frame_clk_mod (
        .clk(clk),
        .rst_n(rst_n),
        .clk_out(frame_clk)
    );

    seven_segment_formatter formatter_mod (
        .value(current_digit),
        .segments(seven_segment)
    );

    always @(posedge frame_clk) begin
        display_select <= display_select + 1;
    end
endmodule
