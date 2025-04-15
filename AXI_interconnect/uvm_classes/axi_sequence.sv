class axi_sequence extends uvm_sequence#(axi_transaction);

    `uvm_object_utils(axi_sequence)

    function new(string name = "axi_sequence");
        super.new(name);
    endfunction

    virtual task body();
        axi_transaction transaction;

        transaction = axi_transaction::type_id::create("transaction");
        if (!transaction.randomize()) `uvm_error("SEQ", "Randomization failed!")

        `uvm_info("SEQ", $sformatf("Generated transaction:\n%s", transaction.sprint()), UVM_MEDIUM)
        send_request(transaction);
        wait_for_item_done();
        get_response(vif.m_axi_rresp); 

    endtask

endclass : axi_sequence