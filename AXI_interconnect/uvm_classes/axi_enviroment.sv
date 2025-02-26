class axi_enviroment extends uvm_env;

    `include "../parameters.svh"

    axi_agent_master axi_agent_master;
    axi_agent_slave axi_agent_slave;
  
    `uvm_component_utils(axi_enviroment)
    
    // new - constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        for(int i = 0; i < M_COUNT; i = i + 1) begin
            axi_agent_master = axi_agent_master::type_id::create("axi_agent_master", this);
        end
        for(int i = 0; i < S_COUNT; i = i + 1) begin
            axi_agent_slave = axi_agent_slave::type_id::create("axi_agent_slave", this);
        end
    endfunction : build_phase

endclass : axi_enviroment