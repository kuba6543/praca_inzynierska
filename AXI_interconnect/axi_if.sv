interface axi_if(input logic clk, rst);

    `include "parameters.svh"

    // AXI Address Write

    reg [ID_WIDTH-1:0]     axi_awid;
    reg [ADDR_WIDTH-1:0]   axi_awaddr;
    reg [7:0]              axi_awlen;
    reg [2:0]              axi_awsize;
    reg [1:0]              axi_awburst;
    reg                    axi_awlock;
    reg [5:0]              axi_awcache;
    reg [2:0]              axi_awprot;
    reg [3:0]              axi_awqos;
    reg [3:0]              axi_awregion;
    reg [AWUSER_WIDTH-1:0] axi_awuser;
    reg                    axi_awvalid;
    reg                    axi_awready;

   // AXI Write

    reg [DATA_WIDTH-1:0]   axi_wdata;
    reg [STRB_WIDTH-1:0]   axi_wstrb;
    reg                    axi_wlast;
    reg [WUSER_WIDTH-1:0]  axi_wuser;
    reg                    axi_wvalid;
    reg                    axi_wready;

   // AXI Write Response

    reg [ID_WIDTH-1:0]     axi_bid;
    reg [1:0]              axi_bresp;
    reg [BUSER_WIDTH-1:0]  axi_buser;
    reg                    axi_bvalid;
    reg                    axi_bready;

   // AXI Address Read

    reg [ID_WIDTH-1:0]     axi_arid;
    reg [ADDR_WIDTH-1:0]   axi_araddr;
    reg [7:0]              axi_arlen;
    reg [2:0]              axi_arsize;
    reg [1:0]              axi_arburst;
    reg                    axi_arlock;
    reg [3:0]              axi_arcache;
    reg [2:0]              axi_arprot;
    reg [3:0]              axi_arqos;
    reg [3:0]              axi_arregion;
    reg [ARUSER_WIDTH-1:0] axi_aruser;
    reg                    axi_arvalid;
    reg                    axi_arready;

    // AXI Read

    reg [ID_WIDTH-1:0]     axi_rid;
    reg [DATA_WIDTH-1:0]   axi_rdata;
    reg [1:0]              axi_rresp;
    reg                    axi_rlast;
    reg [RUSER_WIDTH-1:0]  axi_ruser;
    reg                    axi_rvalid;
    reg                    axi_rready;

endinterface