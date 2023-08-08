module bidcounter(count,clk,ctrl,reset);
	input clk,reset,ctrl;
	output reg [3:0] count;
	always@(posedge clk)
		begin
		if(reset) count<=0;
		else if(ctrl) count<=count+1;
		else count<=count-1;
	end
endmodule
	
