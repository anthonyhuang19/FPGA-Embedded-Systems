module keyboard(input clk,
	input clrn,
	input ps2_clk,
	input ps2_data,
	output reg [7:0] key_count,
	output reg [7:0] cur_key,
	output [7:0] ascii_key);

// add your definitions here
reg[7:0]last_last_data;
reg[7:0]last_last_last_data;
reg[7:0]last_data;
wire[7:0]data;
reg [0:0]nextdata_n;
wire ready;
//----DO NOT CHANGE BEGIN----
//scancode to ascii conversion, will be initialized by the testbench
scancode_ram myram(clk, cur_key, ascii_key);
//PS2 interface, you may need to specify the inputs and outputs
ps2_keyboard mykey(clk, clrn, ps2_clk, ps2_data, data, ready, nextdata_n, overflow);
//---DO NOT CHANGE END-----
always@(posedge ps2_clk)begin
    if(clrn==0)
    begin
    cur_key<=0;
    last_data<=0;
    last_last_data<=0;
    last_last_last_data<=0;
    key_count<=0;
    end
    else if(ready==1&&data==8'b11110000)
    begin
        cur_key<=0;
        last_data<=data;
        last_last_data<=last_data;
        last_last_last_data<=last_last_data;
        nextdata_n<=0;
    end
    else if(ready==1&&last_data==8'b11110000)
    begin
        nextdata_n<=1;
        last_data<=data;
        last_last_data<=last_data;
        last_last_last_data<=last_last_data;
    end 
    else if(ready==1)
    begin
        cur_key<=data;
        if(data!=last_data)
            key_count<=key_count+1;
        else if(data==last_data&&last_last_last_data==8'b11110000)
            key_count<=key_count+1;
        last_data<=data;
        last_last_data<=last_data;
        last_last_last_data<=last_last_data;
        nextdata_n<=0;
    end
    if(nextdata_n==0)
    begin
        nextdata_n<=1;
    end
    
end
endmodule