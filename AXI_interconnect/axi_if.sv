interface axi_if(input logic clk, reset);

    `include "parameters.svh"

    // AXI Slave Address Write

    wire [ID_WIDTH-1:0]     s_axi_awid;
    wire [ADDR_WIDTH-1:0]   s_axi_awaddr;
    wire [7:0]              s_axi_awlen;
    wire [2:0]              s_axi_awsize;
    wire [1:0]              s_axi_awburst;
    wire                    s_axi_awlock;
    wire [5:0]              s_axi_awcache;
    wire [2:0]              s_axi_awprot;
    wire [3:0]              s_axi_awqos;
    wire [AWUSER_WIDTH-1:0] s_axi_awuser;
    wire                    s_axi_awvalid;
    wire                    s_axi_awready;

   // AXI Slave Write

    wire [DATA_WIDTH-1:0]   s_axi_wdata;
    wire [STRB_WIDTH-1:0]   s_axi_wstrb;
    wire                    s_axi_wlast;
    wire [WUSER_WIDTH-1:0]  s_axi_wuser;
    wire                    s_axi_wvalid;
    wire                    s_axi_wready;

   // AXI Slave Write Response

    wire [ID_WIDTH-1:0]     s_axi_bid;
    wire [1:0]              s_axi_bresp;
    wire [BUSER_WIDTH-1:0]  s_axi_buser;
    wire                    s_axi_bvalid;
    wire                    s_axi_bready;

   // AXI Slave Address Read

    wire [ID_WIDTH-1:0]     s_axi_arid;
    wire [ADDR_WIDTH-1:0]   s_axi_araddr;
    wire [7:0]              s_axi_arlen;
    wire [2:0]              s_axi_arsize;
    wire [1:0]              s_axi_arburst;
    wire                    s_axi_arlock;
    wire [3:0]              s_axi_arcache;
    wire [2:0]              s_axi_arprot;
    wire [3:0]              s_axi_arqos;
    wire [ARUSER_WIDTH-1:0] s_axi_aruser;
    wire                    s_axi_arvalid;
    wire                    s_axi_arready;

    // AXI Slave Read

    wire [ID_WIDTH-1:0]     s_axi_rid;
    wire [DATA_WIDTH-1:0]   s_axi_rdata;
    wire [1:0]              s_axi_rresp;
    wire                    s_axi_rlast;
    wire [RUSER_WIDTH-1:0]  s_axi_ruser;
    wire                    s_axi_rvalid;
    wire                    s_axi_rready;


    /*
        AXI Master connections 
    */

    // AXI Master Address Write

    wire [ID_WIDTH-1:0]     m_axi_awid;
    wire [ADDR_WIDTH-1:0]   m_axi_awaddr;
    wire [7:0]              m_axi_awlen;
    wire [2:0]              m_axi_awsize;
    wire [1:0]              m_axi_awburst;
    wire                    m_axi_awlock;
    wire [3:0]              m_axi_awcache;
    wire [2:0]              m_axi_awprot;
    wire [3:0]              m_axi_awqos;
    wire [3:0]              m_axi_awregion;
    wire [AWUSER_WIDTH-1:0] m_axi_awuser;
    wire                    m_axi_awvalid;
    wire                    m_axi_awready;

    // AXI Master Write

    wire [DATA_WIDTH-1:0]   m_axi_wdata;
    wire [STRB_WIDTH-1:0]   m_axi_wstrb;
    wire                    m_axi_wlast;
    wire [WUSER_WIDTH-1:0]  m_axi_wuser;
    wire                    m_axi_wvalid;
    wire                    m_axi_wready;

    // AXI Master Write Response

    wire [ID_WIDTH-1:0]     m_axi_bid;
    wire [1:0]              m_axi_bresp;
    wire [BUSER_WIDTH-1:0]  m_axi_buser;
    wire                    m_axi_bvalid;
    wire                    m_axi_bready;

    // AXI Master Address Read

    wire [ID_WIDTH-1:0]     m_axi_arid;
    wire [ADDR_WIDTH-1:0]   m_axi_araddr;
    wire [7:0]              m_axi_arlen;
    wire [2:0]              m_axi_arsize;
    wire [1:0]              m_axi_arburst;
    wire                    m_axi_arlock;
    wire [3:0]              m_axi_arcache;
    wire [2:0]              m_axi_arprot;
    wire [3:0]              m_axi_arqos;
    wire [3:0]              m_axi_arregion;
    wire [ARUSER_WIDTH-1:0] m_axi_aruser;
    wire                    m_axi_arvalid;
    wire                    m_axi_arready;

    // AXI Master Read

    wire [ID_WIDTH-1:0]     m_axi_rid;
    wire [DATA_WIDTH-1:0]   m_axi_rdata;
    wire [1:0]              m_axi_rresp;
    wire                    m_axi_rlast;
    wire [RUSER_WIDTH-1:0]  m_axi_ruser;
    wire                    m_axi_rvalid;
    wire                    m_axi_rready;

endinterface