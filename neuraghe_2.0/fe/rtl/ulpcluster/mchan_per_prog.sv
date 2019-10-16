module mchan_per_prog
  #(
     parameter NB_CORES       = 4,  //not used
     parameter DATA_WIDTH     = 32,
     parameter ADDR_WIDTH     = 32,
     parameter BE_WIDTH       = DATA_WIDTH/8,
     parameter WEI_MEM_BANK_SIZE= 1024
   )
   (
   
    input logic                      clk_i,
    input logic                      rst_ni,
    
    input logic [DATA_WIDTH-1:0] wdata,
    input logic [ADDR_WIDTH-1:0] add,
    input logic  		             req,
    input logic  		             wen,
    input logic [BE_WIDTH-1:0] 	 be,
    
    input logic  		             gnt_from_mchan,
    input logic [DATA_WIDTH-1:0] r_rdata_from_mchan,
    input logic  		             r_valid_from_mchan,
    
    output logic [DATA_WIDTH-1:0] wdata_to_mchan,
    output logic [ADDR_WIDTH-1:0] add_to_mchan,
    output logic  		            req_to_mchan,
    output logic  		            wen_to_mchan,
    output logic [BE_WIDTH-1:0] 	be_to_mchan,
    
    output logic  		            gnt,
    output logic [DATA_WIDTH-1:0] r_rdata,
    output logic  		            r_valid
    
   );
   
   logic [DATA_WIDTH-1:0] param_mem;
   logic [DATA_WIDTH-1:0] tcdm_add_mem;
   logic [DATA_WIDTH-1:0] ext_add_mem;
   
   logic[DATA_WIDTH-1:0] add_mem;
   
   logic [DATA_WIDTH-1:0] wdata_to_mchan_rew;
   logic [ADDR_WIDTH-1:0] add_to_mchan_rew;
   logic  		            req_to_mchan_rew;
   logic  		            wen_to_mchan_rew;
   logic [BE_WIDTH-1:0] 	be_to_mchan_rew;
   
   logic  		             gnt_from_mchan_rew;
   logic [DATA_WIDTH-1:0]  r_rdata_from_mchan_rew;
   logic  		             r_valid_from_mchan_rew;
   
   logic [2:0]  en_mem;
   logic [4:0]  cnt, n_transf;
   logic [16:0] stride;
   logic        inc, clr, agg_tcdm, agg_ext;
   
   localparam WEI_MEM_BANK_SIZE_B = WEI_MEM_BANK_SIZE*8;
   
   /*modulo trasparente*/
