interface axi_if(input logic clk, reset);

    `include "parameters.svh"

    // AXI Address Write

    wire [ID_WIDTH-1:0]     axi_awid;
    wire [ADDR_WIDTH-1:0]   axi_awaddr;
    wire [7:0]              axi_awlen;
    wire [2:0]              axi_awsize;
    wire [1:0]              axi_awburst;
    wire                    axi_awlock;
    wire [5:0]              axi_awcache;
    wire [2:0]              axi_awprot;
    wire [3:0]              axi_awqos;
    wire [AWUSER_WIDTH-1:0] axi_awuser;
    wire                    axi_awvalid;
    wire                    axi_awready;

   // AXI Write

    wire [DATA_WIDTH-1:0]   axi_wdata;
    wire [STRB_WIDTH-1:0]   axi_wstrb;
    wire                    axi_wlast;
    wire [WUSER_WIDTH-1:0]  axi_wuser;
    wire                    axi_wvalid;
    wire                    axi_wready;

   // AXI Write Response

    wire [ID_WIDTH-1:0]     axi_bid;
    wire [1:0]              axi_bresp;
    wire [BUSER_WIDTH-1:0]  axi_buser;
    wire                    axi_bvalid;
    wire                    axi_bready;

   // AXI Address Read

    wire [ID_WIDTH-1:0]     axi_arid;
    wire [ADDR_WIDTH-1:0]   axi_araddr;
    wire [7:0]              axi_arlen;
    wire [2:0]              axi_arsize;
    wire [1:0]              axi_arburst;
    wire                    axi_arlock;
    wire [3:0]              axi_arcache;
    wire [2:0]              axi_arprot;
    wire [3:0]              axi_arqos;
    wire [ARUSER_WIDTH-1:0] axi_aruser;
    wire                    axi_arvalid;
    wire                    axi_arready;

    // AXI Read

    wire [ID_WIDTH-1:0]     axi_rid;
    wire [DATA_WIDTH-1:0]   axi_rdata;
    wire [1:0]              axi_rresp;
    wire                    axi_rlast;
    wire [RUSER_WIDTH-1:0]  axi_ruser;
    wire                    axi_rvalid;
    wire                    axi_rready;

endinterface