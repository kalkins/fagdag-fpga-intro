module seven_segment_formatter (
    input  [3:0] value,
    output [6:0] segments
);

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
    (value == 9)  ?  7'b0010000 :
    (value == 10) ?  7'b0001000 :
    (value == 11) ?  7'b0000011 :
    (value == 12) ?  7'b1000110 :
    (value == 13) ?  7'b0100001 :
    (value == 14) ?  7'b0000110 :
                     7'b0001110
);

endmodule