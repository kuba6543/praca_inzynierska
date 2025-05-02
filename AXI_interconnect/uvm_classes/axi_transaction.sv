class axi_transaction extends uvm_sequence_item;
    
    transaction_type_t transaction_type;

    /*
     * AXI input interfaces
     */    
    
    rand bit [ID_WIDTH-1:0]     axi_awid;
    rand bit [ADDR_WIDTH-1:0]   axi_awaddr;
    rand bit [8-1:0]            axi_awlen;
    rand bit [3-1:0]            axi_awsize;
    rand bit [2-1:0]            axi_awburst;
    rand bit [1:0]              axi_awlock;
    rand bit [4-1:0]            axi_awcache;
    rand bit [3-1:0]            axi_awprot;
    rand bit [4-1:0]            axi_awqos;
    rand bit [AWUSER_WIDTH-1:0] axi_awuser;
    rand bit [1:0]              axi_awvalid;
    rand bit [DATA_WIDTH-1:0]   axi_wdata;
    rand bit [STRB_WIDTH-1:0]   axi_wstrb;
    rand bit [1:0]              axi_wlast;
    rand bit [WUSER_WIDTH-1:0]  axi_wuser;
    rand bit [1:0]              axi_wvalid;
    rand bit [1:0]              axi_bready;
    rand bit [ID_WIDTH-1:0]     axi_arid;
    rand bit [ADDR_WIDTH-1:0]   axi_araddr;
    rand bit [8-1:0]            axi_arlen;
    rand bit [3-1:0]            axi_arsize;
    rand bit [2-1:0]            axi_arburst;
    rand bit [1:0]              axi_arlock;
    rand bit [4-1:0]            axi_arcache;
    rand bit [3-1:0]            axi_arprot;
    rand bit [4-1:0]            axi_arqos;
    rand bit [ARUSER_WIDTH-1:0] axi_aruser;
    rand bit [1:0]              axi_arvalid;
    rand bit [1:0]              axi_rready;

    /*
     * AXI output interfaces
     */

    rand bit [1:0]              axi_awready;
    rand bit [1:0]              axi_wready;
    rand bit [ID_WIDTH-1:0]     axi_bid;
    rand bit [2-1:0]            axi_bresp;
    rand bit [BUSER_WIDTH-1:0]  axi_buser;
    rand bit [1:0]              axi_bvalid;
    rand bit [1:0]              axi_arready;
    rand bit [ID_WIDTH-1:0]     axi_rid;
    rand bit [DATA_WIDTH-1:0]   axi_rdata;
    rand bit [2-1:0]            axi_rresp;
    rand bit [1:0]              axi_rlast;
    rand bit [RUSER_WIDTH-1:0]  axi_ruser;
    rand bit [1:0]              axi_rvalid;

    /*
     * AXI master output interfaces
     */


    `uvm_object_utils_begin(axi_transaction)
        `uvm_field_int(axi_awid, UVM_ALL_ON)
        `uvm_field_int(axi_awaddr, UVM_ALL_ON)
        `uvm_field_int(axi_awlen, UVM_ALL_ON)
        `uvm_field_int(axi_awsize, UVM_ALL_ON)
        `uvm_field_int(axi_awburst, UVM_ALL_ON)
        `uvm_field_int(axi_awlock, UVM_ALL_ON)
        `uvm_field_int(axi_awcache, UVM_ALL_ON)
        `uvm_field_int(axi_awprot, UVM_ALL_ON)
        `uvm_field_int(axi_awqos, UVM_ALL_ON)
        `uvm_field_int(axi_awuser, UVM_ALL_ON)
        `uvm_field_int(axi_awvalid, UVM_ALL_ON)
        `uvm_field_int(axi_wdata, UVM_ALL_ON)
        `uvm_field_int(axi_wstrb, UVM_ALL_ON)
        `uvm_field_int(axi_wlast, UVM_ALL_ON)
        `uvm_field_int(axi_wuser, UVM_ALL_ON)
        `uvm_field_int(axi_wvalid, UVM_ALL_ON)
        `uvm_field_int(axi_bready, UVM_ALL_ON)
        `uvm_field_int(axi_arid, UVM_ALL_ON)
        `uvm_field_int(axi_araddr, UVM_ALL_ON)
        `uvm_field_int(axi_arlen, UVM_ALL_ON)
        `uvm_field_int(axi_arsize, UVM_ALL_ON)
        `uvm_field_int(axi_arburst, UVM_ALL_ON)
        `uvm_field_int(axi_arlock, UVM_ALL_ON)
        `uvm_field_int(axi_arcache, UVM_ALL_ON)
        `uvm_field_int(axi_arprot, UVM_ALL_ON)
        `uvm_field_int(axi_arqos, UVM_ALL_ON)
        `uvm_field_int(axi_aruser, UVM_ALL_ON)
        `uvm_field_int(axi_arvalid, UVM_ALL_ON)
        `uvm_field_int(axi_rready, UVM_ALL_ON)
    `uvm_object_utils_end

    function new  (string name = "axi_transaction");
        super.new(name);
    endfunction : new

    constraint AxBURST_RESERVED {
            axi_awburst != 2'b11;
            axi_arburst != 2'b11;
    };

    constraint AxLOCK_RESERVED {
            axi_awlock != 2'b11;
            axi_arlock != 2'b11;
    };
    constraint BRESP_RESERVED {
            axi_bresp != 3'b110;
    };

    constraint RRESP_RESERVED {
            axi_rresp != 3'b111;
    };

endclass : axi_transaction