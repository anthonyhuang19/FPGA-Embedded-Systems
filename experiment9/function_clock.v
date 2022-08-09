module function_clock
(
	input clk,
	output clk_5
);
	reg clk_div;
	assign clk_5=clk_div;
reg [24:0]count_clk;
initial 
begin
clk_div=0;
count_clk=0;
end
always @(posedge clk)
begin
	if(count_clk==3600000)
	begin
		count_clk<=0;
		clk_div<=~clk_div;
	end
	else count_clk<=count_clk+1;
end
endmodule