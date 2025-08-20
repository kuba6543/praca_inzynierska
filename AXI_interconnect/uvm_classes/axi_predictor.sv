class axi_predictor extends uvm_component;

    `include "../parameters.svh"

    uvm_analysis_imp #(axi_transaction, axi_predictor) analysis_export;

    `uvm_analysis_imp_decl(_axi_slave)
    `uvm_analysis_imp_decl(_axi_master)
    uvm_analysis_imp_axi_slave #(axi_transaction, axi_predictor) analysis_export_axi_slave;
    uvm_analysis_imp_axi_master #(axi_transaction, axi_predictor) analysis_export_axi_master;
    uvm_analysis_port #(axi_transaction) prediction_ap;
    axi_sequence bresp_seq, rresp_seq;
    axi_sequencer m_sequencer;
    integer amount_of_ongoing_transactions;
    bit objection_raised;

    `uvm_component_utils(axi_predictor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
        analysis_export_axi_slave = new("analysis_export_axi_slave", this);
        analysis_export_axi_master = new("analysis_export_axi_master", this);
        prediction_ap = new("prediction_ap", this);
        amount_of_ongoing_transactions = 0;
        objection_raised = 0;
    endfunction : new

    function void write(axi_transaction tr);
        case(tr.trans_type_e)
            axi_transaction::AW: begin
                fork
                    automatic axi_transaction tr_copy = tr;
                    begin
                        axi_sequence bresp_seq = axi_sequence::type_id::create("bresp_seq");
                        bresp_seq.transaction_type_to_generate = axi_transaction::B;
                        void'(bresp_seq.randomize());
                        bresp_seq.start(m_sequencer);
                    end
                join_none
            end
            axi_transaction::AR: begin
                fork
                    begin
                        axi_sequence rresp_seq = axi_sequence::type_id::create("rresp_seq");
                        rresp_seq.transaction_type_to_generate = axi_transaction::R;
                        void'(rresp_seq.randomize());
                        rresp_seq.start(m_sequencer);
                    end
                join_none
            end
        endcase
    endfunction : write
    
    virtual function void write_axi_slave(axi_transaction tr);
        axi_transaction predicted;
        predicted = new tr;
        prediction_ap.write(predicted);
        amount_of_ongoing_transactions = amount_of_ongoing_transactions + 1;
    endfunction : write_axi_slave
    
    virtual function void write_axi_master(axi_transaction tr);
        axi_transaction predicted;
        predicted = new tr;
        prediction_ap.write(predicted);
        amount_of_ongoing_transactions = amount_of_ongoing_transactions - 1;        
    endfunction : write_axi_master
    
    task run_phase(uvm_phase phase);
        phase.phase_done.set_drain_time(this, 5*CLK);
        forever begin
        #1ns;
            if (!objection_raised && amount_of_ongoing_transactions > 0) begin
                phase.raise_objection(this);
                objection_raised = 1;
            end
            if (objection_raised && amount_of_ongoing_transactions == 0) begin
                phase.drop_objection(this);
                objection_raised = 0;
            end
        end
    endtask : run_phase

endclass
