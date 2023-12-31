module seven_segment_formatter (
    input  [3:0] value,
    output [6:0] segments
);

    // Step 3: Fill in the mappings between numerical value and LEDs in the display
    assign segments = (
        (value == 0)  ?  7'b1000000 :
        (value == 1)  ?  7'b1111001 :
        (value == 2)  ?  7'b0100100 :
                         7'b1111111
    );

endmodule