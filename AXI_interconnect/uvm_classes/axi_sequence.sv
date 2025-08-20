class axi_sequence extends uvm_sequence #(axi_transaction);

  rand axi_transaction::transaction_type_e transaction_type_to_generate;
  rand int unsigned length; // np. d³ugoœæ burstu

  `uvm_object_utils(axi_sequence)

  function new(string name="axi_sequence");
    super.new(name);
  endfunction

  task body();
    axi_transaction tr;

    tr = axi_transaction::type_id::create("tr");
    assert(tr.randomize() with {
      if (transaction_type_to_generate == axi_transaction::W) axi_awlen <= length;
      if (transaction_type_to_generate == axi_transaction::R) axi_arlen <= length;
    });

    `uvm_info("SEQ", $sformatf("Generated transaction:\n%s", tr.sprint()), UVM_LOW)

    start_item(tr);
    finish_item(tr);
  endtask

endclass : axi_sequence