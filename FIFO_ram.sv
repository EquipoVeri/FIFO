// Quartus II Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock

module FIFO_ram 
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=6)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr,
	input we, clk,
	output [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	logic [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	always_ff @ (posedge clk)
	begin
		// Write
		if (we)
			ram[write_addr] <= data;
	end
	
	assign q = ram[read_addr];

endmodule 