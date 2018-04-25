module debouncer(
	// Input Ports
	input clk,
	input rst,
	input sw,
	
	// Output Ports
	output reg one_shot
);

enum logic [1:0] {ini, shot, off1} estado;

/*------------------------------------------------------------------------------------------*/
/*Asignacion de estado*/

always_ff @ (posedge rst, posedge clk) begin
	if(rst)
		estado <= ini;
	else
		case(estado)
		
			ini: 
				if(sw)
					estado <= shot;
				
			shot: 
					estado <= off1;
			
			off1: 
				if(~sw)
					estado <= ini;
					
		default: 
				estado <= ini;
				
		endcase
end
		
/*------------------------------------------------------------------------------------------*/
/*Salida de control, proceso combintorio*/
always_comb begin
		case(estado)
			ini: 
				one_shot <= 'b0;
				
			shot: 
				one_shot <= 'b1;
				
			off1: 
				one_shot <= 'b0;
				
		default: 
				one_shot <= 'b0;
		
		endcase
end
	
endmodule 