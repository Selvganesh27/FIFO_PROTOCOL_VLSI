// Code your testbench here
// or browse Examples
module fifo_sync_8x8_tb;
  reg clk,rst,wr_en,rd_en;
  reg [7:0] d_in;
  wire [7:0]d_out;
  wire full,empty,half_full,almost_full,almost_empty;
 //uut  block
  fifo_sync_8x8 uut(.clk(clk),.rst(rst),.wr_en(wr_en),.rd_en(rd_en),.d_in(d_in),.d_out(d_out),.full(full),.empty(empty),.half_full(half_full),.almost_full(almost_full),.almost_empty(almost_empty));
  initial begin//clock generation
    clk=0;
    forever #10 clk=~clk;
  end
  initial begin//reset logic
    rst=1;wr_en=0;rd_en=0;d_in=8'h00;
    #15  rst=0;
  end

   initial begin        //--------monitor-------// 
   $monitor("Time=%0t clk=%b | rst=%b |wr_en=%b |rd_en=%b |d_in=%b| d_out=%b count=%b |full=%b|empty=%b|half_full=%b|almost_full=%b|almost_empty=%b",$time,clk,rst,wr_en,rd_en,d_in,d_out,uut.count,full,empty,half_full,almost_full,almost_empty);
   $dumpfile("fifo_sync_8x8.vcd");
   $dumpvars;
 end
  // ------- write phase-------//
  
  initial begin
    repeat (8)begin
   	#20
    if(!full)begin
      	wr_en=1;
    	rd_en=0;
      d_in=$random ;
  	end
 end
  
  #20
  wr_en=0;
  //--------read phase--------//
    #40
    repeat(8)begin
    #20
    if(!empty)begin
      	wr_en=0;
    	rd_en=1;
    end
  end
  #20
  rd_en=0;
  $display("simultation complete");
  #500$finish;
  end
endmodule      
      
