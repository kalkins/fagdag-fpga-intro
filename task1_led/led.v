module top(
   input        clk,
   input        rst_n,
   output [7:0] led
);

reg [32:0] counter;

assign led[7:0] = counter[31:24];

always @(posedge clk or negedge rst_n) begin
   if (~rst_n) begin
      counter <= 0;
   end else begin
      counter <= counter + 1;
   end
end

endmodule
