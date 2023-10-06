`include "display.v"

module top (
    input        clk,
    input        rst_n,
    output [7:0] led,
    output [6:0] seven_segment,
    output [3:0] seven_segment_select
);


    reg selector_clk = 0;
    reg [31:0] selector_div = 0;
    reg [31:0] clk_div = 0;
    reg [15:0] count = 0;

    always @(posedge clk) begin
      if (clk_div == 1000000) begin
         clk_div <= 0;
         count <= count + 1;
      end else begin
         clk_div <= clk_div + 1;
      end

      if (selector_div == 512) begin
         selector_div <= 0;
         selector_clk <= ~selector_clk;
      end else begin 
         selector_div <= selector_div + 1;
      end
   end

    display display_mod(
        .clk                    (clk),
        .sel_clk                (selector_clk),
        .rst_n                  (rst_n),
        .value                  (count[15:0]),
        .seven_segment          (seven_segment),
        .seven_segment_select   (seven_segment_select)
    );

    // Step 4: Count, and show it on the display

endmodule
