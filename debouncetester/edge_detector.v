//module edge_detector
module edge_detector
#(
parameter N = 4,
Min = 4'h0
)

(
input wire clk, clr, button_in,
output wire [N-1:0] counterw
);

wire capturesignal
reg state, next_state;
reg[N-1:0] counter;
localparam EDGE=1'b0,ZERO=1'b1; 

assign counterw = counter;

always @(posedge clk) begin

if (clr) begin 
		next_state <= EDGE;
		counter = Min;
	end else begin 
      	state <= next_state;	
	end

case (state)
		
		EDGE:
			if (button_in == 1'b1) begin
				counter = counter + 1'b1;
				next_state <= ZERO;
			end else begin
				next_state <= EDGE;
			end
		
		ZERO:
			if(button_in == 1'b0) begin
				next_state <= EDGE;
			end else begin
				next_state <= ZERO;
			end
			
		default: 
			next_state <= ZERO;
endcase
end
endmodule