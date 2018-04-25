module CounterWithFunction_RX
#(
	// Parameter Declarations
	parameter MAXIMUM_VALUE = 434,
	parameter HALF_VALUE = 217,
	parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE)
)

(
	// Input Ports
	input clk,
	input reset,
	input enable_max,
	input enable_half,
	
	// Output Ports
	output flag
);

bit MaxValue_Bit;

logic [NBITS_FOR_COUNTER-1 : 0] Count_logic;
logic [NBITS_FOR_COUNTER-1 : 0] limit;

assign limit = (enable_half) ? HALF_VALUE[NBITS_FOR_COUNTER - 1:0] : MAXIMUM_VALUE[NBITS_FOR_COUNTER - 1:0];

	always_ff@(posedge clk or negedge reset) begin
		if (reset == 1'b0)
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
		else begin
				if(enable_max | enable_half)
					if(Count_logic == limit - 1)
						Count_logic <= 0;
					else
						Count_logic <= Count_logic + 1'b1;
		end
	end

//--------------------------------------------------------------------------------------------

always_comb
	if(Count_logic == limit-1)
		MaxValue_Bit = 1;
	else
		MaxValue_Bit = 0;

		
//---------------------------------------------------------------------------------------------
assign flag = MaxValue_Bit;
//----------------------------------------------------------------------------------------------

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
   
 /*Log Function*/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
endmodule
