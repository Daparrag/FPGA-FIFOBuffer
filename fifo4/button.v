
module button(
input clk,
 input in,
 output out
 );
 
 reg r1,r2,r3;
 
 always @ (posedge clk)
 begin
 r1 <= in; // first reg in synchronizer
 r2 <= r1; // second reg in synchronizer, output is in sync!
 r3 <= r2; // remembers previous state of button
 end
 // rising edge = old value is 0, new value is 1
 assign out = ~r3 & r2;
endmodule

