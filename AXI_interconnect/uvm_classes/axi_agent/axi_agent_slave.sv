class axi_agent_master extends uvm_agent;
  //declaring agent components
    axi_driver_slave      driver;
    axi_sequencer         sequencer;
    axi_monitor           monitor;

  // UVM automation macros for general components
    `uvm_component_utils(axi_agent)

  // constructor of AXI agent
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // build agent, whether is passive or active
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(get_is_active() == UVM_ACTIVE) begin
            driver = axi_driver_slave::type_id::create("driver", this);
            sequencer = axi_sequencer::type_id::create("sequencer", this);
        end
        monitor = axi_monitor::type_id::create("monitor", this);
    endfunction : build_phase

  // connect driver with sequencer if the agent is active
    function void connect_phase(uvm_phase phase);
        if(get_is_active() == UVM_ACTIVE) begin
        driver.seq_item_port.connect(sequencer.seq_item_export);
    end
    endfunction : connect_phase

endclass : axi_agent_master