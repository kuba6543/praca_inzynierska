class axi_sequence extends uvm_sequence#(axi_transaction);

    `uvm_object_utils(axi_sequence)

    function new(string name = "axi_write_sequence");
        super.new(name);
    endfunction

    virtual task body();
        axi_transaction rxn;
        axi_transaction txn;

        rxn = axi_transaction::type_id::create("rxn");
        txn = axi_transaction::type_id::create("txn");
        if (!rxn.randomize() || !txn.randomize()) `uvm_error("SEQ", "Randomization failed!")

        `uvm_info("SEQ", $sformatf("Generated READ Transaction:\n%s", txn.sprint()), UVM_MEDIUM)
        send_request(rxn);
        wait_for_item_done();
        get_response(rrsp);

        `uvm_info("SEQ", $sformatf("Generated READ Transaction:\n%s", txn.sprint()), UVM_MEDIUM)
        send_request(txn);
        wait_for_item_done();
        get_response(brsp);  
    endtask

endclass : axi_sequence