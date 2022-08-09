module experiment6
(
	input reset,
	input clk,
	input[7:0]seed,
	input load,
	output reg [6:0]F1,
	output reg [6:0]F2
);
reg[7:0] dout;
integer count_clk =0;
integer clk_1s =0;
reg temp;
reg [3:0]high;
reg [3:0]low;


always @(posedge clk)
begin
	if(count_clk==24999999)
	begin
	count_clk <=0;
	clk_1s <= ~clk_1s;
	end
 	else count_clk <= count_clk+1;
end

always@(posedge clk_1s)
begin
	if(reset ==1) 
		dout =0;
	else if(load==1)
		dout= seed;
	else
	begin
		temp =dout[4]^dout[3]^dout[2]^dout[0];
		dout={temp,dout[7:1]};
	end
	
	low  =dout[3:0];
	high =dout[7:4];
	case(high)
	0: F1 = 7'b1000000;
	1: F1  = 7'b1111001;
	2: F1  = 7'b0100100;
	3:	F1  = 7'b0110000;
	4:	F1  = 7'b0011001;
	5: F1  = 7'b0010010;
	6: F1  = 7'b0000010;
	7: F1  = 7'b1111000;
	8:	F1  = 7'b0000000;
	9: F1  = 7'b0010000;
	10:F1  = 7'b0001000;
	11:F1  = 7'b0000011;
	12:F1  = 7'b1000110;
	13:F1  = 7'b0100001;
	14:F1  = 7'b0000110;
	15:F1  = 7'b0001110;
	default: F1 =7'b1111111;
	endcase
	
	case(low)
	0: F2 = 7'b1000000;
	1: F2  = 7'b1111001;
	2: F2  = 7'b0100100;
	3:	F2  = 7'b0110000;
	4:	F2  = 7'b0011001;
	5: F2  = 7'b0010010;
	6: F2  = 7'b0000010;
	7: F2  = 7'b1111000;
	8:	F2  = 7'b0000000;
	9: F2  = 7'b0010000;
	10:F2  = 7'b0001000;
	11:F2  = 7'b0000011;
	12:F2  = 7'b1000110;
	13:F2  = 7'b0100001;
	14:F2  = 7'b0000110;
	15:F2  = 7'b0001110;
	default: F2 =7'b1111111;
	endcase
	
end
endmodule