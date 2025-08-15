class axi_monitor extends uvm_monitor;

    //declaring monitor components
    virtual axi_if vif;
    uvm_analysis_port #(axi_transaction) axi_analysis_port;
    axi_transaction trans_collected;

    // UVM automation macros for general components
    `uvm_component_utils(axi_monitor)

    // constructor of AXI monitor
    function new (string name, uvm_component parent);
        super.new(name, parent);
        trans_collected = new();
        axi_analysis_port = new("axi_analysis_port", this);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_if)::get(this, "", "vif", vif))   
            `uvm_fatal(get_full_name(),"No virtual interface specified for this instance");
//        trans_collected = axi_transaction::type_id::create("trans_collected");
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            @(posedge vif.clk);
            if (vif.axi_awvalid && vif.axi_awready && !vif.rst) begin
                trans_collected = axi_transaction::type_id::create("aw_trans");
                trans_collected.axi_awid    = vif.axi_awid;
                trans_collected.axi_awaddr  = vif.axi_awaddr;
                trans_collected.axi_awlen   = vif.axi_awlen;
                trans_collected.axi_awsize  = vif.axi_awsize;
                trans_collected.axi_awburst = vif.axi_awburst;
                trans_collected.axi_awlock  = vif.axi_awlock;
                trans_collected.axi_awcache = vif.axi_awcache;
                trans_collected.axi_awprot  = vif.axi_awprot;
                trans_collected.axi_awqos   = vif.axi_awqos;
                trans_collected.axi_awuser  = vif.axi_awuser;
                axi_analysis_port.write(trans_collected);
                `uvm_info("MON", $sformatf("Sampled AW transaction:\n%s", trans_collected.sprint()), UVM_MEDIUM)                                
            end
            if (vif.axi_wvalid && vif.axi_wready && !vif.rst) begin
                trans_collected = axi_transaction::type_id::create("w_trans");            
                trans_collected.axi_wdata   = vif.axi_wdata;
                trans_collected.axi_wstrb   = vif.axi_wstrb;
                trans_collected.axi_wuser   = vif.axi_wuser;
                axi_analysis_port.write(trans_collected);
                `uvm_info("MON", $sformatf("Sampled W transaction:\n%s", trans_collected.sprint()), UVM_MEDIUM)                                
            end
            if (vif.axi_bvalid && vif.axi_bready && !vif.rst) begin
                trans_collected = axi_transaction::type_id::create("b_trans");            
                trans_collected.axi_bid     = vif.axi_bid;
                trans_collected.axi_bresp   = vif.axi_bresp;
                trans_collected.axi_buser   = vif.axi_buser;
                axi_analysis_port.write(trans_collected);
                `uvm_info("MON", $sformatf("Sampled B transaction:\n%s", trans_collected.sprint()), UVM_MEDIUM)
            end
            if (vif.axi_arvalid && vif.axi_arready && !vif.rst) begin
                @(posedge vif.clk);
                trans_collected = axi_transaction::type_id::create("ar_trans");                                                            
                trans_collected.axi_arid    = vif.axi_arid;
                trans_collected.axi_araddr  = vif.axi_araddr;
                trans_collected.axi_arlen   = vif.axi_arlen;
                trans_collected.axi_arsize  = vif.axi_arsize;
                trans_collected.axi_arburst = vif.axi_arburst;
                trans_collected.axi_arlock  = vif.axi_arlock;
                trans_collected.axi_arcache = vif.axi_arcache;
                trans_collected.axi_arprot  = vif.axi_arprot;
                trans_collected.axi_arqos   = vif.axi_arqos;
                trans_collected.axi_aruser  = vif.axi_aruser;
                axi_analysis_port.write(trans_collected);
                `uvm_info("MON", $sformatf("Sampled AR transaction:\n%s", trans_collected.sprint()), UVM_MEDIUM)                                
            end
            if (vif.axi_rvalid && vif.axi_rready && !vif.rst) begin
                @(posedge vif.clk);            
                trans_collected = axi_transaction::type_id::create("r_trans"); 
                trans_collected.axi_rid     = vif.axi_rid;
                trans_collected.axi_rdata   = vif.axi_rdata;
                trans_collected.axi_rresp   = vif.axi_rresp;
                trans_collected.axi_ruser   = vif.axi_ruser;
                axi_analysis_port.write(trans_collected);
                `uvm_info("MON", $sformatf("Sampled R transaction:\n%s", trans_collected.sprint()), UVM_MEDIUM)
            end
        end
    endtask : run_phase

endclass : axi_monitor