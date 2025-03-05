class axi_read_sequence extends uvm_sequence#(axi_transaction);

    `uvm_object_utils(axi_read_sequence)

    function new(string name = "axi_read_sequence");
        super.new(name);
    endfunction

    virtual task body();
        axi_transaction rxn;

        rxn = axi_transaction::type_id::create("txn");
        if (!rxn.randomize()) `uvm_error("SEQ", "Randomization failed!")

        `uvm_info("SEQ", $sformatf("Generated Read Transaction:\n%s", rxn.sprint()), UVM_MEDIUM)
        send_request(rxn);
        wait_for_item_done();
        get_response(rrsp); 
    endtask

endclass : axi_read_sequence