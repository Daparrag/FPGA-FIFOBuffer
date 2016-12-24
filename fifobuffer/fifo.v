//FIFO Buffer
`include "C:/FistState/Projects/FIFObuffer/reg_file.v"
`include "C:/FistState/Projects/deBounce/DeBounce_v.v"
//`include "C:/FistState/Projects/SevenSegments/disp_muxcontrol.v"
//`include "C:/FistState/Projects/Sevensegment2/EnableDigit.v"
//`include "C:/FistState/Projects/SevenSegments/module_hex_to_sseg.v"
module fifo
#(
parameter B = 8, // number of bits 
W = 3, // number of address bits
Maxw=3'b100,
Minw=3'b000,
Maxa=2'b11,
Mina=2'b00
) 

(
input wire clk, clr, button_red, button_wrd//, //inputValues
//input wire [W-1:0] w_addr, r_addr, 
//input wire [7:0] data, 
//output wire [3:0] an,
//output wire [7:0] sseg,
//output wire full,empty
);
wire red, wrd; //signals to control after filter 
reg wr, re; //signals to control write and red
//reg [1:0] yin , Y; //signal to control states FSM 
//localparam EMPTY=2'b00, NORMAL=2'b01, FULL=2'b11; //States assignment

//reg [1:0] Yaux = 2'b00;
//reg  [7:0] temp_value  = 8'h0;
//reg [W-1:0] w_addr = Minw; 
//reg [W-1:0] r_addr = Minw;
//reg [B-1:0] w_data;
//wire[B-1:0] r_data;
//
//reg fullux, emptyaux;
//reg [2:0] statefull = Maxw;
//wire cop;
//wire [11:0] dsp;

DeBounce unit_btred(.clk(clk), .n_reset(clr), .button_in(button_red), .DB_out(red));
DeBounce unit_btwrd(.clk(clk), .n_reset(clr), .button_in(button_wrd), .DB_out(wrd));

//reg_file unit_1 (.clk(clk), .wr_en(wr) , .re_en(re), .w_addr(w_addr),  .r_addr(r_addr),  .w_data(w_data), .r_data(r_data));
// trvalue  = 8'h0;
//define next step and output
//assign cop = ( wrd |  red);

//always @(posedge clk) begin
//		if(clr) begin
//			Y<=EMPTY;
//		end else begin
//		yin = Y;
//		end

//end

/*always @(posedge clk)
	if (clr) begin 
	 Y <= EMPTY;
	 Yaux<=EMPTY;
	end else begin 
	yin = Y;	
end*/

//always @ (negedge wrd, negedge red) begin
/*always @ (negedge cop) begin
 wr <= 1'b0;
 re <=1'b0;
end
*/
//Counter Reset
//reg q_wr, q_re;
//reg q_reg = 1'b0;
//reg wsg,rsg;


//assign wr = wsg;
//assign re = rsg;
//Counter Reset
always @ (posedge clk) 
	begin
		if (wr) begin
			if (q_reg == 1'b1) begin
			q_wr = 1'b0;	
			end else begin
			q_wr = 1'b1;	
			q_reg = 1'b1;
		end
	end
end


//assign full = fullux;
//assign empty = emptyaux;
//assign dsp = {{Maxw-statefull}, {r_data}};

//disp_mux unit_dsp (.clk(clk), .reset(clr), .value_used(dsp), .an(an), .sseg(sseg));

//define the state update sequential logic

endmodule
		
		
	