//   assign wdata_to_mchan = wdata;
//   assign add_to_mchan   = add;
//   assign req_to_mchan   = req;
//   assign wen_to_mchan   = wen;
//   assign be_to_mchan    = be;
//   
//   assign gnt     = gnt_from_mchan;
//   assign r_rdata = r_rdata_from_mchan;
//   assign r_valid = r_valid_from_mchan;
   /* */
   
   
  enum logic [4:0] {IDLE, PASS_THROUGH, 
                      READ_PARAM, READ_TCDM_ADD, READ_EXT_ADD, READ_STRIDE,
                      R_VALID_PAR, R_VALID_TCDM, R_VALID_EXT, R_VALID_STRIDE,
                      WAIT_MEM_ADD, WAIT_EXT_ADD, WAIT_STRIDE,
                      SEND_PARAM, SEND_TCDM_ADDR, SEND_EXT_ADDR, 
                      WAIT} CS, NS;

   assign wdata_to_mchan = wdata_to_mchan_rew;
   assign add_to_mchan   = add_to_mchan_rew;
   assign req_to_mchan   = req_to_mchan_rew;
   assign wen_to_mchan   = wen_to_mchan_rew;
   assign be_to_mchan    = be_to_mchan_rew;
   
   assign gnt     = gnt_from_mchan_rew;
   assign r_rdata = r_rdata_from_mchan_rew;
   assign r_valid = r_valid_from_mchan_rew;
   
   //update state
    always_ff @(posedge clk_i /*or negedge rst_ni*/) begin
      if (rst_ni==1'b0) begin
        CS <= IDLE;
      end
      else begin
        CS <= NS;
      end
    end
    
   //reg to store parameters
    always_ff @(posedge clk_i /*or negedge rst_ni*/) begin
      if (rst_ni==1'b0) begin
           param_mem <= 0;   
      end
      else if(en_mem==3'b001) begin
          param_mem <= wdata;
      end
    end
    
   //reg to store tcdm address
   always_ff @(posedge clk_i /*or negedge rst_ni*/) begin
     if (rst_ni==1'b0) begin
          tcdm_add_mem <= 0;   
     end
     else if(en_mem==3'b010) begin
          tcdm_add_mem <= wdata;
     end
     else if(agg_tcdm==1'b1 && gnt_from_mchan == 1'b1)begin
           tcdm_add_mem <= wdata_to_mchan_rew;
      end
   end
    
   //reg to store extern address
   always_ff @(posedge clk_i /*or negedge rst_ni*/) begin
     if (rst_ni==1'b0) begin
          ext_add_mem <= 0;   
     end
     else if(en_mem==3'b011) begin
          ext_add_mem <= wdata;
     end
     else if(agg_ext==1'b1 && gnt_from_mchan == 1'b1)begin
           ext_add_mem <= wdata_to_mchan_rew;
      end
   end
    
   //reg to dma cmd queue
   always_ff @(posedge clk_i /*or negedge rst_ni*/) begin
     if (rst_ni==1'b0) begin
          add_mem <= 0;   
     end
     else if(en_mem==3'b001) begin
          add_mem <= add;
     end
   end
   
   //reg to store stride and num transfers
    always_ff @(posedge clk_i /*or negedge rst_ni*/) begin
     if (rst_ni==1'b0) begin
          n_transf  <= 0;
          stride <= 0;   
     end
     else if(en_mem==3'b100) begin
         n_transf  <= wdata[DATA_WIDTH-1:27];
         stride <= wdata[16:0];
     end
   end
   
  always_ff @(posedge clk_i /*or negedge rst_ni*/) begin
     if (rst_ni==1'b0) begin
          cnt <= 0;   
     end
     else if(inc && gnt_from_mchan == 1'b1) begin
          cnt <= cnt + 1;
     end
     else if (clr) begin
          cnt <= 0;            
     end
   end
    
  
  //next state
    always_comb begin
      
      case(CS) 
      
      IDLE:
      begin
        if(req==1'b1 && wen==1'b0 && wdata[19:16]==4'h3 && be==4'hf) begin
          NS = READ_PARAM;
        end
        else if(req == 1'b1) begin
          NS = PASS_THROUGH;
        end
        else begin
          NS = IDLE;
        end
      end
      
      PASS_THROUGH:
      begin
        if(req == 1'b0) begin
          NS = IDLE;
        end
        else begin
          NS = PASS_THROUGH;
        end
      end
      
      READ_PARAM:
      begin
        NS = R_VALID_PAR; 
      end
      
      R_VALID_PAR:
      begin
         NS = WAIT_MEM_ADD;
      end
      
      WAIT_MEM_ADD:
      begin
        if(req==1'b1 && wen==1'b0 && be==4'hf) begin
          NS = READ_TCDM_ADD;
        end
        else begin
          NS = WAIT_MEM_ADD;
        end
      end
      
      READ_TCDM_ADD:
      begin
          NS = R_VALID_TCDM;
      end
      
      R_VALID_TCDM:
      begin
         NS = WAIT_EXT_ADD;
      end
      
      WAIT_EXT_ADD:
      begin
        if(req==1'b1 && wen==1'b0 && be==4'hf) begin
          NS = READ_EXT_ADD;
        end
        else begin
          NS = WAIT_EXT_ADD;
        end
      end
      
      READ_EXT_ADD:
      begin
          NS = R_VALID_EXT;
      end
      
      R_VALID_EXT:
      begin
        NS = WAIT_STRIDE;
      end
      
      WAIT_STRIDE:
      begin
        if(req==1'b1 && wen==1'b0 && be==4'hf) begin
          NS = READ_STRIDE;
        end
        else begin
          NS = WAIT_STRIDE;
        end
      end
      
      READ_STRIDE:
      begin
         NS = R_VALID_STRIDE;
      end
      
      R_VALID_STRIDE:
      begin
        NS = SEND_PARAM;
      end
      
      SEND_PARAM:
      begin
        if(gnt_from_mchan == 1'b1) begin
          NS = SEND_TCDM_ADDR;
        end
       else begin
          NS = SEND_PARAM;
       end
      end
      
      SEND_TCDM_ADDR:
      begin
        if(gnt_from_mchan == 1'b1) begin
          NS = SEND_EXT_ADDR; 
        end
        else begin
          NS = SEND_TCDM_ADDR;
        end
      end
      
      SEND_EXT_ADDR:
      begin
        if(gnt_from_mchan == 1'b1 /*&& cnt == n_transf*/) begin
          //NS = IDLE;
          NS = WAIT;
        end
//        else if(gnt_from_mchan == 1'b0) begin
//          NS = SEND_EXT_ADDR;
//        end
        else begin
          //NS = SEND_PARAM;
          NS = SEND_EXT_ADDR;
        end
      end
      
      WAIT:
      begin
        if(cnt == n_transf) begin
          NS = IDLE;
        end
        else begin
          NS = SEND_PARAM;
        end
      end
      
      default:
      begin
        NS = IDLE;
      end
      
      endcase
    
    end //always_comb
    
    
    
    //signals
    always_comb begin
      
      case(CS) 
      
      IDLE:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b1;
        be_to_mchan_rew    = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        r_valid_from_mchan_rew = 1'b0;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      PASS_THROUGH:
      begin
        req_to_mchan_rew   = req;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = wen;
        be_to_mchan_rew    = be;
        
        gnt_from_mchan_rew = gnt_from_mchan;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        r_valid_from_mchan_rew = r_valid_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      READ_PARAM:
      begin       
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0;
        
        gnt_from_mchan_rew = 1'b1;
        r_valid_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b001;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      R_VALID_PAR:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = 1'b1;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      WAIT_MEM_ADD:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      READ_TCDM_ADD:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0; 
        
        gnt_from_mchan_rew = 1'b1;
        r_valid_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b010;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      R_VALID_TCDM:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = 1'b1;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      WAIT_EXT_ADD:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      READ_EXT_ADD:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0; 
        
        gnt_from_mchan_rew = 1'b1;
        r_valid_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b011;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      R_VALID_EXT:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = 1'b1;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      WAIT_STRIDE:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      READ_STRIDE:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0;
        
        gnt_from_mchan_rew = 1'b1;
        r_valid_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b100;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      R_VALID_STRIDE:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = 1'b1;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b1;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      SEND_PARAM:
      begin
        req_to_mchan_rew   = 1'b1;
        wdata_to_mchan_rew = param_mem;
        add_to_mchan_rew   = add_mem;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew    = 4'hf;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = r_valid_from_mchan;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
         
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b0;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      SEND_TCDM_ADDR:
      begin
        req_to_mchan_rew   = 1'b1; 
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew    = 4'hf;
        add_to_mchan_rew   = add_mem;
        wdata_to_mchan_rew = (cnt==1'b0) ? tcdm_add_mem : tcdm_add_mem + WEI_MEM_BANK_SIZE_B; //cnt*WEI_MEM_BANK_SIZE_B;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = r_valid_from_mchan;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b0;
        agg_tcdm = 1'b1;
        agg_ext = 1'b0;
      end
      
      SEND_EXT_ADDR:
      begin
        req_to_mchan_rew   = 1'b1; 
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew    = 4'hf;
        add_to_mchan_rew   = add_mem;
        wdata_to_mchan_rew = (cnt==1'b0) ? ext_add_mem : ext_add_mem + stride; //cnt*stride;
        
        gnt_from_mchan_rew = 1'b0;
        r_valid_from_mchan_rew = r_valid_from_mchan;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        
        inc = 1'b1;
        en_mem = 3'b000;
        clr = 1'b0;
        agg_tcdm = 1'b0;
        agg_ext = 1'b1;
      end
      
      WAIT:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b0;
        be_to_mchan_rew    = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        r_valid_from_mchan_rew = r_valid_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b0;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      default:
      begin
        req_to_mchan_rew   = 1'b0;
        wdata_to_mchan_rew = wdata;
        add_to_mchan_rew   = add;
        wen_to_mchan_rew   = 1'b1;
        be_to_mchan_rew    = 4'h0;
        
        gnt_from_mchan_rew = 1'b0;
        r_rdata_from_mchan_rew = r_rdata_from_mchan;
        r_valid_from_mchan_rew = r_valid_from_mchan;
        
        inc = 1'b0;
        en_mem = 3'b000;
        clr = 1'b0;
        agg_tcdm = 1'b0;
        agg_ext = 1'b0;
      end
      
      endcase
    
    end //always_comb*/
   
endmodule
