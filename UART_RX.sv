module UART_RX
(
    input clk,
    input reset,
    input rx,
	 output RxInterrupt,
    output [7:0] q,
    output paridad
);


wire [10:0] q_w;
wire enablemax_w;
wire enable_reg_w;
wire enablehalf_w;
wire flag_w;
wire rx_interrupt_w;

assign RxInterrupt = rx_interrupt_w;
assign paridad = q_w[1];
assign q = q_w[9:2];

shift_register_er u1
(
	.clk(clk),
	.reset(reset),
	.enable(flag_w),
	.d(rx),
	.q(q_w)
);
	 
UART_RX_FSM u2 
(
	.rx(rx),
	.clk(clk),
	.reset(reset),
	.enable_flag(flag_w),
	.dataReceived(rx_interrupt_w),
	.enable_max(enablemax_w),
	.enable_half(enablehalf_w)
);	 

CounterWithFunction_RX counter_rx
(
	.clk(clk),
	.reset(reset),
	.enable_max(enablemax_w),
	.enable_half(enablehalf_w),
	.flag(flag_w) 
);
	 
	 
endmodule
