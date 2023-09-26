//Brian Beerbower

module Project5(ibus,clk,Aselect,Bselect,Dselect,Imm,S,Cin);
input clk;
input [31:0] ibus;
output [31:0] Aselect,Bselect,Dselect;
output Imm,Cin;
output [2:0] S;

wire [31:0] ibus0;
wire [31:0] Dselect0;
wire [31:0] Dselect1;
wire Imm0,Cin0;
wire [2:0] S0;
//module ff32(clk,in,out);
ff32 a1(clk,ibus,ibus0);
//module op(ibus,Imm,Cin,S);
op d1(ibus0,Imm0,Cin0,S0);
//decoder5to32(in,out); 
decoder5to32 b1(ibus0[25:21],Aselect);
decoder5to32 b2(ibus0[20:16],Bselect);
decoder5to32 b3(ibus0[15:11],Dselect0);
//module mux2to1x32(A,B,S,Q);
mux2to1x32 c1(Bselect,Dselect0,Imm0,Dselect1);
//module ff32(clk,in,out);
ff32 a2(clk,Dselect1,Dselect);
//module ff5(clk,Iin,Sin,Cin,Iout,Sout,Cout);
ff5 g1(clk,Imm0,S0,Cin0,Imm,S,Cin);
endmodule



module ff32(clk,in,out);
input clk; 
input [31:0] in;
output reg [31:0] out;

always @ (posedge clk)
begin 
out=in;
end
endmodule



module ff5(clk,Iin,Sin,Cin,Iout,Sout,Cout);
input Iin,Cin,clk;
input [2:0] Sin;
output reg Iout,Cout;
output reg [2:0] Sout;

always @ (posedge clk)
begin
Iout = Iin;
Cout = Cin;
Sout = Sin;
end
endmodule


module decoder5to32(in,out); 
input [4:0] in;
output reg [31:0] out;

always @ (*)
begin
case(in)
5'b00000:out = 32'h1;
5'b00001:out = 32'h2;
5'b00010:out = 32'h4;
5'b00011:out = 32'h8;
5'b00100:out = 32'h10;
5'b00101:out = 32'h20;
5'b00110:out = 32'h40;
5'b00111:out = 32'h80;
5'b01000:out = 32'h100;
5'b01001:out = 32'h200;
5'b01010:out = 32'h400;
5'b01011:out = 32'h800;
5'b01100:out = 32'h1000;
5'b01101:out = 32'h2000;
5'b01110:out = 32'h4000;
5'b01111:out = 32'h8000;

5'b10000:out = 32'h10000;
5'b10001:out = 32'h20000;
5'b10010:out = 32'h40000;
5'b10011:out = 32'h80000;
5'b10100:out = 32'h100000;
5'b10101:out = 32'h200000;
5'b10110:out = 32'h400000;
5'b10111:out = 32'h800000;
5'b11000:out = 32'h1000000;
5'b11001:out = 32'h2000000;
5'b11010:out = 32'h4000000;
5'b11011:out = 32'h8000000;
5'b11100:out = 32'h10000000;
5'b11101:out = 32'h20000000;
5'b11110:out = 32'h40000000;
5'b11111:out = 32'h80000000;
default:out = 32'h0;
endcase
end
endmodule 



module op(ibus,Imm,Cin,S);
input [31:0] ibus;
output reg Imm,Cin;
output reg [2:0] S;

wire I;

always @ (*)
begin 

if(ibus[31:26] == 6'b000000)
begin
if(ibus[5:0] == 6'b000011) begin S=3'b010; Imm = 0; Cin = 0; end //add
else if(ibus[5:0] == 6'b000010) begin S=3'b011; Imm = 0; Cin = 1; end //sub
else if(ibus[5:0] == 6'b000001) begin S=3'b000; Imm = 0; Cin = 0; end //xor
else if(ibus[5:0] == 6'b000111) begin S=3'b110; Imm = 0; Cin = 0; end //and
else if(ibus[5:0] == 6'b000100) begin S=3'b100; Imm = 0; Cin = 0; end //or
else S=3'b111;
end

else
begin
if(ibus[31:26] == 6'b000011) begin S=3'b010; Imm = 1; Cin = 0; end //add
else if(ibus[31:26] == 6'b000010) begin S=3'b011; Imm = 1; Cin = 1; end //sub
else if(ibus[31:26] == 6'b000001) begin S=3'b000; Imm = 1; Cin = 0; end //xor
else if(ibus[31:26] == 6'b001111) begin S=3'b110; Imm = 1; Cin = 0; end //and
else if(ibus[31:26] == 6'b001100) begin S=3'b100; Imm = 1; Cin = 0; end //or
else S=3'b111;
end

end
endmodule

module mux2to1x32(A,B,S,Q);
input [31:0]A,B;
input S;
output reg [31:0]Q;

always@(*)
begin 
case(S)
1'b0:Q=B;
1'b1:Q=A;
endcase
end
endmodule