// Quartus II Verilog Template
// Single port RAM with single read/write address 

module single_port_ram 
#(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=6)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] addr,
	input we, clk,
	output [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	logic [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	logic [ADDR_WIDTH-1:0] addr_logic;

	always_ff @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data;

		addr_logic <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr_logic];

endmodule
