class axi_env extends uvm_env;

    `include "../parameters.svh"

    virtual interface axi_if vif;
    axi_agent axi_agent_master_[M_COUNT];
    axi_agent axi_agent_slave_[S_COUNT];
    
    axi_predictor predictor;
    axi_coverage_collector coverage_collector;
    
    axi_scoreboard scoreboard;
  
    `uvm_component_utils(axi_env)
    
    // new - constructor
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    // build_phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        for(int i = 0; i < M_COUNT; i = i + 1) begin
            axi_agent_master_[i] = axi_agent::type_id::create($sformatf("axi_agent_master_%0d", i), this);
            axi_agent_master_[i].is_slave = 0;
        end
        for(int i = 0; i < S_COUNT; i = i + 1) begin
            axi_agent_slave_[i] = axi_agent::type_id::create($sformatf("axi_agent_slave_%0d", i), this);
            axi_agent_slave_[i].is_slave = 1;
        end
        scoreboard = axi_scoreboard::type_id::create("axi_scoreboard", this);
        predictor = axi_predictor::type_id::create("axi_predictor", this);
        coverage_collector = axi_coverage_collector::type_id::create("axi_coverage_collector", this);
    endfunction : build_phase
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        for(int i = 0; i < M_COUNT; i = i + 1) begin
            axi_agent_master_[i].monitor.axi_analysis_port.connect(predictor.analysis_export);
            axi_agent_master_[i].monitor.axi_analysis_port.connect(coverage_collector.analysis_export);
            axi_agent_master_[i].monitor.axi_analysis_port.connect(scoreboard.monitor_collected_data);            
        end
        for(int i = 0; i < S_COUNT; i = i + 1) begin
            axi_agent_slave_[i].monitor.axi_analysis_port.connect(predictor.analysis_export);
            axi_agent_slave_[i].monitor.axi_analysis_port.connect(coverage_collector.analysis_export);
            axi_agent_slave_[i].monitor.axi_analysis_port.connect(scoreboard.monitor_collected_data); 
        end
        predictor.prediction_ap.connect(scoreboard.predictor_collected_data);
    endfunction
    
//    function void report_phase(uvm_phase phase);
//        super.report_phase(phase);
//        `uvm_info(get_full_name(), phase.get_name(), UVM_MEDIUM)
//    endfunction : report_phase

endclass : axi_env