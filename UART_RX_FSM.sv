module UART_RX_FSM(
    input rx,
    input clk,
    input reset,
    input enable_flag, 
	 output dataReceived,
    output enable_max,
    output enable_half
);



enum logic [3:0] {IDLE, START, B0, B1, B2, B3, B4, B5, B6, B7, PARITY, STOP} state;
bit enable_half_w;
bit enable_max_w;
bit dataReceived_bit;

assign dataReceived = dataReceived_bit;

always_ff@(posedge clk, negedge reset) begin
		if (reset == 1'b0) 
			state <= IDLE;
		else 
		case (state)
				IDLE: 
					if (~rx)  // Inicio con la cero en rx
						state <= START;
					else 
						state <= IDLE;
				START:
					if(enable_flag)
						state <= B0;
					else 
						state <= START;
				B0:
					if(enable_flag)
						state <= B1;
					else
						state <= B0;
				B1:
					if(enable_flag)
						state <= B2;
					else
						state <= B1;
				B2:
					if(enable_flag)
						state <= B3;
					else 
						state <= B2;
				B3:
					if(enable_flag)
						state <= B4;
					else
						state <= B3;
				B4:
					if(enable_flag)
						state <= B5;
					else
						state <= B4;
				B5:
					if(enable_flag)
						state <= B6;
					else
						state <= B5;
				B6:
					if(enable_flag)
						state <= B7;
					else 
						state <= B6;
				B7:
					if(enable_flag)
						state <= PARITY;
					else
						state <= B7;
				PARITY:
					if(enable_flag)
						state <= STOP;
					else
						state <= PARITY;
				STOP:
					if(enable_flag)
						state <= IDLE;
					else
						state <= STOP;
				
				default:		
					state <= IDLE;
			endcase
end



always_comb begin
	enable_half_w = 1'b0;
	enable_max_w = 1'b0;
	case(state)
		IDLE: 
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b0;
				dataReceived_bit = 1'b0;
			end
		START:
			begin
				enable_half_w = 1'b1;
				enable_max_w = 1'b0;
				dataReceived_bit = 1'b1;
			end
		B0:
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		B1:
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		B2:	
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		B3:	
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		B4:
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		B5:	
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		B6:
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		B7:	
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		PARITY:
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		STOP:	
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b1;
				dataReceived_bit = 1'b1;
			end
		default: 
			begin
				enable_half_w = 1'b0;
				enable_max_w = 1'b0;
			end
	endcase

end


assign enable_half = enable_half_w;
assign enable_max = enable_max_w;
assign dataReceived = dataReceived_bit;
endmodule
