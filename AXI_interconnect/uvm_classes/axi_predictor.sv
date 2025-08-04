class axi_predictor extends uvm_component;

    // Receives actual transactions from monitor
    uvm_analysis_imp #(axi_transaction, axi_predictor) analysis_export;

    // Sends predicted transactions
    uvm_analysis_port #(axi_transaction) prediction_ap;

    // Internal queue for expected data (optional)
    axi_transaction expected_q[$];

    `uvm_component_utils(axi_predictor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
        prediction_ap = new("prediction_ap", this);
    endfunction

    virtual function void write(axi_transaction t);
        // Predict based on incoming monitored data
        axi_transaction predicted;

        // Basic example: copy monitored data as prediction (modify for actual logic)
        predicted = new t; // copy constructor
        prediction_ap.write(predicted);
    endfunction

endclass
