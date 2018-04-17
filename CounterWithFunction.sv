/******************************************************************* 
* Name:
*	CounterWithFunction.sv
* Description:
* 	This module is the control of the system
* Inputs:
*	clk, reset, Start, enable
* Outputs:
* 	Sync_Reset, Shot, flag0, flag32
* Versión:  
*	1.0
* Author: 
*	Felipe Garcia & Diego Reyna
* Fecha: 
*	27/02/2018 
*********************************************************************/
module CounterWithFunction
#(
	// Parameter Declarations
	parameter MAXIMUM_VALUE = 8,
	parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE)
)

(
	// Input Ports
	input clk,
	input reset,
	input enable_Push,
	input enable_Pop,
	
	// Output Ports
	output flag_empty,
	output flag_full,
	output[NBITS_FOR_COUNTER-1:0] CountWrite,
	output[NBITS_FOR_COUNTER-1:0] CountRead 
	
);

//wire [NBITS_FOR_COUNTER-1:0] max_wire = MAXIMUM_VALUE;
bit MaxValue_Bit;
bit Zero_Bit;

logic [NBITS_FOR_COUNTER-1 : 0] Count_logic;
logic [NBITS_FOR_COUNTER-1 : 0] Count_read;
logic [NBITS_FOR_COUNTER-1 : 0] Count_elements;


	always_ff@(posedge clk or negedge reset) begin
		if (reset == 1'b0) begin
			Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
			Count_read <= {NBITS_FOR_COUNTER{1'b0}};
			Count_elements <= {NBITS_FOR_COUNTER{1'b0}};
		end
		else begin
				if((enable_Push == 1'b1) && (MaxValue_Bit == 1'b0)) begin
					if(Count_logic == MAXIMUM_VALUE-1)
						Count_logic <= 0;
					else begin
						Count_logic <= Count_logic + 1'b1;
						Count_elements <= Count_elements + 1'b1;
					end
				end
				if((enable_Pop == 1'b1) && (Zero_Bit == 1'b0)) begin
					if(Count_read ==  MAXIMUM_VALUE - 1)
						Count_read <= 0;
					else begin
						Count_read <= Count_read + 1'b1;	
						Count_elements <= Count_elements - 1'b1;
					end
				end	
		end	
	end

//--------------------------------------------------------------------------------------------

always_comb begin
	if(Count_elements == MAXIMUM_VALUE-1)
		MaxValue_Bit = 1; 
	else
		MaxValue_Bit = 0;
		
	if ((Count_elements == 0) && (Count_read == 0))
		Zero_Bit = 1;
	else
		Zero_Bit = 0;
end
		
//---------------------------------------------------------------------------------------------
assign flag_full = MaxValue_Bit;
assign flag_empty = Zero_Bit;
assign CountWrite = Count_logic;
assign CountRead = Count_read;
//----------------------------------------------------------------------------------------------

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

