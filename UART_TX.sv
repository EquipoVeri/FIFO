module UART_TX(
    input clk,
    input rst,
    input [7:0] In,
    input enable,
    output reg Q
);

enum reg [3:0] {espera, startBit, Bit0, Bit1, Bit2, Bit3, Bit4, Bit5, Bit6, Bit7, paridad, stopBit} estado;	

wire paridad_w = In[0]^In[1]^In[2]^In[3]^In[4]^In[5]^In[6]^In[7];
wire iguales_w;
wire enable_w;
wire fin_delay;

Counter_TX countertx(.clk(clk),.rst(rst),.iguales(iguales_w));

debouncer debo(.clk(iguales_w),.rst(rst),.sw(enable),.one_shot(enable_w));

always @(posedge rst, posedge iguales_w)
	begin
	if(rst)
	 estado <= espera;
	else 
		begin
		case (estado)
		espera: 
			begin
			if(enable_w)
				estado <= startBit;
			else 
				estado <= espera;
			end
		startBit:
			estado <= Bit0;
		Bit0:
			estado <= Bit1;
		Bit1:
			estado <= Bit2;
		Bit2:
			estado <= Bit3;
		Bit3:
			estado <= Bit4;
		Bit4:
			estado <= Bit5;
		Bit5:
			estado <= Bit6;
		Bit6:
			estado <= Bit7;
		Bit7:
			estado <= paridad;
		paridad:
			estado <= stopBit;
		stopBit :
			estado <= espera;
		default:
			estado <= espera;
		endcase
		end
	end

always @ (estado or In or paridad_w)
	begin
	case (estado)
		espera: Q <= 1'b1;
		startBit: Q <= 1'b0;
		Bit0:	Q <= In[0];
		Bit1:	Q <= In[1];
		Bit2:	Q <= In[2];
		Bit3:Q <= In[3];
		Bit4:Q <= In[4];
		Bit5:Q <= In[5];
		Bit6:Q <= In[6];
		Bit7:Q <= In[7];
		paridad:Q <= paridad_w;
		stopBit: Q <= 1'b1;
		default: Q <= 1'b0x;
	endcase
	end		

                                                                                                                                              
endmodule 