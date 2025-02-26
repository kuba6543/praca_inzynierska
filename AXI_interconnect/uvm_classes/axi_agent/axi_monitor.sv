class axi_monitor extends uvm_monitor;
    //declaring driver component
   virtual interface axi_if   vif;

    // UVM automation macros for general components
    `uvm_component_utils(axi_monitor)

    uvm_analysis_port #(axi_transaction) axi_analysis_port;
    
    axi_seq trans_collected;

    // constructor of AXI monitor
    function new (string name, uvm_component parent);
        super.new(name, parent);
        trans_collected = new();
        axi_analysis_port = new("axi_analysis_port", this);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual axi_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    endfunction: build_phase


    virtual task run_phase(uvm_phase phase);
        axi_analysis_port.write(trans_collected);
    endtask : run_phase


endclass : axi_monitor