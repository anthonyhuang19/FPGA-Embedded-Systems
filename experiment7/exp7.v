module exp7(
		          		
	input CLOCK,		          		     
	input SW,		    
	output [6:0]HEX0,		   
	output [6:0]HEX1,
	output [6:0]HEX2,		    
	output [6:0]HEX3,
	output [6:0]HEX4,
	output [6:0]HEX5,
	inout PS2_CLK,
	inout PS2_CLK2,
	inout PS2_DAT,
	inout PS2_DAT2
);
wire [7:0]ascii_key;
wire [7:0]cur_key;
wire [7:0]key_count;


keyboard my_board(CLOCK,SW,PS2_CLK,PS2_DAT,key_count,cur_key,ascii_key);
bcd my_bcd1(cur_key[3:0],HEX0[6:0]);
bcd my_bcd2(cur_key[7:4],HEX1[6:0]);
bcd my_bcd3(ascii_key[3:0],HEX2[6:0]);
bcd my_bcd4(ascii_key[7:4],HEX3[6:0]);
bcd my_bcd5(key_count[3:0],HEX4[6:0]);
bcd my_bcd6(key_count[7:4],HEX5[6:0]);

endmodule
