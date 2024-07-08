module tbu
(
   input       clk,
   input       rst,
   input       enable,
   input       selection,
   input [7:0] d_in_0,
   input [7:0] d_in_1,
   output logic  d_o,
   output logic  wr_en);

   logic         d_o_reg;
   logic         wr_en_reg;
   
   logic   [2:0] pstate;
   logic   [2:0] nstate;

   logic         selection_buf;

   always @(posedge clk)    begin
      selection_buf  <= selection;
      wr_en          <= wr_en_reg;
      d_o            <= d_o_reg;
   end
   always @(posedge clk, negedge rst) begin
      if(!rst)
         pstate   <= 3'b000;
      else if(!enable)
         pstate   <= 3'b000;
      else if(selection_buf && !selection)
         pstate   <= 3'b000;
      else
         pstate   <= nstate;
   end

/*  combinational logic drives:
wr_en_reg, d_o_reg, nstate (next state)
from selection, d_in_1[pstate], d_in_0[pstate]
See assignment text for details
*/

   
	
	always_comb begin
      wr_en_reg = selection;
      if (selection) begin
         d_o_reg = d_in_1[pstate];
      end else begin
         d_o_reg = 0;
      end
		nstate = 0;
		
      case(pstate)
         3'b000: if(!selection && (d_in_0[0] == 0)) begin
               nstate = 0;
            end
            else if(!selection && (d_in_0[0] == 1)) begin
               nstate = 1;
            end
            else if(selection && (d_in_1[0] == 0)) begin 
               nstate = 0;
            end
            else if(selection && (d_in_1[0] == 1)) begin
               nstate = 1;
            end
         
         3'b001: if(!selection && (d_in_0[1] == 0)) begin
               nstate = 3;
            end
            else if(!selection && (d_in_0[1] == 1)) begin
               nstate = 2;
            end
            else if(selection && (d_in_1[1] == 0)) begin 
               nstate = 3;
            end
            else if(selection && (d_in_1[1] == 1)) begin
               nstate = 2;
            end

         3'b010: if(!selection && (d_in_0[2] == 0)) begin
               nstate = 4;
            end
            else if(!selection && (d_in_0[2] == 1)) begin
               nstate = 5;
            end
            else if(selection && (d_in_1[2] == 0)) begin 
               nstate = 4;
            end
            else if(selection && (d_in_1[2] == 1)) begin
               nstate = 5;
            end

         3'b011: if(!selection && (d_in_0[3] == 0)) begin
               nstate = 7;
            end
            else if(!selection && (d_in_0[3] == 1)) begin
               nstate = 6;
            end
            else if(selection && (d_in_1[3] == 0)) begin 
               nstate = 7;
            end
            else if(selection && (d_in_1[3] == 1)) begin
               nstate = 6;
            end

         3'b100: if(!selection && (d_in_0[4] == 0)) begin
               nstate = 1;
            end
            else if(!selection && (d_in_0[4] == 1)) begin
               nstate = 0;
            end
            else if(selection && (d_in_1[4] == 0)) begin 
               nstate = 1;
            end
            else if(selection && (d_in_1[4] == 1)) begin
               nstate = 0;
            end

         3'b101: if(!selection && (d_in_0[5] == 0)) begin
               nstate = 2;
            end
            else if(!selection && (d_in_0[5] == 1)) begin
               nstate = 3;
            end
            else if(selection && (d_in_1[5] == 0)) begin 
               nstate = 2;
            end
            else if(selection && (d_in_1[5] == 1)) begin
               nstate = 3;
            end

         3'b110: if(!selection && (d_in_0[6] == 0)) begin
               nstate = 5;
            end
            else if(!selection && (d_in_0[6] == 1)) begin
               nstate = 4;
            end
            else if(selection && (d_in_1[6] == 0)) begin 
               nstate = 5;
            end
            else if(selection && (d_in_1[6] == 1)) begin
               nstate = 4;
            end

         3'b111: if(!selection && (d_in_0[7] == 0)) begin
               nstate = 6;
            end
            else if(!selection && (d_in_0[7] == 1)) begin
               nstate = 7;
            end
            else if(selection && (d_in_1[7] == 0)) begin 
               nstate = 6;
            end
            else if(selection && (d_in_1[7] == 1)) begin
               nstate = 7;
            end
      endcase

   end

endmodule
