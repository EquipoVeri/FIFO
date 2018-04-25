timeunit 10ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module UART_TB;

bit clk = 0;
bit reset;
logic [7:0] DataToTransmit;
bit SerialDataRx;
bit Transmit;
bit ClearInterrupt;
bit RxInterrupt;
bit ParityError;
bit SerialOutputTx;
logic [7:0] ReceivedData;

UART
DUV
(	
	 .DataToTransmit(DataToTransmit),
	 .SerialDataRx(SerialDataRx),
    .reset(reset),
	 .Transmit(Transmit),
    .clk(clk),
	 .ClearInterrupt(ClearInterrupt),
	 .RxInterrupt(RxInterrupt),
	 .ParityError(ParityError),
	 .SerialOutputTx(SerialOutputTx),
	 .ReceivedData(ReceivedData)
);


/*********************************************************/
initial // Clock generator
  begin
    forever #1 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#0 reset = 0;
	#0 Transmit = 0;
	#0 SerialDataRx = 1;
	#0 ClearInterrupt = 0;

end

/*********************************************************/

initial begin 
	#5 reset = 1;
	#5 SerialDataRx = 0; //start
	#868 SerialDataRx = 1;  
	#868 SerialDataRx = 0; 
	#868 SerialDataRx = 1;
	#868 SerialDataRx = 0;
	#868 SerialDataRx = 1;
	#868 SerialDataRx = 0;
	#868 SerialDataRx = 1;
	#868 SerialDataRx = 0;
	#868 SerialDataRx = 1;//paridad
	#868 SerialDataRx = 1; //stop
	
	#100  ClearInterrupt = 1;
	#100  ClearInterrupt = 0;
	
	#800 SerialDataRx = 0; //start
	#868 SerialDataRx = 1;  
	#868 SerialDataRx = 0; 
	#868 SerialDataRx = 1;
	#868 SerialDataRx = 0;
	#868 SerialDataRx = 1;
	#868 SerialDataRx = 0;
	#868 SerialDataRx = 1;
	#868 SerialDataRx = 0;
	#868 SerialDataRx = 1;//paridad
	#868 SerialDataRx = 1; //stop

end

/*********************************************************/
endmodule 