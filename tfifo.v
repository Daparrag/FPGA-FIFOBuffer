`timescale 1 ns / 10 ps
module tfifo;
localparam  T=20; // clock period
reg  write,read;
reg clk, clr;

reg [7:0] Mydata; 
wire [7:0] Myr_data;
wire [7:0] result;
wire wirtee, reade;
  
fifo unit1(
	  .clk(clk), 
	  .clr(clr), 
      .button_red(read),  
	  .button_wrd(write), 
      .data(Mydata),
	  .sseg(Myr_data),
	  .r_data(result),
	  .read(reade),
	  .write(wirtee));

initial begin
			$display ($time, " << Starting the Simulation >> ");
            clk = 1'b0;
            clr = 1'b1;
			#40 clr = 1'b0;      // at time 200 release the reset
            write = 1'b0;
			read = 1'b0;
			
 end
 always 
			#10 clk = ~clk;    // every ten nanoseconds invert the clock


initial 
	begin	
			/*
			Mydata=8'h0;
			#50 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#50 write = 1'b1;
			#50 write = 1'b0;
			
		Mydata=8'h1;
			#50 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#50 write = 1'b1;
			#50 write = 1'b0;
		
		Mydata=8'h2;
			#50 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#50 write = 1'b1;
			#50 write = 1'b0;
		
		Mydata=8'h3;	
			#50 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#50 write = 1'b1;
			#50 write = 1'b0;
		
		Mydata=8'h4;
			#50 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#50 write = 1'b1;
			#50 write = 1'b0;
		
		Mydata=8'h5;
			#50 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#50 write = 1'b1;
			#50 write = 1'b0;
			
		//READ
		
		#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			
			#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			
			#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			
			#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			
			#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			*/
		//Write/read
			
			Mydata=8'h0;
			#100 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#100 write = 1'b1;
			#100 write = 1'b0;
			
			Mydata=8'h1;
			#100 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#100 write = 1'b1;
			#100 write = 1'b0;
			
			Mydata=8'h2;
			#100 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#100 write = 1'b1;
			#100 write = 1'b0;
			
			Mydata=8'h3;
			#100 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#100 write = 1'b1;
			#100 write = 1'b0;
			
			Mydata=8'h4;
			#100 write = 1'b1;
			#4 write = 1'b0;		
			#8 write = 1'b1;	
			#8 write = 1'b0;				
			#8 write = 1'b1;
			#100 write = 1'b1;
			#100 write = 1'b0;
			
			#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			
			#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			
			#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			
			#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			
			#50 read = 1'b1;
			#4 read = 1'b0;		
			#8 read = 1'b1;	
			#8 read = 1'b0;				
			#8 read = 1'b1;
			#50 read = 1'b1;
			#50 read = 1'b0;
			
			
			
			
end

			/*initial  begin

#(T);
Mydata=8'h0; 
write =  1'b1;
read = 1'b0;  
#(T);
write = ~ write;
#(T);

Mydata=8'h1;
write =  1'b1;
read = 1'b0;  
#(T);
write = ~ write;
#(T);  

Mydata=8'h2;
write =  1'b1;
read = 1'b0;  
#(T);
write = ~ write;
#(T);

Mydata=8'h3;
write =  1'b1;
read = 1'b0;  
#(T);
write = ~ write;
#(T);

Mydata=8'h4;
write =  1'b1;
read = 1'b0;  
#(T);
write = ~ write;
#(T);

Mydata=8'h5;
write =  1'b1;
read = 1'b0;  
#(T);
write = ~ write;
#(T);

Mydata=8'h6;
write =  1'b1;
read = 1'b0;  
#(T);
write = ~ write;
#(T);

//read
write =  1'b0;
read = 1'b1;  
#(T);
read = ~ read;
#(T);

write =  1'b0;
read = 1'b1;  
#(T);
read = ~ read;
#(T);

write =  1'b0;
read = 1'b1;  
#(T);
read = ~ read;
#(T);

write =  1'b0;
read = 1'b1;  
#(T);
read = ~ read;
#(T);

write =  1'b0;
read = 1'b1;  
#(T);
read = ~ read;
#(T);

write =  1'b0;
read = 1'b1;  
#(T);
read = ~ read;
#(T);

write =  1'b0;
read = 1'b1;  
#(T);
read = ~ read;
#(T);

write =  1'b0;
read = 1'b1;  
#(T);
read = ~ read;
#(T);

write =  1'b0;
read = 1'b1;  
#(T);
read = ~ read;
#(T);
end
*/
endmodule



