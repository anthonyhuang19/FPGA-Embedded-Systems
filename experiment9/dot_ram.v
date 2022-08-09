module dot_ram
(
	input clk,
	input re,
	input [11:0]outaddr,
	output [11:0]dout
);

reg [11:0] ram [4095:0];

initial
begin
	$readmemh("C:/Users/Anthony Huang/Desktop/experiment9/vga_font.txt",ram,0,4095);
end

assign dout=ram[outaddr];
endmodule
