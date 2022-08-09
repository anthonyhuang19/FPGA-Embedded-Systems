module experiment8_2
(
	input clk,
	input clear,
	output [7:0] red,
	output [7:0] green,
	output [7:0] blue,
	output head_syn,
	output dst_syn,
	output clock,
	output empty,
	output sync
);
   
assign sync = 0;
				
clkgen #(25000000) my_vgaclks(clk,clear,1'b1,clock);

wire [3:0] r,g,b;
wire [9:0] head_address;
wire [9:0] v_address;

ram_memory memory
(
	.clk(clock),
	.address({head_address,v_address[8:0]}),
	.red(r),
	.green(g),
	.blue(b)
);
	
	
vga_ctrl VGA
(
 .pclk(clock), 
 .reset(clear), 
 .vga_data({r,4'b0000,g,4'b0000,b,4'b0000}), 
 .h_addr(head_address), 
 .v_addr(v_address),
 .hsync(head_syn),  
 .vsync(dst_syn),
 .valid(empty), 
 .vga_r(red), 
 .vga_g(green),
 .vga_b(blue)
);	

endmodule 