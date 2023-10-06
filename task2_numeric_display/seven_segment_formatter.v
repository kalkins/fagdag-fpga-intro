module seven_segment_formatter (
    input  [3:0] value,
    output [6:0] segments
);

    // Step 3: Fill in the mappings between numerical value and LEDs in the display
    assign segments = (
        (value == 0)  ?  7'b1000000 :
        (value == 1)  ?  7'b1111001 :
        (value == 2)  ?  7'b0100100 :
        (value == 3)  ?  7'b0110000 :
        (value == 4)  ?  7'b0011001 :
        (value == 5)  ?  7'b0010010 :
        (value == 6)  ?  7'b0000010 :
        (value == 7)  ?  7'b1111000 :
        (value == 8)  ?  7'b0000000 :
        (value == 9)  ?  7'b0011000 :
                         7'b1111111
    );

endmodule