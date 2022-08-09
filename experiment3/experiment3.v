module experiment3( 
	input [3:0] A,
	input [3:0] B,
	input [2:0] ALUctr,
	output reg [3:0] F,
	output reg cf,
	output reg zero,
	output reg of
);

//add your code here

integer x,y;
reg [3:0] temp;
reg [4:0] tmp;
always@ (A or B or ALUctr)
begin 
	F=0;
	zero=0;
	of =0;
	cf =0;
	temp = B;
	tmp =0;
	case(ALUctr)
		0:
			begin
				{cf,F}=A+temp;
				of = (A[3]== temp[3]) && (F[3] != A[3]);
			end
		1:
			begin
				temp = ~B + 1;
				F= A+temp;
				tmp = A-B;
				cf = tmp[4];
				of = (A[3] ^ B[3]) & (A[3] ^ tmp[3]);
			end
		2: F = ~A;
		3: F = A & B;
		4: F = A | B;
		5: F = A ^ B;
		6:
			begin
				if(A[3]==1) x=A-16;
				else x =A;
				if(B[3] ==1) y=B-16;
				else y =B;
				if(x > y)F =1;
				else F=0;
			end
		7: 
			begin
				if(A == B) F = 1;
				else F =0;
			end
	endcase
    zero =~(| F);
end
endmodule