//-----------------------------------------------------
// This is FSM demo program using always block
// Design Name : fsm_using_always
// File Name   : fsm_using_always.v
//-----------------------------------------------------
`include "C:/FistState/Projects/deBounce/DeBounce_v.v"
`include "C:/FistState/Projects/deBounce/button.v"
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
clk,        // clock
clr,        // Active high, syn reset
button_red, // Request 0
button_wrd, // Request 1
data,
gnt_0,      // Grant 0
gnt_1      
);
//-------------Input Ports-----------------------------
input   clk,clr,button_red,button_wrd;
input wire [B-1:0] data;
 //-------------Output Ports----------------------------
output  gnt_0,gnt_1;
//-------------Input ports Data Type-------------------
wire    clk,clr,button_red,button_wrd;
//-------------Output Ports Data Type------------------
reg     gnt_0,gnt_1;
//-------------Internal Constants--------------------------
reg state , next_state; 
localparam EMPTY=2'b00, NORMAL=2'b01, FULL=2'b10; 
//-------------Internal Variables---------------------------
reg [W-1:0] w_addr = Minw; 
reg [W-1:0] r_addr = Minw;
reg [B-1:0] w_data;
wire wr, re;
reg [2:0] statefull = Maxw;
wire red,wrd;
//-------------Debounce signals---------------------------
DeBounce unit_btred(.clk(clk), .n_reset(clr), .button_in(button_red), .DB_out(re));
DeBounce unit_btwrd(.clk(clk), .n_reset(clr), .button_in(button_wrd), .DB_out(wr));
button  unit_re (.clk(clk), .in(re), .out(red));
button  unit_wr (.clk(clk), .in(wr), .out(wrd));

//----------Code startes Here------------------------
always @ (posedge clk)
begin : FSM_SEQ
  if (clr == 1'b1) begin
    state <=  EMPTY;
  end else begin
    state <=  next_state;
  end
 case(state)
			EMPTY: 
				if(wrd == 1'b1) begin
						w_data = data;
						if (w_addr == Maxa) begin
						w_addr <= Minw; 
					end else begin
						w_addr <= w_addr + 1'b1;
					end
					if (statefull == Minw + 1) begin
					statefull = Minw;
					next_state = FULL;
					end else begin
					statefull = statefull - 1'b1;
					next_state = NORMAL;
					end
				end
				else begin
				next_state = EMPTY;
				end
				
			NORMAL:
				if(wrd) begin
					w_data = data;
					if (w_addr == Maxa) begin
					w_addr <= Mina;
					end else begin
					w_addr <= w_addr + 1;
					end
					if (statefull == Minw + 1)  begin
					statefull=Minw;
					 next_state = FULL;
					end else begin
					statefull = statefull - 1'b1;
					next_state = NORMAL;
					end
				end
				else if (red) begin
					if(r_addr == Maxa) begin
						r_addr <= Mina;
					end else begin
						r_addr <= r_addr +1'b1;
					end
					if (statefull == Maxw - 1) begin
						statefull = Maxw;
						next_state = EMPTY;
					end else begin
						statefull = statefull + 1'b1;
						next_state = NORMAL;
					end
				end
			
			FULL: 
				if (red) begin
					statefull = statefull +1'b1;
					if(r_addr == Maxa) begin
						r_addr <= Mina;
					end else begin
						r_addr <= r_addr + 1'b1;
					end
				next_state = NORMAL;
				end
				else begin
					next_state = FULL;
				end
		
			default :
					next_state = 2'bxx;
endcase
end
//----------Seq Logic-----------------------------
//end
//----------Output Logic-----------------------------
