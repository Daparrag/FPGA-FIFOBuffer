//FIFO Buffer
`include "C:/FistState/Projects/FIFObuffer/reg_file.v"
`include "C:/FistState/Projects/SevenSegments/disp_muxcontrol.v"
`include "C:/FistState/Projects/Sevensegment2/EnableDigit.v"
`include "C:/FistState/Projects/SevenSegments/module_hex_to_sseg.v"
`include "C:/FistState/Projects/deBounce/DeBounce_v.v"
`include "C:/FistState/Projects/deBounce/button.v"
module fifo 
#(
parameter B = 8, // number of bits 
W = 2, // number of address bits
Maxw=4'b0100,
Minw=4'b0000,
Maxa=2'b11,
Mina=2'b00
)

(
//-------------Input ports Data Type-------------------
input   clk,clr,button_red,button_wrd,
input wire [B-1:0] data,
//-------------Output Ports Data Type------------------
output wire [7:0] sseg,
output wire read, write,full,empty,
output wire [3:0] an
);
//-------------Internal Constants--------------------------
reg[1:0] state , next_state; 
localparam EMPTY=2'b00, NORMAL=2'b01, FULL=2'b10; 
//-------------Internal Variables---------------------------
reg [W-1:0] w_addr = Mina; 
reg [W-1:0] r_addr = Mina;
reg [B-1:0] w_data; 
wire [B-1:0] r_data;
wire [11:0] dspdata;
reg r,w;
wire wr, re;
reg fulled , emptyled;
reg [3:0] statefull = Maxw;
wire red,wrd;



//-------------Debounce signals---------------------------
DeBounce unit_btred(.clk(clk), .n_reset(clr), .button_in(button_red), .DB_out(re));
DeBounce unit_btwrd(.clk(clk), .n_reset(clr), .button_in(button_wrd), .DB_out(wr));
button  unit_re (.clk(clk), .in(re), .out(red));
button  unit_wr (.clk(clk), .in(wr), .out(wrd));
reg_file unit_register (.clk(clk), .wr_en(w), .re_en(r), .w_addr(w_addr), .r_addr(r_addr), .w_data(w_data), .r_data(r_data));
disp_mux unit_dsp1 (.clk(clk), .reset(clr), .value_used(dspdata), .an(an), .sseg(sseg));

assign dspdata = {{Maxw-statefull},{r_data}};
assign read = re;
assign write = wr;
assign empty = emptyled;
assign full = fulled;
//----------Code startes Here------------------------
always @ (posedge clk)
begin : FSM_SEQ
  if (clr == 1'b1) begin
	fulled <= 1'b0;
	emptyled <= 1'b1;
   next_state <=  EMPTY;
  end else begin
	 w = 1'b0;
	 r = 1'b0;
    state =  next_state;
  end
 case(state)
			EMPTY: 
				if(wrd == 1'b1) begin
					w = 1'b1;
					r= 1'b0;
						w_data = data;
						if (w_addr == Maxa) begin
						w_addr <= Mina; 
					end else begin
						w_addr <= w_addr + 1'b1;
					end
					if (statefull == Minw + 1) begin
					fulled <= 1'b1;
					emptyled <= 1'b0;
					statefull = Minw;
					next_state <= FULL;
					end else begin
					statefull = statefull - 1'b1;
					next_state <= NORMAL;
					end
				end
				else begin
				fulled <= 1'b1;
				emptyled <= 1'b0;
				next_state <= EMPTY;
				end
				
			NORMAL:
				if(wrd) begin
					w = 1'b1;
					r= 1'b0;
					w_data = data;
					if (w_addr == Maxa) begin
					w_addr <= Mina;
					end else begin
					w_addr <= w_addr + 1;
					end
					if (statefull == Minw + 1)  begin
					statefull=Minw;
					fulled <= 1'b1;
					emptyled <= 1'b0;
					 next_state <= FULL;
					end else begin
					statefull = statefull - 1'b1;
					next_state <= NORMAL;
					end
				end
				else if (red) begin
					w = 1'b0;
					r= 1'b1;
					if(r_addr == Maxa) begin
						r_addr <= Mina;
					end else begin
						r_addr <= r_addr +1'b1;
					end
					if (statefull == Maxw - 1) begin
						fulled <= 1'b0;
						emptyled <= 1'b1;
						statefull = Maxw;
						next_state <= EMPTY;
					end else begin
						statefull = statefull + 1'b1;
						next_state <= NORMAL;
					end
				end
			
			FULL: 
				if (red) begin
					w = 1'b0;
					r= 1'b1;
					statefull = statefull + 1'b1;
					if(r_addr == Maxa) begin
						r_addr <= Mina;
					end else begin
						r_addr <= r_addr + 1'b1;
					end
				next_state <= NORMAL;
				end
				else begin
				fulled <= 1'b1;
				emptyled <= 1'b0;
					next_state <= FULL;
				end
		
			default :
					next_state <= EMPTY;
endcase
end

//----------Seq Logic-----------------------------
//end
//----------Output Logic-----------------------------
endmodule
