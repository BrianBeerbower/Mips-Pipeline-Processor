module Project7(ibus,clk,daddrbus,databus);
input [31:0] ibus;
input clk;
output [31:0] databus;
output [31:0] daddrbus;
wire [31:0] abus,bbus;
//module Project6(ibus,clk,abus,bbus,dbus,Databus);
Project6 p1(ibus,clk,abus,bbus,daddrbus,databus);
endmodule
