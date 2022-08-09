module vga_gen(
	input clk,
	input reset,
	input rst,
	output hsync,       				
	output vsync, 	    
	output valid,      
	output [3:0] vga_r, 
	output [3:0] vga_g,
	output [3:0] vga_b,
	output vga_clk,
	input [7:0] ascdata,
	input [11:0]count,
	input we,
	input [11:0]cur,
	input [2:0]colo
);
reg [11:0]vga_data;
wire [9:0] h_addr;   
wire [9:0] v_addr;
wire [18:0]readaddr;
assign readaddr[18:9]=h_addr[9:0];
assign readaddr[8:0]=v_addr[8:0];
clkgen #(25000000) my_vgaclk(clk,1'b0,1'b1,vga_clk);
vga_ctrl ctr1(vga_clk,0,vga_data[11:0],h_addr,v_addr,hsync,vsync,valid,vga_r[3:0],vga_g[3:0],vga_b[3:0]);

wire [11:0] asc_x;
wire [11:0] asc_y;
wire [3:0] x_dot;
wire [3:0] y_dot;
assign asc_x=v_addr>>4;
assign x_dot=v_addr[3:0];
assign y_dot=h_addr%9;
assign asc_y=h_addr/9;

wire [11:0] asc_addr;
assign asc_addr=asc_x*71+asc_y;

wire [7:0]asc;
ascii_ram asc_read(
	.clk(clk),
	.we(we),
	.inaddr(count),
	.din(ascdata),
	.outaddr(asc_addr),
	.dout(asc)
);

wire [11:0]dot;
wire [11:0]dotaddr;
assign dotaddr={asc[7:0],x_dot[3:0]};

dot_ram dot_read(
	.clk(clk),
	.re(1),
	.outaddr(dotaddr),
	.dout(dot)
);
reg [11:0]co=12'b100010001000;
always @(posedge clk) begin
	if(colo[0])  co[3:0]<=4'b1000;
	else co[3:0]<=0;
	if(colo[1]) co[7:4]<=4'b1000;
	else co[7:4]<=0;
	if(colo[2]) co[11:8]<=4'b1000;
	else co[11:8]<=0;
end

always @(posedge clk) begin
	if(asc_addr==cur)
		vga_data<=co;
	else if(dot[y_dot[3:0]]==0)
		vga_data<=0;
	else 
		vga_data<=co;
end
endmodule

