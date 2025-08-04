class axi_coverage_collector extends uvm_component;

    `uvm_component_utils(axi_coverage_collector)

    // Analysis implementation port
    uvm_analysis_imp#(axi_transaction, axi_coverage_collector) analysis_export;

    // Transaction for sampling
    axi_transaction trans;

    // Covergroup definition
    covergroup axi_cov;  // optional: remove if not using clocking block

        // Coverpoint: Transaction type (custom enum)
        coverpoint trans.transaction_type;

        // Coverpoint: Write address properties
        coverpoint trans.axi_awaddr {
            bins low_addr     = {[32'h0000_0000 : 32'h0000_0FFF]};
            bins mid_addr     = {[32'h0000_1000 : 32'h000F_FFFF]};
            bins high_addr    = {[32'h0010_0000 : 32'hFFFF_FFFF]};
        }

        coverpoint trans.axi_awburst {
            bins fixed = {2'b00};
            bins incr  = {2'b01};
            bins wrap  = {2'b10};
            illegal_bins reserved = {2'b11};
        }

        coverpoint trans.axi_awlen {
            bins single = {0};
            bins burst4 = {3};
            bins burst8 = {7};
            bins max    = {255};
        }

        coverpoint trans.axi_awlock {
            bins normal = {2'b00};
            bins excl   = {2'b01, 2'b10};
            illegal_bins reserved = {2'b11};
        }

        // Coverpoint: Write data
        coverpoint trans.axi_wdata {
            bins all_zeros = {32'h0000_0000};
            bins all_ones  = {32'hFFFF_FFFF};
            bins pattern   = {[32'h0000_0001 : 32'h0000_00FF]};
        }

        coverpoint trans.axi_wstrb {
            bins none = {4'b0000};
            bins all  = {4'b1111};
            bins odd  = {4'b0101};
            bins even = {4'b1010};
        }

        // Coverpoint: Read address properties
        coverpoint trans.axi_araddr {
            bins low_addr     = {[32'h0000_0000 : 32'h0000_0FFF]};
            bins high_addr    = {[32'h0010_0000 : 32'hFFFF_FFFF]};
        }

        coverpoint trans.axi_arburst {
            bins fixed = {2'b00};
            bins incr  = {2'b01};
            bins wrap  = {2'b10};
            illegal_bins reserved = {2'b11};
        }

        coverpoint trans.axi_arlen {
            bins single = {0};
            bins max    = {255};
        }

        coverpoint trans.axi_arlock {
            bins normal = {2'b00};
            bins excl   = {2'b01, 2'b10};
            illegal_bins reserved = {2'b11};
        }

        // Response coverage
        coverpoint trans.axi_bresp {
            bins okay     = {2'b00};
            bins exokay   = {2'b01};
            bins slverr   = {2'b10};
            bins decerr   = {2'b11};
        }

        coverpoint trans.axi_rresp {
            bins okay     = {2'b00};
            bins exokay   = {2'b01};
            bins slverr   = {2'b10};
            bins decerr   = {2'b11};
        }

        // Cross coverage
//        cross trans.axi_awburst, trans.axi_awlen;
//        cross trans.axi_arburst, trans.axi_arlen;
//        cross trans.axi_awvalid, trans.axi_awready;
//        cross trans.axi_arvalid, trans.axi_arready;

    endgroup : axi_cov

    function new(string name = "axi_coverage_collector", uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
        axi_cov = new();
    endfunction

    // Write from monitor
    function void write(axi_transaction t);
        trans = t;
        axi_cov.sample();
    endfunction

endclass