module Vending_Machine1(dime,nickel,quarter,nickel_out,quarter_out,dime_out,reset, clk, dispense1,choice);
output reg dispense1;
reg[1:0] dime1,nickel1,quarter1;
input dime,nickel,quarter,choice;  //nickel=5 cents,dime=10 cents,quarter=25 cents,choice=0 is food,else drink;
reg [0:2816] memory, memory2;   
input clk;
input reset;
output reg[1:0] nickel_out,quarter_out,dime_out;
reg [2:0] current_state, next_state,dispense;
localparam    S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b100,
              S4 = 3'b101,
              S5 = 3'b110,
              S6 = 3'b111;
integer i,file,file2;
real match=0.0000;
initial
begin
file=$fopen("user.dat","r");//User's LBP image file .
file2=$fopen("check.dat","r");//Stored LBP image in the vending machine.
for (i=0; i<2816; i=i+1)begin
$fscanf(file,"%d",memory[i]);
$fscanf(file2,"%d",memory2[i]);
end
$fclose(file);
$fclose(file2);
end

//This code implements a Vending Machine which will only work if it can recognise your face.
//The Machine dispenses An item of food which costs 35 cents and accepts nickels, dimes and quaters as inputs one at a time.
//S0-When no money in the Machine
//S1-When  5 cents in the Machine
//S2-When 10 cents in the Machine
//S3-When 15 cents in the Machine
//S4-When 20 cents in the Machine
//S5-When 25 cents in the Machine
//S6-When 30 cents in the Machine
//When the Amount in the Machine exceeds 35 cents, the machine dispenses the Food item and go goes back back S0.
//If the money inserted is greater than 35 cents, the machine returns the appropriate change to the customer.
initial begin
for(i=0;i<2816;i=i+1)begin
if(memory2[i]==memory[i])begin//If the corresponding bits of the data files don't match we return check=0
match=match+1;end//Counting the number of bits that matched in the 2 files.
end
match=(match*100)/2816;//This calculates the percentage of the face match. 2816 is the total number of bits of the test file.
$display("%d PERCENTAGE FACE MATCHED",match);
end
initial
begin
if(match>=90)
$display("FACE RECOGNISED");
else
$display("FACE NOT RECOGNISED");
end
always@(choice)
current_state<=S0;

 always @(current_state or dime or nickel or quarter)
  begin
if(choice==0 && match>=90) begin//Only if the face matched by 90% or more, the Machine works.

  case (current_state)
   S0: if (nickel== 1 && dime==0 && quarter==0)//when nickel is inserted
            begin
         next_state = S1;
             dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)//when dime is inserted
            begin
            next_state=S2;
            dispense=0;
            dime1=0;
            nickel1=0;
            quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)//when quarter is inserted
            begin
            next_state=S5;
            dispense=0;
            dime1=0;
            nickel1=0;
            quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
   S1: if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S2;
             dispense=0;
	   dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S3;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S6;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;

            end
   S2:if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S3;
             dispense=0;
              dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S4;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
   S3: if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S4;
             dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S5;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;//food is dispensed when dispense=1.
            dime1=0;
             nickel1=1;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
	    dime1=0;
             nickel1=0;
             quarter1=0;
            end
S4: if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S5;
             dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S6;
            dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;
            dime1=1;
             nickel1=0;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
	    dime1=0;
             nickel1=0;
             quarter1=0;
            end
S5: if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S6;
             dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S0;
            dispense=1;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;
            dime1=1;
             nickel1=1;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
S6: if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state =S0;
             dispense=1;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S0;
            dispense=1;
            dime1=0;
             nickel1=1;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;
            dime1=2;
             nickel1=0;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
                       
   default: next_state = S0;
  endcase
end

else if(choice==1 && match>=90)
begin
  case (current_state)
   S0: if (nickel== 1 && dime==0 && quarter==0)//when nickel is inserted
            begin
         next_state = S1;
             dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)//when dime is inserted
            begin
            next_state=S2;
            dispense=0;
            dime1=0;
            nickel1=0;
            quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)//when quarter is inserted
            begin
            next_state=S5;
            dispense=0;
            dime1=0;
            nickel1=0;
            quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
   S1: if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S2;
             dispense=0;
	   dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S3;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;

            end
   S2:if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S3;
             dispense=0;
              dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S4;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;
            dime1=0;
             nickel1=1;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
   S3: if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S4;
             dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S5;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;//Drink is dispensed when dispense=1.
            dime1=1;
             nickel1=0;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
	    dime1=0;
             nickel1=0;
             quarter1=0;
            end
S4: if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S5;
             dispense=0;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S0;
            dispense=1;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;
            dime1=1;
             nickel1=1;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
	    dime1=0;
             nickel1=0;
             quarter1=0;
            end
S5: if (nickel== 1 && dime==0 && quarter==0)
            begin
         next_state = S0;
             dispense=1;
             dime1=0;
             nickel1=0;
             quarter1=0;
            end
      else if(nickel== 0 && dime==1 && quarter==0)
            begin
            next_state=S0;
            dispense=1;
            dime1=0;
             nickel1=1;
             quarter1=0;
            end
            else if(nickel== 0 && dime==0 && quarter==1)
            begin
            next_state=S0;
            dispense=1;
            dime1=2;
             nickel1=0;
             quarter1=0;
            end
             else
            begin
            next_state = current_state;
            dispense=0;
            dime1=0;
             nickel1=0;
             quarter1=0;
            end

                       
   default: next_state = S0;
  endcase
end
end
always@(posedge clk)
begin
//Assignments to the ouputs are done at the posedge of the clock.
 dispense1=dispense;
 dime_out=dime1;
 nickel_out=nickel1;
 quarter_out=quarter1;
 if (reset)
   current_state <= S0;//If reset is high, machine goes back to default state.
 else
   current_state <= next_state;
end

endmodule
