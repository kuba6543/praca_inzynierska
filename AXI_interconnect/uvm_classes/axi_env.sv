class axi_env extends uvm_env;

    `include "../parameters.svh"

    virtual interface axi_if vif;
    axi_agent_master axi_master_agent_inst[M_COUNT];
    axi_agent_slave axi_slave_agent_inst[S_COUNT];
    axi_scoreboard axi_scoreboard_inst;
  
    `uvm_component_utils(axi_env)
    
    // new - constructor
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        for(int i = 0; i < M_COUNT; i = i + 1) begin
            axi_master_agent_inst[i] = axi_agent_master::type_id::create($sformatf("axi_agent_master_%1d", i), this);
        end
        for(int i = 0; i < S_COUNT; i = i + 1) begin
            axi_slave_agent_inst[i] = axi_agent_slave::type_id::create($sformatf("axi_agent_master_%1d", i), this);
        end
        axi_scoreboard_inst = axi_scoreboard::type_id::create("axi_scoreboard_inst", this);
    endfunction : build_phase

endclass : axi_env