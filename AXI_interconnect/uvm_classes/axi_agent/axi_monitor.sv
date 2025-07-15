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
            `uvm_fatal("NOVIF","No virtual interface specified for this instance");
    endfunction: build_phase

    virtual task run_phase(uvm_phase phase);
        trans_collected = axi_transaction::type_id::create("trans_collected");
        axi_analysis_port.write(trans_collected);
    endtask : run_phase

endclass : axi_monitor