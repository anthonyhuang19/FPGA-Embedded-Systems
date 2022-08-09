module experiment4(
	input  clk,
	input  en,
	input  rst,
	input  paused,
	output reg [6:0] F1,
	output reg [6:0] F2,
	output reg rco
);
// add your code here
integer count_clk=0;
integer clk_1s=0;
integer first_number=0;
integer second_number=0;
integer counting_number=0;//counting number until 99
integer flag;
initial 
begin
	flag=1;
	second_number=1;
	first_number=1;
end
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
		rco=0;
		if(en==0)
		begin
			second_number=255;
			first_number=255;
			counting_number=0;
			flag =1;
		end
		else if(en ==1 && flag)
		begin
			second_number=0;
			first_number=0;
			counting_number=0;
			flag=0;
		end
		else
		begin
			if(paused)
			begin
				first_number=first_number;
				second_number=second_number;
				counting_number=counting_number;
			end
			else if(rst)
			begin
				first_number=0;
				second_number=0;
				counting_number=0;
				rco=0;
			end
			else
			begin
				if(counting_number==99)
				begin
					rco=1;
					counting_number=(counting_number+1)%100;
					
				end
				else
				begin
					rco=0;
					counting_number=(counting_number+1)%100;
				end
			end
			//make decimal number
			if(counting_number < 100)
			begin
				first_number  = counting_number/10;
				second_number = counting_number%10;
			end
			else if(counting_number <= 100)
			begin
				second_number=0;
				first_number =0;
			end	
		end
		case(first_number)
			0: F1 = 7'b1000000;
			1: F1 = 7'b1111001;
			2: F1 = 7'b0100100;
			3: F1 = 7'b0110000;
			4: F1 = 7'b0011001;
			5: F1 = 7'b0010010;
			6: F1 = 7'b0000010;
			7: F1 = 7'b1111000;
			8: F1 = 7'b0000000;
			9: F1 = 7'b0010000;
		default:F1=7'b1111111;
		endcase
		case(second_number)
			0: F2 = 7'b1000000;
			1: F2 = 7'b1111001;
			2: F2 = 7'b0100100;
			3: F2 = 7'b0110000;
			4: F2 = 7'b0011001;
			5: F2 = 7'b0010010;
			6: F2 = 7'b0000010;
			7: F2 = 7'b1111000;
			8: F2 = 7'b0000000;
			9: F2 = 7'b0010000;
		default:F2=7'b1111111;
		endcase
	end
endmodule









