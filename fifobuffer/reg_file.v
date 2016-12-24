module reg_file 
#(
parameter B = 8, // number of bits 
W = 2 // number of address bits
) 

(
input wire clk, 
input wire wr_en, 
input wire re_en,
input wire [W-1:0] w_addr, r_addr, 
input wire [B-1:0] w_data, 
output wire [B-1:0] r_data
);
// signal declaration 
reg [B-1:0] array_reg [2**W-1:0];
reg [B-1:0] tdata;
// body 
// write operation 
always @(posedge wr_en, posedge re_en) 
	if (wr_en) begin 
		array_reg[w_addr] <= w_data; 
	end 	
	else  
		if (re_en) begin 
	// read operation 
		tdata  = array_reg [r_addr];
	end

assign r_data = tdata;

endmodule