module ACS		                        // add-compare-select
(
   input       path_0_valid,
   input       path_1_valid,
   input [1:0] path_0_bmc,	            // branch metric computation
   input [1:0] path_1_bmc,				
   input [7:0] path_0_pmc,				// path metric computation
   input [7:0] path_1_pmc,

   output logic        selection,
   output logic        valid_o,
   output logic    [7:0] path_cost);  

   logic  [7:0] path_cost_0;			   // branch metric + path metric
   logic  [7:0] path_cost_1;

/* Fill in the guts per ACS instructions
*/


	
   always_comb begin
	   path_cost_0 = path_0_pmc + path_0_bmc;
	   path_cost_1 = path_1_pmc + path_1_bmc;

		selection = 0;
		valid_o = 0;
		path_cost = 0;
      
      //initializing selection and valid_o values based on path validity
      if(path_0_valid == 0 && path_1_valid == 0) begin
         selection = 0;
         valid_o = 0;
      end
      else if(path_0_valid == 0 && path_1_valid == 1) begin
         selection = 1;
         valid_o = 1;
      end
      else if(path_0_valid == 1 && path_1_valid == 0) begin
         selection = 0;
         valid_o = 1;
      end
      else if(path_0_valid == 1 && path_1_valid == 1) begin
         valid_o = 1;
         if (path_cost_0 > path_cost_1) begin
            selection = 1;
         end else begin
            selection = 0;
         end
      end

      // To initialize path cost values, based on selection and valid_o from before
      if(valid_o == 0 && selection == 0) begin
         path_cost = 0;
      end
      else if(valid_o == 0 && selection == 1) begin 
         path_cost =0;
      end
      else if(valid_o == 1 && selection == 0) begin
         path_cost = path_cost_0;
      end
      else if(valid_o == 1 && selection == 1) begin 
         path_cost = path_cost_1;
      end


   end

endmodule
