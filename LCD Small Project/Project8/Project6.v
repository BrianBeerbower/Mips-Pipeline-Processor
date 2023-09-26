module Project6(ibus,clk,abus,bbus,dbus,Databus,reset,iaddrbus);
input [31:0]ibus;
input clk,reset;
output [31:0] iaddrbus;
output [31:0] abus,bbus,dbus;
inout [31:0] Databus;

wire [31:0] Aselect,Bselect,Dselect,Immbus,Immbus1,abus0,bbus0,bbus1,bbus2,Dselect0,Dselect1,Dselect3,Dselect4,ibus0,dbus0,dbus1,dbus2,dbus3,LWbus,SWbus,Dselect2,LWbus1,pc,pc0,pc1,pc2,shift;
wire [2:0] S,S0;
wire Imm,Cin,V,Cout,Imm0,Cin0,LW0,SW0,LW,SW,LW1,SW1,LW2,BEQ,BNE,BEQ1,BNE1,BEQ2,BNE2,Branch0,Branch1,DEN,reset1,reset2;
reg Zero;
wire v1,cout1,v2,cout2;

//module ff1bit(clk,in,out);
ff1bit ff1bit1(clk,reset,reset1);
ff1bit ff1bit2(clk,reset1,reset2);
//module pcff(clk,reset,in,out);
pcff pcff0(clk,reset2,pc,iaddrbus);

//module project2b(a,b,d,S,V,Cin,Cout);
project2b pcadd1(32'd4,iaddrbus,pc0,3'b010,v1,1'b0,cout1);

ff32 pcff1(clk,pc0,pc1);

assign shift= Immbus<<2;

//module project2b(a,b,d,S,V,Cin,Cout);
project2b pcadd2(shift,pc1,pc2,3'b010,v2,1'b0,cout2);

mux2to1x32 mux0(pc0,pc2,Branch1,pc);

//module ff32(clk,in,out);
ff32 ifid1(clk,ibus,ibus0);
//module op(ibus,Imm,Cin,S,LW,SW,BEQ,BNE);
op d1(ibus0,Imm0,Cin0,S0,LW0,SW0,BEQ,BNE);

//decoder5to32(in,out); 
decoder5to32 b1(ibus0[25:21],Aselect);
decoder5to32 b2(ibus0[20:16],Bselect);
decoder5to32 b3(ibus0[15:11],Dselect0);

//module signExt(in,out);0
signExt se1(ibus0[15:0],Immbus);

//module mux2to1x32(bbus0,Immbus,Imm,bbus);
mux2to1x32 mux2(Dselect0,Bselect,Imm0,Dselect1);

//module Project4(Aselect,Bselect,Dselect,clk,abus,bbus,dbus);
Project4 RegFile1(Aselect,Bselect,Dselect4,clk,abus0,bbus0,dbus3);

assign Branch0 = (BEQ & Zero)|(BNE&~Zero);

//module ff1bit(clk,in,out);
ff1bit br1(clk,Branch0,Branch1);
ff1bit br2(clk,BEQ,BEQ1);
ff1bit br3(clk,BEQ1,BEQ2);
ff1bit br4(clk,BNE,BNE1);
ff1bit br5(clk,BNE1,BNE2);


//module ff5(clk,Iin,Sin,Cin,LWin,SWin,Iout,Sout,Cout,LWout,SWout);
ff5 walls(clk,Imm0,S0,Cin0,LW0,SW0,Imm,S,Cin,LW,SW);
//module ff32(clk,in,out);
ff32 walld(clk,Dselect1,Dselect2);
//module ff32(clk,in,out);
ff32 walla(clk,abus0,abus);
//module ff32(clk,in,out);
ff32 wallb(clk,bbus0,bbus1);
//module ff32(clk,in,out);
ff32 wallimm(clk,Immbus,Immbus1);

//module mux2to1x32(bbus0,Immbus,Imm,bbus);
mux2to1x32 mux1(bbus1,Immbus1,Imm,bbus);

//module project2b(a,b,d,S,V,Cin,Cout);
project2b alu1(abus,bbus,dbus0,S,V,Cin,Cout);

//module ff32(clk,in,out);
ff32 ff2(clk,dbus0,dbus);

//module ff32(clk,in,out);
ff32 ff5(clk,bbus1,SWbus);

//module fflw(clk,LWin,LWout);
fflw exmem2(clk,SW,SW1);
fflw exmem3(clk,LW,LW1);
//tristate(enable,inbus,outbus)
tristate ts1(SW1,SWbus,Databus);
tristate tl1(LW1,Databus,LWbus);

//module ff32(clk,in,out);
ff32 exmem1(clk,Dselect2,Dselect3);
assign DEN = SW1|BEQ2|BNE2;
mux2to1x32 mux3(Dselect3,32'b0,DEN,Dselect4);

ff32 ff3(clk,dbus,dbus1);
ff32 ff4(clk,LWbus,LWbus1);
//module fflw(clk,LWin,LWout);
fflw memwb1(clk,LW1,LW2);
mux2to1x32 mux4(dbus1,LWbus1,LW2,dbus3);
always @(*)
begin
if (abus0==bbus0)begin Zero=1; end
else begin Zero = 0; end
end
endmodule



module signExt(in,out);
input [15:0]in;
output reg [31:0]out;

always @(*)
begin 
if (in[15]==1'b1)
begin
out[31:16] = 16'hffff;
out[15:0] = in;
end
else if (in[15]==1'b0)
begin
out[31:16] = 16'h0000;
out[15:0] = in;
end
else
begin
out[31:16] = 16'h0000;
out[15:0] = in;
end
end
endmodule 


module mux2to1x32(bbus0,Immbus,Imm,bbus);
input Imm;
input [31:0]Immbus,bbus0;
output reg [31:0]bbus;

always@(*)
begin
case(Imm)
1'b0:bbus=bbus0;
1'b1:bbus=Immbus;
endcase
end
endmodule 

module fflw(clk,LWin,LWout);
input clk,LWin;
output reg LWout;

always @ (posedge clk)
begin
LWout = LWin;
end
endmodule

module ff1bit(clk,in,out);
input clk,in;
output reg out;

always @ (posedge clk)
begin
out = in;
end
endmodule

module pcff(clk,reset,in,out);
input clk,reset;
input [31:0] in;
output reg [31:0] out;

always @ (posedge clk or posedge reset)
begin
if (reset == 1) begin out = 32'b0; end
else begin out = in; end
end
endmodule
