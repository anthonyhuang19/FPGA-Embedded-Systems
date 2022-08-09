module experiment2(
	input  [7:0] X,
	input  en,
	output reg valid,
	output reg[6:0] F
	);
integer i;
    always @ (X or en)
    begin
        if(X) valid =1;
        else valid =0;
        if(en)
		  begin
				F=7'b1111111;
				for(i =0; i < 8;i=i+1)
					if(X[i]==1) F=i;
            case(F)
					 0:  F =7'b1000000;
					 1 : F =7'b1111001;
                2 : F =7'b0100100;
                3 : F =7'b0110000;
                4 : F =7'b0011001;
                5 : F =7'b0010010;
                6 : F =7'b0000010;
                7 : F =7'b1111000;
			    default : F=7'b1111111;
        	    endcase
        end
		  else F=7'b1111111;
    end
endmodule