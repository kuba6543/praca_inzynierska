class axi_scoreboard extends uvm_scoreboard;

     `uvm_component_utils(axi_scoreboard)
//     uvm_analysis_imp #(axi_transaction, axi_scoreboard) monitor_collected_data;
//     uvm_analysis_imp #(axi_transaction, axi_scoreboard) predictor_collected_data;
     // constructor of scoreboard
     function new (string name, uvm_component parent);
         super.new(name, parent);
     endfunction : new

//     function void build_phase(uvm_phase phase);
//         super.build_phase(phase);
//         monitor_collected_data = new("monitor_collected_data", this);
//         predictor_collected_data = new("predictor_collected_data", this);
//     endfunction : build_phase
  
//     // write
//     virtual function void write_from_monitor(axi_sequence pkt);
//         $display("AXI Scoreboard: Packet received");
//         if (monitor_collected_data.compare(predictor_collected_data)) begin
//             `uvm_info("TEST", "Monitor and predictor collected data is the same", UVM_LOW);
//         end else begin 
//             `uvm_info("TEST", "Monitor and predictor collected data is NOT the same", UVM_MEDIUM);
//         end
//         //pkt.print();
//     endfunction : write_from_monitor
    
endclass : axi_scoreboard