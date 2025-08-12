class axi_sequence extends uvm_sequence #(axi_transaction);

    `uvm_object_utils(axi_sequence)
    
    virtual axi_if vif;

    function new(string name = "axi_sequence");
        super.new(name);
    endfunction

    virtual task body();
        axi_transaction transaction;

        transaction = axi_transaction::type_id::create("transaction");
        if (!transaction.randomize()) `uvm_error("SEQ", "Randomization failed!")
        `uvm_info("SEQ", $sformatf("Generated transaction:\n%s", transaction.sprint()), UVM_MEDIUM)
        
        wait_for_grant();
        send_request(transaction);
        wait_for_item_done();
//        get_response(vif.axi_bresp); 
    
//        #100ns;
    endtask

endclass : axi_sequence