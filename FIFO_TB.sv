
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module FIFO_TB;

	// Parameter Declarations
parameter Word_Length = 16;
parameter Depth_Of_FIFO = 8;
parameter NBITS_FOR_COUNTER = CeilLog2(Depth_Of_FIFO);

// Input Ports
bit clk;
bit reset;
bit pop;
bit push;
bit [Word_Length-1:0] DataInput;

// Output Ports
bit full;
bit empty;
bit [Word_Length-1:0] DataOutput;



/********************* Device Under Verification **************/
FIFO

#(
	// Parameter Declarations
	.Word_Length(Word_Length),
	.Depth_Of_FIFO(Depth_Of_FIFO),
	.NBITS_FOR_COUNTER(NBITS_FOR_COUNTER)
)
DUV
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.pop(pop),
	.push(push),
	.DataInput(DataInput),

	// Output Ports
	.full(full),
	.empty(empty),
	.DataOutput(DataOutput)
);

/**************************************************************************/
	
/******************** Stimulus *************************/
initial // Clock generator
  begin
    clk = 1'b0;
    forever #2 clk = !clk;
  end
/*----------------------------------------------------------------------------------------*/
initial begin /*Reset*/
	# 0 reset = 1'b0;
	#3 reset = 1'b1;
end
/*----------------------------------------------------------------------------------------*/
initial begin 
	# 0 pop  = 1'b0;
	# 80 pop  = 1'b1;
	# 4 pop  = 1'b1;
	# 4 pop  = 1'b1;
	# 4 pop  = 1'b1;
	# 4 pop  = 1'b0;
	# 4 pop  = 1'b1;
	# 4 pop  = 1'b0;
	# 4 pop  = 1'b1;
	# 4 pop  = 1'b0;
	# 4 pop  = 1'b1;
	# 4 pop  = 1'b0;
	# 4 pop  = 1'b1;
	# 4 pop  = 1'b0;
end 
/*----------------------------------------------------------------------------------------*/
initial begin 
	# 0  push = 0;
	# 10  push = 1'b1;
	# 4  push = 1'b1;
	# 4  push = 1'b1;
	# 4  push = 1'b1;
	# 4  push = 0;
	# 4  push = 1'b1;
	# 4  push = 0;
	# 4  push = 1'b1;
	# 4  push = 0;
	# 4  push = 1'b1;
	# 4  push = 0;
	# 4  push = 1'b1;
	# 4  push = 0;
end
/*----------------------------------------------------------------------------------------*/ 
initial begin
	# 0  DataInput = 1'b0;
	# 8  DataInput = 8;
	# 4  DataInput = 7;
	# 4  DataInput = 6;
	# 4  DataInput = 5;
	# 4  DataInput = 0;
	# 4  DataInput = 4;
	# 4  DataInput = 0;
	# 4  DataInput = 3;
	# 4  DataInput = 0;
	# 4  DataInput = 2;
	# 4  DataInput = 0;
	# 4  DataInput = 1;
end


/*--------------------------------------------------------------------*/
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
 
 
/*************************************************************/
/*************************************************************/

 