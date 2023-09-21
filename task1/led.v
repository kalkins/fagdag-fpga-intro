module top(
    input clk,
    input rst_n,
    output[7:0]led,
  );

  reg [32:0]  counter;

  assign led[7:0] = counter[32:25];

  always @(posedge clk) begin
     if (rst_n) begin
        counter <= counter + 1'b1;
     end else begin
        counter <= 0;
     end
  end
endmodule
