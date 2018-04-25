module mux4_1(
    input [3:0] in_00,
    input [3:0] in_01,
    input [3:0] in_10,
    input [3:0] in_11,
    input [1:0] s,
    output [3:0] y
    );
	 
assign y = (s==2'b00)? in_00:
			  (s==2'b01)? in_01:
			  (s==2'b10)? in_10:
			  (s==2'b11)? in_11: 4'b0000;
			  
endmodule
