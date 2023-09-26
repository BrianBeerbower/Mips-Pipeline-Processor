module Project4(Aselect,Bselect,Dselect,clk,abus,bbus,dbus);
input [31:0] Aselect,Bselect,Dselect,dbus;
input clk;
output [31:0] abus,bbus;

//mem0(Aselect[0],Bselect[0],Dselect[0],clk,abus,bbus,dbus)
mem0 m0(Aselect[0],Bselect[0],Dselect[0],clk,abus,bbus,dbus);
//mem32(Aselect,Bselect,Dselect,clk,abus,bbus,dbus)
mem32 m1(Aselect[1],Bselect[1],Dselect[1],clk,abus,bbus,dbus);
mem32 m2(Aselect[2],Bselect[2],Dselect[2],clk,abus,bbus,dbus);
mem32 m3(Aselect[3],Bselect[3],Dselect[3],clk,abus,bbus,dbus);
mem32 m4(Aselect[4],Bselect[4],Dselect[4],clk,abus,bbus,dbus);
mem32 m5(Aselect[5],Bselect[5],Dselect[5],clk,abus,bbus,dbus);
mem32 m6(Aselect[6],Bselect[6],Dselect[6],clk,abus,bbus,dbus);
mem32 m7(Aselect[7],Bselect[7],Dselect[7],clk,abus,bbus,dbus);
mem32 m8(Aselect[8],Bselect[8],Dselect[8],clk,abus,bbus,dbus);
mem32 m9(Aselect[9],Bselect[9],Dselect[9],clk,abus,bbus,dbus);
mem32 m10(Aselect[10],Bselect[10],Dselect[10],clk,abus,bbus,dbus);
mem32 m11(Aselect[11],Bselect[11],Dselect[11],clk,abus,bbus,dbus);
mem32 m12(Aselect[12],Bselect[12],Dselect[12],clk,abus,bbus,dbus);
mem32 m13(Aselect[13],Bselect[13],Dselect[13],clk,abus,bbus,dbus);
mem32 m14(Aselect[14],Bselect[14],Dselect[14],clk,abus,bbus,dbus);
mem32 m15(Aselect[15],Bselect[15],Dselect[15],clk,abus,bbus,dbus);
mem32 m16(Aselect[16],Bselect[16],Dselect[16],clk,abus,bbus,dbus);
mem32 m17(Aselect[17],Bselect[17],Dselect[17],clk,abus,bbus,dbus);
mem32 m18(Aselect[18],Bselect[18],Dselect[18],clk,abus,bbus,dbus);
mem32 m19(Aselect[19],Bselect[19],Dselect[19],clk,abus,bbus,dbus);
mem32 m20(Aselect[20],Bselect[20],Dselect[20],clk,abus,bbus,dbus);
mem32 m21(Aselect[21],Bselect[21],Dselect[21],clk,abus,bbus,dbus);
mem32 m22(Aselect[22],Bselect[22],Dselect[22],clk,abus,bbus,dbus);
mem32 m23(Aselect[23],Bselect[23],Dselect[23],clk,abus,bbus,dbus);
mem32 m24(Aselect[24],Bselect[24],Dselect[24],clk,abus,bbus,dbus);
mem32 m25(Aselect[25],Bselect[25],Dselect[25],clk,abus,bbus,dbus);
mem32 m26(Aselect[26],Bselect[26],Dselect[26],clk,abus,bbus,dbus);
mem32 m27(Aselect[27],Bselect[27],Dselect[27],clk,abus,bbus,dbus);
mem32 m28(Aselect[28],Bselect[28],Dselect[28],clk,abus,bbus,dbus);
mem32 m29(Aselect[29],Bselect[29],Dselect[29],clk,abus,bbus,dbus);
mem32 m30(Aselect[30],Bselect[30],Dselect[30],clk,abus,bbus,dbus);
mem32 m31(Aselect[31],Bselect[31],Dselect[31],clk,abus,bbus,dbus);
endmodule



module ff(clk,d,q);
input [31:0] d;
input clk;
output [31:0] q;
reg [31:0] q;
always@(negedge clk)
begin
q=d;
end
endmodule



module tristate(enable,inbus,outbus);
input enable;
input [31:0] inbus;
output [31:0] outbus;
reg [31:0] outbus;
always @ (*)
	begin
	if (enable == 1'b1)
	begin
		outbus = inbus;
	end
	else
	begin
		outbus = 32'bz;
	end
end
endmodule



module mem0(Aselect,Bselect,Dselect,clk,abus,bbus,dbus);
input [31:0] dbus;
input Aselect,Bselect,Dselect,clk;
output [31:0] abus,bbus;
wire [31:0] qbus;
wire clk1;
assign clk1 = Dselect & clk;
//ff(clk,d,q)
ff ff1(clk1,dbus,qbus);
//tristate(enable,inbus,outbus)
tristate ta1(Aselect,32'b0,abus);
tristate tb1(Bselect,32'b0,bbus);
endmodule 



module mem32(Aselect,Bselect,Dselect,clk,abus,bbus,dbus);
input [31:0] dbus;
input Aselect,Bselect,Dselect,clk;
output [31:0] abus,bbus;
wire [31:0] qbus;
wire clk1;
assign clk1 = Dselect & clk;
//ff(clk,d,q)
ff ff1(clk1,dbus,qbus);
//tristate(enable,inbus,outbus)
tristate ta1(Aselect,qbus,abus);
tristate tb1(Bselect,qbus,bbus);
endmodule 