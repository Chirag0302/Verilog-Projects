////////////------------RAM 16x8 TB-----------////////////////////
module ram_16x8_tb();
	//parameter 
	parameter DEPTH = 16,
			  WIDTH = 8,
			  ADDR = 4;
			  
	//input port
	reg clk, rst;
	reg wr_en, rd_en;
	reg [ADDR-1:0]wr_addr, rd_addr;
	reg [DEPTH-1:0]wr_data;
	
	//output port 
	wire [DEPTH-1:0]rd_data;
	
	//design instantiate
	ram_16x8 dut (clk, rst, wr_en, rd_en, wr_addr, rd_addr, wr_data, rd_data);
	
	//clock generation 
	initial begin 
		clk = 1'b0;
		forever 
			#5 clk = ~clk;
	end 
	
	//reset task
	task rst_dut();
		begin 
			rst = 1'b1;
			@(posedge clk);
			rst = 1'b0;
		end 
	endtask 
	
	//write task 
	task write (input[7:0]a, input[3:0]b, input w, r);
		begin 
			@(negedge clk);
				wr_en = w;
				rd_en = r;
				wr_addr = b;
				wr_data = a;
		end 
	endtask 
	
	//read task 
	task read (input[7:0]a, input w, r);
		begin 
			@(negedge clk);
				wr_en = w;
				rd_en = r;
				rd_addr = a;
		end 
	endtask 
	
	initial begin
		rst_dut;
		repeat(15)
			write({$random}%256, {$random}%16, 1'b1, 1'b0);
		repeat(15)
			read({$random}%16, 1'b0, 1'b1);
		#100 $finish;
	end 
endmodule 
		
				