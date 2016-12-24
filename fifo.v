//FIFO Buffer
`include "C:/FistState/Projects/FIFObuffer/reg_file.v"
`include "C:/FistState/Projects/deBounce/DeBounce_v.v"
`include "C:/FistState/Projects/SevenSegments/disp_muxcontrol.v"
`include "C:/FistState/Projects/Sevensegment2/EnableDigit.v"
`include "C:/FistState/Projects/SevenSegments/module_hex_to_sseg.v"

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
input wire clk, clr, button_red, button_wrd, //inputValues
//input wire [W-1:0] w_addr, r_addr, 
input wire [B-1:0] data, 
output wire[B-1:0] r_data,
output wire [3:0] an,
output wire [7:0] sseg
);
reg[1:0] y , Y; 
reg[1:0] Yaux = 2'b00;
localparam EMPTY=2'b00, NORMAL=2'b01, FULL=2'b11; //States assignment

//reg  [7:0] temp_value  = 8'h0;
reg [W-1:0] w_addr = Minw; 
reg [W-1:0] r_addr = Minw;
reg [B-1:0] w_data;
reg wr, re;
reg [2:0] statefull = Maxw;
wire red,wrd;
//reg cop;
DeBounce unit_btred(.clk(clk), .n_reset(clr), .button_in(button_red), .DB_out(red));
DeBounce unit_btwrd(.clk(clk), .n_reset(clr), .button_in(button_wrd), .DB_out(wrd));

reg_file unit_1 (.clk(clk), .wr_en(wr) , .re_en(re), .w_addr(w_addr),  .r_addr(r_addr),  .w_data(w_data), .r_data(r_data));
// trvalue  = 8'h0;
//define next step and output
//cop = (posedge button_red || posedge button_wrd)

always @(posedge wrd, posedge red) begin
		case (y)
			EMPTY: 
				if(wrd) begin
						w_data = data;
						wr = 1'b1;
						if (w_addr == Maxa) begin
						w_addr <= Minw; 
					end else begin
						w_addr <= w_addr + 1'b1;
					end
					if (statefull == Minw + 1) begin
					statefull = Minw;
					Y <= FULL;
					Yaux <= FULL;
					end else begin
					statefull = statefull - 1'b1;
					Y <= NORMAL;
					Yaux <= NORMAL;
					end
				end
				else begin
				Y <= EMPTY;
				Yaux <= EMPTY;
				end
				
			NORMAL:
				if(wrd) begin
					w_data = data;
					wr = 1'b1;
					if (w_addr == Maxa) begin
					w_addr <= Mina;
					end else begin
					w_addr <= w_addr + 1;
					end
					if (statefull == Minw + 1)  begin
					statefull=Minw;
					Y <= FULL;
					Yaux <= FULL;
					end else begin
					statefull = statefull - 1'b1;
					Y <= NORMAL;
					Yaux <= NORMAL;
					end
				end
				else if (red) begin
				re = 1'b1;
					if(r_addr == Maxa) begin
						r_addr <= Mina;
					end else begin
						r_addr <= r_addr +1'b1;
					end
					if (statefull == Maxw - 1) begin
						statefull = Maxw;
						Y <= EMPTY;
						Yaux <= EMPTY;
					end else begin
					statefull = statefull + 1'b1;
					Y <= NORMAL;
					Yaux <= NORMAL;
					end
				end
			
			FULL: 
				if (red) begin
					re = 1'b1;
					statefull = statefull +1'b1;
					if(r_addr == Maxa) begin
						r_addr <= Mina;
					end else begin
					r_addr <= r_addr + 1'b1;
					end
				Y <= NORMAL;
				Yaux <= NORMAL;
				end
				else begin
				Y <= FULL;
				Yaux <= FULL;
				end
		
			default :
			Y <= Yaux;
endcase
end

always @(posedge clk)
	begin 
		if (clr) begin 
		Y <= EMPTY;
		Yaux<=EMPTY;
	end else begin 
      	y = Y;	
	end
end

assign q_reset = wr | re;
assign wr = wsg;
assign re = rsg;

always @ (q_reset) 
	begin
	if (q_reg[N-1] == 1'b1) begin
	wsg = 1'b0;
	rsg = 1'b0;	
	end else begin
	q_reg = q_reg + 1'b1;
	end
end


disp_mux unit_dsp1 (.clk(clk), .reset(clr), .value_used(r_data), .an(an), .sseg(sseg));



//define the state update sequential logic

endmodule
		
		
	