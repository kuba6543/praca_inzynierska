class axi_sequence extends uvm_sequence #(axi_transaction);

    `uvm_object_utils(axi_sequence)
    
    virtual axi_if vif;

    function new(string name = "axi_sequence");
        super.new(name);
    endfunction

    virtual task body();
        axi_transaction transaction;

        repeat(10) begin
            transaction = axi_transaction::type_id::create("transaction");
            start_item(transaction);
            if (!transaction.randomize()) begin
                `uvm_error("SEQ", "Randomization failed!")
            end
            `uvm_info("SEQ", $sformatf("Generated transaction:\n%s", transaction.sprint()), UVM_MEDIUM)
//            wait_for_grant();
//            send_request(transaction);
//            wait_for_item_done();
            finish_item(transaction);
        end
    endtask

endclass : axi_sequence