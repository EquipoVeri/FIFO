// Quartus II Verilog Template
// Single port RAM with single read/write address 

module FIFO 
#(
	parameter Word_Length = 16,
	parameter Depth_Of_FIFO = 8,
	parameter NBITS_FOR_COUNTER = CeilLog2(Depth_Of_FIFO)
)
(
	input clk, 
	input reset,
	input pop,
	input push,
	input [Word_Length-1:0] DataInput,
	output full, empty,
	output [Word_Length-1:0] DataOutput
);

//wire [Word_Length-1:0] dataInput_wire;
wire [Word_Length-1:0] dataOutput_wire;
//wire [Word_Length-1:0] addr_wire;
wire [NBITS_FOR_COUNTER-1:0] read_addr_wire;
wire [NBITS_FOR_COUNTER-1:0] write_addr_wire;
wire full_w;
wire empty_w;

assign DataOutput = dataOutput_wire;
assign full = full_w;
assign empty = empty_w;

/*
Register_With_Clock_Enable registerPush(
	.clk(clk),
	.reset(reset),
	.enable(push),
	.Data_Input(DataInput),
	.Data_Output(dataInput_wire)
);*/

CounterWithFunction
#(
	.MAXIMUM_VALUE(Depth_Of_FIFO),
	.NBITS_FOR_COUNTER(NBITS_FOR_COUNTER)
)
counter
(
	.clk(clk),
	.reset(reset),
	.enable_Push(push),
	.enable_Pop(pop),
	.flag_empty(empty_w),
	.flag_full(full_w),
	.CountWrite(write_addr_wire),
	.CountRead(read_addr_wire)
);

simple_dual_port_ram_single_clock 
#(
	.DATA_WIDTH(Word_Length),
	.ADDR_WIDTH(NBITS_FOR_COUNTER)
)
Ram(
	.data(DataInput),
	.read_addr(read_addr_wire), 
	.write_addr(write_addr_wire),
	.we(push), 
	.clk(clk),
	.q(dataOutput_wire)
);


/*Register_With_Clock_Enable
#(
	.Word_Length(Word_Length)	
) 
registerPop
(
	.clk(clk),
	.reset(reset),
	.enable(pop),
	.Data_Input(dataOutput_wire),
	.Data_Output(DataOutput)
);
*/
/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
   
 /*Log Function*/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i <= data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/

endmodule
