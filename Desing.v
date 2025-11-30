module fifo_sync_8x8(
   input  clk, rst,
   input  wr_en, rd_en,
   input  [7:0] d_in,
   output reg [7:0] d_out,
   output reg full, empty, half_full, almost_full, almost_empty
);

  reg [7:0] mem [0:7];
  reg [2:0] wr_ptr, rd_ptr;
  reg [3:0] count;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
        wr_ptr <= 0;
        rd_ptr <= 0;
        count  <= 0;
        d_out  <= 0;

        full  <= 0;
        empty <= 1;
        half_full <= 0;
        almost_full <= 0;
        almost_empty <= 0;
    end 
    else begin

        // Compute next_count
        
      

        if (wr_en && !full && !(rd_en && !empty))
            count = count + 1;

        else if (rd_en && !empty && !(wr_en && !full))
            count = count - 1;

        else if (wr_en && rd_en && !full && !empty)
            count = count;

 
        // Perform write
        if (wr_en && !full)
            mem[wr_ptr] <= d_in;

       
        // Perform read
        if (rd_en && !empty)
            d_out <= mem[rd_ptr];
        else
            d_out <= d_out;

       
        // Update pointers

        if (wr_en && !full)
            wr_ptr <= wr_ptr + 1;

        if (rd_en && !empty)
            rd_ptr <= rd_ptr + 1;

        // Wrap-around
        if (wr_ptr == 3'd7 && wr_en && !full)
            wr_ptr <= 0;

        if (rd_ptr == 3'd7 && rd_en && !empty)
            rd_ptr <= 0;

       

        // Update flags using next_count
        full          <= (count == 8);
        empty         <= (count == 0);
        half_full     <= (count == 4);
        almost_full   <= (count == 7);
        almost_empty  <= (count == 1);
    end
  end

endmodule
