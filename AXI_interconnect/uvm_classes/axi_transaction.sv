class axi_transaction extends uvm_sequence_item;
    
    /*
     * AXI slave input interfaces
     */    
    
    rand bit [S_COUNT*ID_WIDTH-1:0]     s_axi_awid;
    rand bit [S_COUNT*ADDR_WIDTH-1:0]   s_axi_awaddr;
    rand bit [S_COUNT*8-1:0]            s_axi_awlen;
    rand bit [S_COUNT*3-1:0]            s_axi_awsize;
    rand bit [S_COUNT*2-1:0]            s_axi_awburst;
    rand bit [S_COUNT-1:0]              s_axi_awlock;
    rand bit [S_COUNT*4-1:0]            s_axi_awcache;
    rand bit [S_COUNT*3-1:0]            s_axi_awprot;
    rand bit [S_COUNT*4-1:0]            s_axi_awqos;
    rand bit [S_COUNT*AWUSER_WIDTH-1:0] s_axi_awuser;
    rand bit [S_COUNT-1:0]              s_axi_awvalid;
    rand bit [S_COUNT*DATA_WIDTH-1:0]   s_axi_wdata;
    rand bit [S_COUNT*STRB_WIDTH-1:0]   s_axi_wstrb;
    rand bit [S_COUNT-1:0]              s_axi_wlast;
    rand bit [S_COUNT*WUSER_WIDTH-1:0]  s_axi_wuser;
    rand bit [S_COUNT-1:0]              s_axi_wvalid;
    rand bit [S_COUNT-1:0]              s_axi_bready;
    rand bit [S_COUNT*ID_WIDTH-1:0]     s_axi_arid;
    rand bit [S_COUNT*ADDR_WIDTH-1:0]   s_axi_araddr;
    rand bit [S_COUNT*8-1:0]            s_axi_arlen;
    rand bit [S_COUNT*3-1:0]            s_axi_arsize;
    rand bit [S_COUNT*2-1:0]            s_axi_arburst;
    rand bit [S_COUNT-1:0]              s_axi_arlock;
    rand bit [S_COUNT*4-1:0]            s_axi_arcache;
    rand bit [S_COUNT*3-1:0]            s_axi_arprot;
    rand bit [S_COUNT*4-1:0]            s_axi_arqos;
    rand bit [S_COUNT*ARUSER_WIDTH-1:0] s_axi_aruser;
    rand bit [S_COUNT-1:0]              s_axi_arvalid;
    rand bit [S_COUNT-1:0]              s_axi_rready;

    /*
     * AXI master input interfaces
     */

    rand bit [M_COUNT-1:0]              m_axi_awready;
    rand bit [M_COUNT-1:0]              m_axi_wready;
    rand bit [M_COUNT*ID_WIDTH-1:0]     m_axi_bid;
    rand bit [M_COUNT*2-1:0]            m_axi_bresp;
    rand bit [M_COUNT*BUSER_WIDTH-1:0]  m_axi_buser;
    rand bit [M_COUNT-1:0]              m_axi_bvalid;
    rand bit [M_COUNT-1:0]              m_axi_arready;
    rand bit [M_COUNT*ID_WIDTH-1:0]     m_axi_rid;
    rand bit [M_COUNT*DATA_WIDTH-1:0]   m_axi_rdata;
    rand bit [M_COUNT*2-1:0]            m_axi_rresp;
    rand bit [M_COUNT-1:0]              m_axi_rlast;
    rand bit [M_COUNT*RUSER_WIDTH-1:0]  m_axi_ruser;
    rand bit [M_COUNT-1:0]              m_axi_rvalid;

    /*
     * AXI slave output interfaces
     */

    bit [S_COUNT-1:0]              s_axi_awready;
    bit [S_COUNT-1:0]              s_axi_wready;
    bit [S_COUNT*ID_WIDTH-1:0]     s_axi_bid;
    bit [S_COUNT*2-1:0]            s_axi_bresp;
    bit [S_COUNT*BUSER_WIDTH-1:0]  s_axi_buser;
    bit [S_COUNT-1:0]              s_axi_bvalid;
    bit [S_COUNT-1:0]              s_axi_arready;
    bit [S_COUNT*ID_WIDTH-1:0]     s_axi_rid;
    bit [S_COUNT*DATA_WIDTH-1:0]   s_axi_rdata;
    bit [S_COUNT*2-1:0]            s_axi_rresp;
    bit [S_COUNT-1:0]              s_axi_rlast;
    bit [S_COUNT*RUSER_WIDTH-1:0]  s_axi_ruser;
    bit [S_COUNT-1:0]              s_axi_rvalid;

    /*
     * AXI master output interfaces
     */

    bit [M_COUNT*ID_WIDTH-1:0]     m_axi_awid;
    bit [M_COUNT*ADDR_WIDTH-1:0]   m_axi_awaddr;
    bit [M_COUNT*8-1:0]            m_axi_awlen;
    bit [M_COUNT*3-1:0]            m_axi_awsize;
    bit [M_COUNT*2-1:0]            m_axi_awburst;
    bit [M_COUNT-1:0]              m_axi_awlock;
    bit [M_COUNT*4-1:0]            m_axi_awcache;
    bit [M_COUNT*3-1:0]            m_axi_awprot;
    bit [M_COUNT*4-1:0]            m_axi_awqos;
    bit [M_COUNT*4-1:0]            m_axi_awregion;
    bit [M_COUNT*AWUSER_WIDTH-1:0] m_axi_awuser;
    bit [M_COUNT-1:0]              m_axi_awvalid;
    bit [M_COUNT*DATA_WIDTH-1:0]   m_axi_wdata;
    bit [M_COUNT*STRB_WIDTH-1:0]   m_axi_wstrb;
    bit [M_COUNT-1:0]              m_axi_wlast;
    bit [M_COUNT*WUSER_WIDTH-1:0]  m_axi_wuser;
    bit [M_COUNT-1:0]              m_axi_wvalid;
    bit [M_COUNT-1:0]              m_axi_bready;
    bit [M_COUNT*ID_WIDTH-1:0]     m_axi_arid;
    bit [M_COUNT*ADDR_WIDTH-1:0]   m_axi_araddr;
    bit [M_COUNT*8-1:0]            m_axi_arlen;
    bit [M_COUNT*3-1:0]            m_axi_arsize;
    bit [M_COUNT*2-1:0]            m_axi_arburst;
    bit [M_COUNT-1:0]              m_axi_arlock;
    bit [M_COUNT*4-1:0]            m_axi_arcache;
    bit [M_COUNT*3-1:0]            m_axi_arprot;
    bit [M_COUNT*4-1:0]            m_axi_arqos;
    bit [M_COUNT*4-1:0]            m_axi_arregion;
    bit [M_COUNT*ARUSER_WIDTH-1:0] m_axi_aruser;
    bit [M_COUNT-1:0]              m_axi_arvalid;
    bit [M_COUNT-1:0]              m_axi_rready;


    `uvm_object_utils_begin(axi_transaction)
        `uvm_field_int(s_axi_awid, UVM_ALL_ON)
        `uvm_field_int(s_axi_awaddr, UVM_ALL_ON)
        `uvm_field_int(s_axi_awlen, UVM_ALL_ON)
        `uvm_field_int(s_axi_awsize, UVM_ALL_ON)
        `uvm_field_int(s_axi_awburst, UVM_ALL_ON)
        `uvm_field_int(s_axi_awlock, UVM_ALL_ON)
        `uvm_field_int(s_axi_awcache, UVM_ALL_ON)
        `uvm_field_int(s_axi_awprot, UVM_ALL_ON)
        `uvm_field_int(s_axi_awqos, UVM_ALL_ON)
        `uvm_field_int(s_axi_awuser, UVM_ALL_ON)
        `uvm_field_int(s_axi_awvalid, UVM_ALL_ON)
        `uvm_field_int(s_axi_wdata, UVM_ALL_ON)
        `uvm_field_int(s_axi_wstrb, UVM_ALL_ON)
        `uvm_field_int(s_axi_wlast, UVM_ALL_ON)
        `uvm_field_int(s_axi_wuser, UVM_ALL_ON)
        `uvm_field_int(s_axi_wvalid, UVM_ALL_ON)
        `uvm_field_int(s_axi_bready, UVM_ALL_ON)
        `uvm_field_int(s_axi_arid, UVM_ALL_ON)
        `uvm_field_int(s_axi_araddr, UVM_ALL_ON)
        `uvm_field_int(s_axi_arlen, UVM_ALL_ON)
        `uvm_field_int(s_axi_arsize, UVM_ALL_ON)
        `uvm_field_int(s_axi_arburst, UVM_ALL_ON)
        `uvm_field_int(s_axi_arlock, UVM_ALL_ON)
        `uvm_field_int(s_axi_arcache, UVM_ALL_ON)
        `uvm_field_int(s_axi_arprot, UVM_ALL_ON)
        `uvm_field_int(s_axi_arqos, UVM_ALL_ON)
        `uvm_field_int(s_axi_aruser, UVM_ALL_ON)
        `uvm_field_int(s_axi_arvalid, UVM_ALL_ON)
        `uvm_field_int(s_axi_rready, UVM_ALL_ON)
        `uvm_field_int(m_axi_awready, UVM_ALL_ON)
        `uvm_field_int(m_axi_wready, UVM_ALL_ON)
        `uvm_field_int(m_axi_bid, UVM_ALL_ON)
        `uvm_field_int(m_axi_bresp, UVM_ALL_ON)
        `uvm_field_int(m_axi_buser, UVM_ALL_ON)
        `uvm_field_int(m_axi_bvalid, UVM_ALL_ON)
        `uvm_field_int(m_axi_arready, UVM_ALL_ON)
        `uvm_field_int(m_axi_rid, UVM_ALL_ON)
        `uvm_field_int(m_axi_rdata, UVM_ALL_ON)
        `uvm_field_int(m_axi_rresp, UVM_ALL_ON)
        `uvm_field_int(m_axi_rlast, UVM_ALL_ON)
        `uvm_field_int(m_axi_ruser, UVM_ALL_ON)
        `uvm_field_int(m_axi_rvalid, UVM_ALL_ON)
    `uvm_object_utils_end

    function new  (string name = "axi_transaction");
        super.new(name);
    endfunction : new

    constraint AxBURST_RESERVED {
            m_axi_awburst != 2'b11;
            m_axi_arburst != 2'b11;
            s_axi_awburst != 2'b11;
            s_axi_arburst != 2'b11;
    };

    constraint AxLOCK_RESERVED {
            m_axi_awlock != 2'b11;
            m_axi_arlock != 2'b11;
            s_axi_awlock != 2'b11;
            s_axi_arlock != 2'b11;
    };
    constraint BRESP_RESERVED {
            m_axi_bresp != 3'b110;
            s_axi_bresp != 3'b110;
    };

    constraint RRESP_RESERVED {
            m_axi_rresp != 3'b111;
            s_axi_rresp != 3'b111;
    };

endclass : axi_transaction