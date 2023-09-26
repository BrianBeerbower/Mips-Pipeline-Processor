//Written By Brian Beerbower
//Written On 1/25/2023
module project2a(a,b,d,S,V,Cin,Cout);
input [31:0] a,b;
output [31:0] d;
input [2:0] S;
output Cout, V;
input Cin;
wire [31:0] Cint,g,p;

//module alu2a(a,b,sum,sel,g,p,Cin,Cout);
alu2a a0(a[0],b[0],d[0],S,g[0],p[0],Cin,Cint[1]);
alu2a a1(a[1],b[1],d[1],S,g[1],p[1],Cint[1],Cint[2]);
alu2a a2(a[2],b[2],d[2],S,g[2],p[2],Cint[2],Cint[3]);
alu2a a3(a[3],b[3],d[3],S,g[3],p[3],Cint[3],Cint[4]);
alu2a a4(a[4],b[4],d[4],S,g[4],p[4],Cint[4],Cint[5]);
alu2a a5(a[5],b[5],d[5],S,g[5],p[5],Cint[5],Cint[6]);
alu2a a6(a[6],b[6],d[6],S,g[6],p[6],Cint[6],Cint[7]);
alu2a a7(a[7],b[7],d[7],S,g[7],p[7],Cint[7],Cint[8]);
alu2a a8(a[8],b[8],d[8],S,g[8],p[8],Cint[8],Cint[9]);
alu2a a9(a[9],b[9],d[9],S,g[9],p[9],Cint[9],Cint[10]);
alu2a a10(a[10],b[10],d[10],S,g[10],p[10],Cint[10],Cint[11]);
alu2a a11(a[11],b[11],d[11],S,g[11],p[11],Cint[11],Cint[12]);
alu2a a12(a[12],b[12],d[12],S,g[12],p[12],Cint[12],Cint[13]);
alu2a a13(a[13],b[13],d[13],S,g[13],p[13],Cint[13],Cint[14]);
alu2a a14(a[14],b[14],d[14],S,g[14],p[14],Cint[14],Cint[15]);
alu2a a15(a[15],b[15],d[15],S,g[15],p[15],Cint[15],Cint[16]);
alu2a a16(a[16],b[16],d[16],S,g[16],p[16],Cint[16],Cint[17]);
alu2a a17(a[17],b[17],d[17],S,g[17],p[17],Cint[17],Cint[18]);
alu2a a18(a[18],b[18],d[18],S,g[18],p[18],Cint[18],Cint[19]);
alu2a a19(a[19],b[19],d[19],S,g[19],p[19],Cint[19],Cint[20]);
alu2a a20(a[20],b[20],d[20],S,g[20],p[20],Cint[20],Cint[21]);
alu2a a21(a[21],b[21],d[21],S,g[21],p[21],Cint[21],Cint[22]);
alu2a a22(a[22],b[22],d[22],S,g[22],p[22],Cint[22],Cint[23]);
alu2a a23(a[23],b[23],d[23],S,g[23],p[23],Cint[23],Cint[24]);
alu2a a24(a[24],b[24],d[24],S,g[24],p[24],Cint[24],Cint[25]);
alu2a a25(a[25],b[25],d[25],S,g[25],p[25],Cint[25],Cint[26]);
alu2a a26(a[26],b[26],d[26],S,g[26],p[26],Cint[26],Cint[27]);
alu2a a27(a[27],b[27],d[27],S,g[27],p[27],Cint[27],Cint[28]);
alu2a a28(a[28],b[28],d[28],S,g[28],p[28],Cint[28],Cint[29]);
alu2a a29(a[29],b[29],d[29],S,g[29],p[29],Cint[29],Cint[30]);
alu2a a30(a[30],b[30],d[30],S,g[30],p[30],Cint[30],Cint[31]);
alu2a a31(a[31],b[31],d[31],S,g[31],p[31],Cint[31],Cout);
assign V = Cout ^ Cint[31];
endmodule



module alu2a(a,b,sum,sel,g,p,Cin,Cout);
input a,b,Cin;
input [2:0] sel;
output sum,g,p,Cout;
reg sum;
wire bint,cint;

assign bint = b ^ sel[0];
assign cint = Cin & sel[1];
assign g = a & bint;
assign p = a ^ bint;
assign Cout = a&bint|Cin&(a^bint);


always @ (*)
begin
case (sel)
	3'b000: sum = a^b;
	3'b001: sum = ~(a^b);
	3'b010: sum = p^cint;
	3'b011: sum = p^cint;
	3'b100: sum = a|b;
	3'b101: sum = ~(a|b);
	3'b110: sum = a&b;
	default: sum = 1'b0;
endcase
end
endmodule
