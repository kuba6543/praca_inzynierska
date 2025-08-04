class axi_scoreboard extends uvm_scoreboard;

    `include "../parameters.svh"

     `uvm_component_utils(axi_scoreboard)
     uvm_analysis_imp#(axi_transaction, axi_scoreboard) monitor_collected_data;
     uvm_analysis_imp#(axi_transaction, axi_scoreboard) predictor_collected_data;
     // constructor of scoreboard
     function new (string name, uvm_component parent);
         super.new(name, parent);
     endfunction : new

     function void build_phase(uvm_phase phase);
         super.build_phase(phase);
         monitor_collected_data = new("monitor_collected_data", this);
         predictor_collected_data = new("predictor_collected_data", this);
     endfunction : build_phase

     function void write(axi_transaction pkt);
         $display("AXI Scoreboard: Packet received");
         if (monitor_collected_data == predictor_collected_data) begin
             `uvm_info("TEST", "Monitor and predictor collected data is the same", UVM_LOW);
         end else begin 
             `uvm_info("TEST", "Monitor and predictor collected data is NOT the same", UVM_MEDIUM);
         end
         pkt.print();
    endfunction

//    uvm_analysis_imp#(axi_transaction, axi_scoreboard) master_analysis_export[M_COUNT];
//    uvm_analysis_imp#(axi_transaction, axi_scoreboard) slave_analysis_export[S_COUNT];
    
//    function new (string name, uvm_component parent);
//    super.new(name, parent);
//    endfunction : new

//    function void build_phase(uvm_phase phase);
//        super.build_phase(phase);
//        for(int i = 0; i < M_COUNT; i = i + 1) begin
//            master_analysis_export[i] = new($sformatf("master_analysis_export[%0d]", i), this);
//        end
//        for(int i = 0; i < S_COUNT; i = i + 1) begin
//            slave_analysis_export[i] = new($sformatf("slave_analysis_export[%0d]", i), this);
//        end
//    endfunction : build_phase
    
//    virtual function void write(axi_transaction t);
//        // Compare, check protocol, or log
//        `uvm_info("SCOREBOARD", $sformatf("Received transaction: %s", t.convert2string()), UVM_LOW)
//    endfunction : write

//     virtual function void write_from_monitor(axi_sequence pkt);
//         $display("AXI Scoreboard: Packet received");
//         if (monitor_collected_data.compare(predictor_collected_data)) begin
//             `uvm_info("TEST", "Monitor and predictor collected data is the same", UVM_LOW);
//         end else begin 
//             `uvm_info("TEST", "Monitor and predictor collected data is NOT the same", UVM_MEDIUM);
//         end
//         pkt.print();
//    endfunction : write_from_monitor
    
endclass : axi_scoreboard