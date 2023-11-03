
module top(
   input        clk,
   input        rst_n,
   input        usb_rx,
   output       usb_tx
);

    assign usb_tx = usb_rx;

endmodule