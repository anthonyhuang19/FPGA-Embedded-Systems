module ram_memory
(
	input clk,
	input [18:0] address,
	output [3:0] red,
	output [3:0]green,
	output [3:0] blue
);

(* ram_init_file = "picture.mif" *) reg [11:0] rom [327680:0];
reg [11:0] temp;
always @(posedge clk)
begin
	temp <= rom[address];
end
assign red = temp[11:8];
assign green = temp[7:4];
assign blue = temp[3:0];

endmodule
