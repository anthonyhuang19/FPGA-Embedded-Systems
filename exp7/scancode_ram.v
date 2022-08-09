module scancode_ram(clk, addr,outdata);
input clk;
input [7:0] addr;
output reg [7:0] outdata;
//Do not change the name of this ram, testbench will initialize this
reg [7:0] ascii_tab[255:0];
initial
begin
$readmemh("C:/Users/Anthony Huang/Desktop/exp7/ascii.txt",ascii_tab, 0, 255);	
end
always @(posedge clk)
begin
      outdata <= ascii_tab[addr];
end

endmodule