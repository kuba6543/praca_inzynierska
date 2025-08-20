class axi_test extends uvm_test;

  	`uvm_component_utils(axi_test)

  	axi_env        env;
  	axi_sequence   aw_seq, w_seq, ar_seq;

  	function new (string name = "axi_test", uvm_component parent=null);
    	super.new(name,parent);
  	endfunction : new

  	virtual function void build_phase(uvm_phase phase);
    	super.build_phase(phase);
    	env = axi_env::type_id::create("env", this);
  	endfunction : build_phase

  	task run_phase(uvm_phase phase);
  	    uvm_root::get().print_topology();
  	    phase.raise_objection(this);
		
    	for (int i = 0; i < S_COUNT; i = i + 1) begin
    	
            aw_seq = axi_sequence::type_id::create("aw_seq");
            aw_seq.transaction_type_to_generate = axi_transaction::AW;
            aw_seq.length = 3;
            aw_seq.start(env.axi_agent_slave_[i].sequencer);

            w_seq = axi_sequence::type_id::create("w_seq");
            w_seq.transaction_type_to_generate = axi_transaction::W;
            w_seq.length = 3;
            w_seq.start(env.axi_agent_slave_[i].sequencer);

            ar_seq = axi_sequence::type_id::create("ar_seq");
            ar_seq.transaction_type_to_generate = axi_transaction::AR;
            ar_seq.length = 4;
            ar_seq.start(env.axi_agent_slave_[i].sequencer);
    	
    	end
    	
    	phase.drop_objection(this);
	endtask : run_phase

endclass : axi_test