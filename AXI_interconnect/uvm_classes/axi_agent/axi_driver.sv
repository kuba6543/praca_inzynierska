class axi_driver extends uvm_driver#(axi_transaction);
    
    `include "../../parameters.svh"  

    virtual interface axi_if vif;
    axi_sequence seq;
    bit is_slave = 0;

    `uvm_component_utils(axi_driver)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction:new

    //UVM connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (!uvm_config_db#(virtual axi_if)::get(this, "", "vif", vif))
            `uvm_fatal(get_full_name(),"No virtual interface specified for this instance");
    endfunction : connect_phase

    // UVM run_phase
    task run_phase(uvm_phase phase);
        axi_transaction req;
        super.run_phase(phase);
        reset();
        forever begin
            seq_item_port.get_next_item(req);
            @(posedge vif.clk);
            case(req.transaction_type)
                W: begin
                    write_addr(req);
                    write_data(req);
                    write_response(req);
                end
                R: begin
   		            read_addr(req);
                    read_data(req);
                    read_response(req);
                end
    	        default: `uvm_fatal("axi_driver","No valid command")
            endcase
            `uvm_info("DRV", $sformatf("Driving transaction:\n%s", req.sprint()), UVM_MEDIUM)
            seq_item_port.item_done();
        end
    endtask : run_phase

    task reset();
        vif.axi_awid    = 0;
        vif.axi_awaddr  = 0;
        vif.axi_awlen   = 0;
        vif.axi_awid    = 0;
        vif.axi_awaddr  = 0;
        vif.axi_awlen   = 0;
        vif.axi_awsize  = 0;
        vif.axi_awburst = 0;
        vif.axi_awlock  = 0;
        vif.axi_awcache = 0;
        vif.axi_awprot  = 0;
        vif.axi_awqos   = 0;
        vif.axi_awuser  = 0;
        vif.axi_awvalid = 0;
        vif.axi_awready = 0;
        vif.axi_wdata   = 0;
        vif.axi_wstrb   = 0;
        vif.axi_wlast   = 0;
        vif.axi_wuser   = 0;
        vif.axi_wvalid  = 0;
        vif.axi_wready  = 0;
        vif.axi_bid     = 0;
        vif.axi_bresp   = 0;
        vif.axi_buser   = 0;
        vif.axi_bvalid  = 0;
        vif.axi_bready  = 0;
        vif.axi_arid    = 0;
        vif.axi_araddr  = 0;
        vif.axi_arlen   = 0;
        vif.axi_arsize  = 0;
        vif.axi_arburst = 0;
        vif.axi_arlock  = 0;
        vif.axi_arcache = 0;
        vif.axi_arprot  = 0;
        vif.axi_arqos   = 0;
        vif.axi_aruser  = 0;
        vif.axi_arvalid = 0;
        vif.axi_arready = 0;
        vif.axi_rid     = 0;
        vif.axi_rdata   = 0;
        vif.axi_rresp   = 0;
        vif.axi_rlast   = 0;
        vif.axi_ruser   = 0;
        vif.axi_rvalid  = 0;
        vif.axi_rready  = 0;
    endtask: reset

    task write_addr(axi_transaction w_tr);
//        axi_transaction w_tr;

        // send transaction
        vif.axi_awvalid     = 1'b1;
        vif.axi_awid        = w_tr.axi_awid;
        vif.axi_awaddr      = w_tr.axi_awaddr;
        vif.axi_awregion    = w_tr.axi_awregion;
        vif.axi_awlen       = w_tr.axi_awlen;
        vif.axi_awsize      = w_tr.axi_awsize;
        vif.axi_awburst     = w_tr.axi_awburst;
        vif.axi_awlock      = w_tr.axi_awlock;
        vif.axi_awcache     = w_tr.axi_awcache;
        vif.axi_awprot      = w_tr.axi_awprot;
        vif.axi_awqos       = w_tr.axi_awqos;

        //wait AWREADY
        while (!vif.axi_awready) @(posedge vif.clk);
        vif.axi_awvalid = 1'b0;
        
        @(posedge vif.clk);
        
//        `uvm_info("DRV", $sformatf("Driving transaction:\n%s", req.sprint()), UVM_MEDIUM)
//        seq_item_port.item_done();

    endtask : write_addr
    
    task write_data(axi_transaction w_tr);
    
        vif.axi_wvalid = 1'b1;
        vif.axi_wdata = w_tr.axi_wdata;
        vif.axi_wstrb = w_tr.axi_wstrb;
        vif.axi_wlast = w_tr.axi_wlast;
        vif.axi_wuser = w_tr.axi_wuser;
    
        while(!vif.axi_wready) @(posedge vif.clk);    
        vif.axi_wvalid = 1'b0;
        
        @(posedge vif.clk);
    
    endtask : write_data;
    
    task write_response(axi_transaction w_tr);
    
        vif.axi_bvalid = 1'b1;
        vif.axi_bid = w_tr.axi_bid;
        vif.axi_bresp = w_tr.axi_bresp;
        vif.axi_buser = w_tr.axi_buser;
    
        while(!vif.axi_bready) @(posedge vif.clk);    
        vif.axi_bvalid = 1'b0;
        
        @(posedge vif.clk);
    
    endtask : write_response;
    
    task read_addr(axi_transaction r_tr);

        // send ARVALID
        vif.axi_arvalid     = 1'b1;

        //wait ARREADY
        while (!vif.axi_arready) @(posedge vif.clk);
        
        r_tr.axi_arid        = vif.axi_arid;
        r_tr.axi_araddr      = vif.axi_araddr;
        r_tr.axi_arregion    = vif.axi_arregion;
        r_tr.axi_arlen       = vif.axi_arlen;
        r_tr.axi_arsize      = vif.axi_arsize;
        r_tr.axi_arburst     = vif.axi_arburst;
        r_tr.axi_arlock      = vif.axi_arlock;
        r_tr.axi_arcache     = vif.axi_arcache;
        r_tr.axi_arprot      = vif.axi_arprot;
        r_tr.axi_arqos       = vif.axi_arqos;
        
        @(posedge vif.clk);
        
        vif.axi_arvalid = 1'b0;
        
        @(posedge vif.clk);
        
    endtask : read_addr
    
    task read_data(axi_transaction r_tr);

        // send RVALID
        vif.axi_rvalid     = 1'b1;

        //wait RREADY
        while (!vif.axi_rready) @(posedge vif.clk);
        
        r_tr.axi_rid        = vif.axi_rid;
        r_tr.axi_rdata      = vif.axi_rdata;
        r_tr.axi_rlast      = vif.axi_rlast;
        r_tr.axi_ruser      = vif.axi_ruser;
        
        @(posedge vif.clk);
        
        vif.axi_rvalid = 1'b0;
        
        @(posedge vif.clk);
        
    endtask : read_data
    
    task read_response(axi_transaction r_tr);
    
        r_tr.axi_rresp      = vif.axi_rresp;
        
    endtask

endclass : axi_driver

