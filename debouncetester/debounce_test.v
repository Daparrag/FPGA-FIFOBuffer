//Module DebounceTester
`include "C:/FistState/Projects/deBounce/tickdetector.v"
`include "C:/FistState/Projects/SevenSegments/disp_muxcontrol.v"
`include "C:/FistState/Projects/Sevensegment2/EnableDigit.v"
`include "C:/FistState/Projects/SevenSegments/module_hex_to_sseg.v"
module debounce_test
#(
parameter N = 4

)

(
input wire clk, clr, button_totest,
output wire [N-1:0] counterw,
output wire [3:0] an,
output wire [7:0] sseg
//for test.
//output wire [N-1:0] countButton,
//output wire [N-1:0] countDEbounce
//for test.
);
wire [N-1:0] countButton;
wire [N-1:0] countDEbounce;
wire debounceout;
wire [7:0] dspdata;

assign dspdata = {countButton,countDEbounce};

DeBounce unit_btred(.clk(clk), .n_reset(clr), .button_in(button_totest), .DB_out(debounceout)); 
tickdetector unit1 (.clk(clk), .clr(clr), .button_in(button_totest), .counterw(countButton));
tickdetector unit2 (.clk(clk), .clr(clr), .button_in(debounceout), .counterw(countDEbounce) );
//disp_mux unit_dsp1 (.clk(clk), .reset(clr), .value_used(dspdata), .an(an), .sseg(sseg));

endmodule

