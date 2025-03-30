class axi_test extends uvm_test;

  	`uvm_component_utils(axi_test)

  	axi_env        env;
  	axi_sequence   seq;

  	function new (string name = "axi_test", uvm_component parent=null);
    	super.new(name,parent);
  	endfunction : new

  	virtual function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
    	env = axi_env::type_id::create("env", this);
  	endfunction : build_phase

  	task run_phase(uvm_phase phase);
		seq = axi_sequence::type_id::create("seq");
    	seq.start(env.axi_agent_slave.sequencer);
    	seq.start(env.axi_agent_master.sequencer);
	endtask : run_phase

endclass : axi_test