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
        trans_collected = axi_transaction::type_id::create("trans_collected");
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        @(posedge vif.clk);
        wait(vif.rst == 0);
//        trans_collected = axi_transaction::type_id::create("trans_collected");
//        forever begin
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
            trans_collected.axi_awvalid = vif.axi_awvalid;
            trans_collected.axi_wdata   = vif.axi_wdata;
            trans_collected.axi_wstrb   = vif.axi_wstrb;
            trans_collected.axi_wlast   = vif.axi_wlast;
            trans_collected.axi_wuser   = vif.axi_wuser;
            trans_collected.axi_wvalid  = vif.axi_wvalid;
            trans_collected.axi_bready  = vif.axi_bready;
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
            trans_collected.axi_arvalid = vif.axi_arvalid;
            trans_collected.axi_rready  = vif.axi_rready;
            
            axi_analysis_port.write(trans_collected);
            `uvm_info("MON", $sformatf("Sampled transaction:\n%s", trans_collected.sprint()), UVM_MEDIUM)
//        end
    endtask : run_phase

endclass : axi_monitor