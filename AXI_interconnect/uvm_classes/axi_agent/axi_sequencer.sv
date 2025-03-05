class axi_sequencer extends uvm_sequencer#(axi_transaction);
    // UVM automation macros for general components
    `uvm_component_utils(axi_sequencer)

    // constructor of AXI sequencer
    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction
   
endclass : axi_sequencer