class axi_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(axi_scoreboard)
    uvm_analysis_imp#(axi_transaction, axi_scoreboard) item_collected_export;

    // constructor of scoreboard
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item_collected_export = new("item_collected_export", this);
    endfunction: build_phase
  
    // write
    virtual function void write(axi_sequence pkt);
        $display("AXI Scoreboard: Packet recived");
        pkt.print();
    endfunction : write

endclass : axi_scoreboard