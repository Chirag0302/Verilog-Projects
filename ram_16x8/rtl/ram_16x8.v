////////////------------RAM 16x8-----------//////////

module ram_16x8(clk, rst, wr_en, rd_en, wr_addr, rd_addr, wr_data, rd_data);
	//parameter declaration 
	parameter WIDTH = 8, 
			  DEPTH = 16,
			  ADDR = 4;
			  
	//input port 
	input clk, rst;
	input wr_en, rd_en;
	input [ADDR-1:0]wr_addr, rd_addr;
	input [DEPTH-1:0]wr_data;
	
	//output port 
	output reg [DEPTH-1:0]rd_data;
	
	//memory
	reg [WIDTH-1:0] mem [0:DEPTH-1];
	
	integer i;
	
	always@(posedge clk)
		begin 
			if(rst)begin
				rd_data <= 1'b0;
					for(i=0; i<DEPTH; i=i+1)
						mem[i] <= 1'b0;
				end 
			else  
				begin 
					if(wr_en)
						mem[wr_addr] <= wr_data;
					else if(rd_en)
						rd_data <= mem[rd_addr];
				end 
		end 
endmodule 