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
        if (!uvm_config_db#(virtual interface axi_if)::get(this, "", "vif", vif))
            `uvm_fatal("axi_driver","No virtual interface specified for this instance")
    endfunction : connect_phase

    // UVM run_phase
    task run_phase(uvm_phase phase);
        axi_transaction req;
        super.run_phase(phase);
        reset();
        forever begin
            seq_item_port.get_next_item(req);
            case(req.transaction_type)
                AW:      write_addr(req);
                // W:       write_data(seq);
                // B:       received_resp_write(seq);
   		        // AR:      read_addr();
                // R:       read_data(rd_data); // + read response
    	        default: `uvm_fatal("axi_driver","No valid command")
            endcase
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

    endtask : write_addr

endclass : axi_driver

