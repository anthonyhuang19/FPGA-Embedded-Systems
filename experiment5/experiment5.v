module experiment5
(
	input clk,
	input we,
	input [3:0]inaddr,
	input [3:0]outaddr,
	input [7:0]din,
	output  [7:0]dout
);
reg [7:0] memory[15:0];
initial
begin
	$readmemh("memory.txt",memory, 0, 15);
end

always @(posedge clk)
begin
	if(we)
   begin
		memory[inaddr] <= din;
   end
end
assign dout = memory[outaddr];

ramport ram(.clock(clk),.data(din),.rdaddress(outaddr),.wraddress(inaddr),.wren(we),.q());
endmodule