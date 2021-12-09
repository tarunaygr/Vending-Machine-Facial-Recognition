module Vending_Machine1_tb_final;	
reg nickel,dime,quarter,clk,reset,choice;
wire [1:0]nickel_out,dime_out,quarter_out;
wire dispense1;
integer i;
integer check=1;
integer file,file2;
Vending_Machine1 m1(dime,nickel,quarter,nickel_out,quarter_out,dime_out,reset, clk, dispense1,choice);
initial begin
reset=0;clk=0;nickel=0;quarter=0;dime=0;
$monitor("clock=%b  dispense=%b  reset=%b  dime=%b  nickel=%b  quarter=%b nickel_out=%d dime_out=%d quarter_out=%d choice=%b",clk,dispense1,reset,dime,nickel,quarter,nickel_out,dime_out,quarter_out,choice);
choice=0;
#10 dime=0;nickel=1;quarter=0;
#10 dime=1;nickel=0;quarter=0;
#10 dime=1;nickel=0;quarter=0;
#10 dime=0;nickel=1;quarter=0;
#10 dime=0;nickel=1;quarter=0;
#10 dime=0;nickel=0;quarter=0;
#10 dime=0;nickel=1;quarter=0;
#10 dime=0;nickel=0;quarter=1;
#10 dime=0;nickel=0;quarter=1;
#10 dime=0;nickel=0;quarter=0;
#10 dime=0;nickel=0;quarter=1;
#10 dime=0;nickel=0;quarter=1;
#10 dime=0;nickel=0;quarter=0;
#10 choice=1;
#10 dime=0;nickel=1;quarter=0;
#10 dime=1;nickel=0;quarter=0;
#10 dime=1;nickel=0;quarter=0;
#10 dime=0;nickel=1;quarter=0;
#10 dime=0;nickel=0;quarter=0;
#10 dime=0;nickel=0;quarter=1;
#10 dime=1;nickel=0;quarter=0;
#10 dime=0;nickel=0;quarter=0;
#10 dime=0;nickel=0;quarter=1;
#10 dime=0;nickel=0;quarter=1;
#10 dime=0;nickel=0;quarter=0;


end
always
#5 clk=~clk;

endmodule
