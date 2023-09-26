module Project6(ibus,clk,abus,bbus,dbus);
input [31:0]ibus;
input clk;
output [31:0] abus,bbus,dbus;

wire [31:0] Aselect,Bselect,Dselect,Immbus,Immbus1,abus0,bbus0,bbus1,Dselect0,Dselect1,ibus0,dbus2,Dselect2;
wire [2:0] S,S0;
wire Imm,Cin,V,Cout,Imm0,Cin0;
//module ff32(clk,in,out);
ff32 ff1(clk,ibus,ibus0);
//module op(ibus,Imm,Cin,S);
op d1(ibus0,Imm0,Cin0,S0);

//decoder5to32(in,out); 
decoder5to32 b1(ibus0[25:21],Aselect);
decoder5to32 b2(ibus0[20:16],Bselect);
decoder5to32 b3(ibus0[15:11],Dselect0);

//module ff5(clk,Iin,Sin,Cin,Iout,Sout,Cout);
ff5 g1(clk,Imm0,S0,Cin0,Imm,S,Cin);

//module mux2to1x32(bbus0,Immbus,Imm,bbus);
mux2to1x32 mux2(Dselect0,Bselect,~Imm0,Dselect1);

//module signExt(in,out);0
signExt se1(ibus0[15:0],Immbus);

//module Project4(Aselect,Bselect,Dselect,clk,abus,bbus,dbus);
Project4 RegFile1(Aselect,Bselect,Dselect2,clk,abus0,bbus0,dbus2);


//module ff5(clk,Iin,Sin,Cin,Iout,Sout,Cout);
ff5 walls(clk,Imm0,S0,Cin0,Imm,S,Cin);
//module ff32(clk,in,out);
ff32 walld(clk,Dselect1,Dselect2);
//module ff32(clk,in,out);
ff32 walla(clk,abus0,abus);
//module ff32(clk,in,out);
ff32 wallb(clk,bbus0,bbus1);
//module ff32(clk,in,out);
ff32 wallimm(clk,Immbus,Immbus1);




//module mux2to1x32(bbus0,Immbus,Imm,bbus);
mux2to1x32 mux1(bbus1,Immbus1,~Imm,bbus);

//module project2b(a,b,d,S,V,Cin,Cout);
project2b alu1(abus,bbus,dbus2,S,V,Cin,Cout);

//module ff32(clk,in,out);
ff32 ff2(clk,dbus2,dbus);

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