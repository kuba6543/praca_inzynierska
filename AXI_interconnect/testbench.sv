`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jakub Bartuszek
// 
// Create Date: 02.01.2025 16:50:42
// Design Name: axi_interconnect
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench();

    //`include "uvm/src/uvm.sv"
    `include "uvm_classes/axi_agent.sv"

    parameter CLK               = 10;

    parameter M_COUNT           = 4;
    parameter S_COUNT           = 4;
    parameter DATA_WIDTH        = 32;
    parameter ADDR_WIDTH        = 32;
    parameter STRB_WIDTH        = (DATA_WIDTH/8);
    parameter ID_WIDTH          = 8;
    parameter AWUSER_ENABLE     = 0;
    parameter AWUSER_WIDTH      = 1;
    parameter WUSER_ENABLE      = 0;
    parameter WUSER_WIDTH       = 1;
    parameter BUSER_ENABLE      = 0;
    parameter BUSER_WIDTH       = 1;
    parameter ARUSER_ENABLE     = 0;
    parameter ARUSER_WIDTH      = 1;
    parameter RUSER_ENABLE      = 0;
    parameter RUSER_WIDTH       = 1;
    parameter FORWARD_ID        = 0;
    parameter M_REGIONS         = 1;
    parameter M_BASE_ADDR       = 0;
    parameter M_ADDR_WIDTH      = {M_COUNT{{M_REGIONS{32'd24}}}};
    parameter M_CONNECT_READ    = {M_COUNT{{S_COUNT{1'b1}}}};
    parameter M_CONNECT_WRITE   = {M_COUNT{{S_COUNT{1'b1}}}};
    parameter M_SECURE          = {M_COUNT{1'b0}};
    
    /*
        AXI clock and reset
    */

    reg clk;
    reg rst = 1;

    /*
        AXI Slave connections 
    */

    // AXI Slave Address Write

    wire [S_COUNT*ID_WIDTH-1:0]     s_axi_awid;
    wire [S_COUNT*ADDR_WIDTH-1:0]   s_axi_awaddr;
    wire [S_COUNT*8-1:0]            s_axi_awlen;
    wire [S_COUNT*3-1:0]            s_axi_awsize;
    wire [S_COUNT*2-1:0]            s_axi_awburst;
    wire [S_COUNT-1:0]              s_axi_awlock;
    wire [S_COUNT*4-1:0]            s_axi_awcache;
    wire [S_COUNT*3-1:0]            s_axi_awprot;
    wire [S_COUNT*4-1:0]            s_axi_awqos;
    wire [S_COUNT*AWUSER_WIDTH-1:0] s_axi_awuser;
    wire [S_COUNT-1:0]              s_axi_awvalid;
    wire [S_COUNT-1:0]              s_axi_awready;

   // AXI Slave Write

    wire [S_COUNT*DATA_WIDTH-1:0]   s_axi_wdata;
    wire [S_COUNT*STRB_WIDTH-1:0]   s_axi_wstrb;
    wire [S_COUNT-1:0]              s_axi_wlast;
    wire [S_COUNT*WUSER_WIDTH-1:0]  s_axi_wuser;
    wire [S_COUNT-1:0]              s_axi_wvalid;
    wire [S_COUNT-1:0]              s_axi_wready;

   // AXI Slave Write Response

    wire [S_COUNT*ID_WIDTH-1:0]     s_axi_bid;
    wire [S_COUNT*2-1:0]            s_axi_bresp;
    wire [S_COUNT*BUSER_WIDTH-1:0]  s_axi_buser;
    wire [S_COUNT-1:0]              s_axi_bvalid;
    wire [S_COUNT-1:0]              s_axi_bready;

   // AXI Slave Address Read

    wire [S_COUNT*ID_WIDTH-1:0]     s_axi_arid;
    wire [S_COUNT*ADDR_WIDTH-1:0]   s_axi_araddr;
    wire [S_COUNT*8-1:0]            s_axi_arlen;
    wire [S_COUNT*3-1:0]            s_axi_arsize;
    wire [S_COUNT*2-1:0]            s_axi_arburst;
    wire [S_COUNT-1:0]              s_axi_arlock;
    wire [S_COUNT*4-1:0]            s_axi_arcache;
    wire [S_COUNT*3-1:0]            s_axi_arprot;
    wire [S_COUNT*4-1:0]            s_axi_arqos;
    wire [S_COUNT*ARUSER_WIDTH-1:0] s_axi_aruser;
    wire [S_COUNT-1:0]              s_axi_arvalid;
    wire [S_COUNT-1:0]              s_axi_arready;

    // AXI Slave Read

    wire [S_COUNT*ID_WIDTH-1:0]     s_axi_rid;
    wire [S_COUNT*DATA_WIDTH-1:0]   s_axi_rdata;
    wire [S_COUNT*2-1:0]            s_axi_rresp;
    wire [S_COUNT-1:0]              s_axi_rlast;
    wire [S_COUNT*RUSER_WIDTH-1:0]  s_axi_ruser;
    wire [S_COUNT-1:0]              s_axi_rvalid;
    wire [S_COUNT-1:0]              s_axi_rready;


    /*
        AXI Master connections 
    */

    // AXI Master Address Write

    wire [M_COUNT*ID_WIDTH-1:0]     m_axi_awid;
    wire [M_COUNT*ADDR_WIDTH-1:0]   m_axi_awaddr;
    wire [M_COUNT*8-1:0]            m_axi_awlen;
    wire [M_COUNT*3-1:0]            m_axi_awsize;
    wire [M_COUNT*2-1:0]            m_axi_awburst;
    wire [M_COUNT-1:0]              m_axi_awlock;
    wire [M_COUNT*4-1:0]            m_axi_awcache;
    wire [M_COUNT*3-1:0]            m_axi_awprot;
    wire [M_COUNT*4-1:0]            m_axi_awqos;
    wire [M_COUNT*4-1:0]            m_axi_awregion;
    wire [M_COUNT*AWUSER_WIDTH-1:0] m_axi_awuser;
    wire [M_COUNT-1:0]              m_axi_awvalid;
    wire [M_COUNT-1:0]              m_axi_awready;

    // AXI Master Write

    wire [M_COUNT*DATA_WIDTH-1:0]   m_axi_wdata;
    wire [M_COUNT*STRB_WIDTH-1:0]   m_axi_wstrb;
    wire [M_COUNT-1:0]              m_axi_wlast;
    wire [M_COUNT*WUSER_WIDTH-1:0]  m_axi_wuser;
    wire [M_COUNT-1:0]              m_axi_wvalid;
    wire [M_COUNT-1:0]              m_axi_wready;

    // AXI Master Write Response

    wire [M_COUNT*ID_WIDTH-1:0]     m_axi_bid;
    wire [M_COUNT*2-1:0]            m_axi_bresp;
    wire [M_COUNT*BUSER_WIDTH-1:0]  m_axi_buser;
    wire [M_COUNT-1:0]              m_axi_bvalid;
    wire [M_COUNT-1:0]              m_axi_bready;

    // AXI Master Address Read

    wire [M_COUNT*ID_WIDTH-1:0]     m_axi_arid;
    wire [M_COUNT*ADDR_WIDTH-1:0]   m_axi_araddr;
    wire [M_COUNT*8-1:0]            m_axi_arlen;
    wire [M_COUNT*3-1:0]            m_axi_arsize;
    wire [M_COUNT*2-1:0]            m_axi_arburst;
    wire [M_COUNT-1:0]              m_axi_arlock;
    wire [M_COUNT*4-1:0]            m_axi_arcache;
    wire [M_COUNT*3-1:0]            m_axi_arprot;
    wire [M_COUNT*4-1:0]            m_axi_arqos;
    wire [M_COUNT*4-1:0]            m_axi_arregion;
    wire [M_COUNT*ARUSER_WIDTH-1:0] m_axi_aruser;
    wire [M_COUNT-1:0]              m_axi_arvalid;
    wire [M_COUNT-1:0]              m_axi_arready;

    // AXI Master Read

    wire [M_COUNT*ID_WIDTH-1:0]     m_axi_rid;
    wire [M_COUNT*DATA_WIDTH-1:0]   m_axi_rdata;
    wire [M_COUNT*2-1:0]            m_axi_rresp;
    wire [M_COUNT-1:0]              m_axi_rlast;
    wire [M_COUNT*RUSER_WIDTH-1:0]  m_axi_ruser;
    wire [M_COUNT-1:0]              m_axi_rvalid;
    wire [M_COUNT-1:0]              m_axi_rready;

axi_interconnect #(

    .S_COUNT(S_COUNT),
    .M_COUNT(M_COUNT),
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .STRB_WIDTH(STRB_WIDTH),
    .ID_WIDTH(ID_WIDTH),
    .AWUSER_ENABLE(AWUSER_ENABLE),
    .AWUSER_WIDTH(AWUSER_WIDTH),
    .WUSER_ENABLE(WUSER_ENABLE),
    .WUSER_WIDTH(WUSER_WIDTH),
    .BUSER_ENABLE(BUSER_ENABLE),
    .BUSER_WIDTH(BUSER_WIDTH),
    .ARUSER_ENABLE(ARUSER_ENABLE),
    .ARUSER_WIDTH(ARUSER_WIDTH),
    .RUSER_ENABLE(RUSER_ENABLE),
    .RUSER_WIDTH(RUSER_WIDTH),
    .FORWARD_ID(FORWARD_ID),
    .M_REGIONS(M_REGIONS),
    .M_BASE_ADDR(M_BASE_ADDR),
    .M_ADDR_WIDTH(M_ADDR_WIDTH),
    .M_CONNECT_READ(M_CONNECT_READ),
    .M_CONNECT_WRITE(M_CONNECT_WRITE),
    .M_SECURE(M_SECURE)

) 
axi_interconnect_inst (
    .clk(clk),
    .rst(rst),
    .s_axi_awid(s_axi_awid),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awlen(s_axi_awlen),
    .s_axi_awsize(s_axi_awsize),
    .s_axi_awburst(s_axi_awburst),
    .s_axi_awlock(s_axi_awlock),
    .s_axi_awcache(s_axi_awcache),
    .s_axi_awprot(s_axi_awprot),
    .s_axi_awqos(s_axi_awqos),
    .s_axi_awuser(s_axi_awuser),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wlast(s_axi_wlast),
    .s_axi_wuser(s_axi_wuser),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    .s_axi_bid(s_axi_bid),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_buser(s_axi_buser),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    .s_axi_arid(s_axi_arid),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arlen(s_axi_arlen),
    .s_axi_arsize(s_axi_arsize),
    .s_axi_arburst(s_axi_arburst),
    .s_axi_arlock(s_axi_arlock),
    .s_axi_arcache(s_axi_arcache),
    .s_axi_arprot(s_axi_arprot),
    .s_axi_arqos(s_axi_arqos),
    .s_axi_aruser(s_axi_aruser),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rid(s_axi_rid),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rlast(s_axi_rlast),
    .s_axi_ruser(s_axi_ruser),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),

    .m_axi_awid(m_axi_awid),
    .m_axi_awaddr(m_axi_awaddr),
    .m_axi_awlen(m_axi_awlen),
    .m_axi_awsize(m_axi_awsize),
    .m_axi_awburst(m_axi_awburst),
    .m_axi_awlock(m_axi_awlock),
    .m_axi_awcache(m_axi_awcache),
    .m_axi_awprot(m_axi_awprot),
    .m_axi_awqos(m_axi_awqos),
    .m_axi_awregion(m_axi_awregion),
    .m_axi_awuser(m_axi_awuser),
    .m_axi_awvalid(m_axi_awvalid),
    .m_axi_awready(m_axi_awready),
    .m_axi_wdata(m_axi_wdata),
    .m_axi_wstrb(m_axi_wstrb),
    .m_axi_wlast(m_axi_wlast),
    .m_axi_wuser(m_axi_wuser),
    .m_axi_wvalid(m_axi_wvalid),
    .m_axi_wready(m_axi_wready),
    .m_axi_bid(m_axi_bid),
    .m_axi_bresp(m_axi_bresp),
    .m_axi_buser(m_axi_buser),
    .m_axi_bvalid(m_axi_bvalid),
    .m_axi_bready(m_axi_bready),
    .m_axi_arid(m_axi_arid),
    .m_axi_araddr(m_axi_araddr),
    .m_axi_arlen(m_axi_arlen),
    .m_axi_arsize(m_axi_arsize),
    .m_axi_arburst(m_axi_arburst),
    .m_axi_arlock(m_axi_arlock),
    .m_axi_arcache(m_axi_arcache),
    .m_axi_arprot(m_axi_arprot),
    .m_axi_arqos(m_axi_arqos),
    .m_axi_arregion(m_axi_arregion),
    .m_axi_aruser(m_axi_aruser),
    .m_axi_arvalid(m_axi_arvalid),
    .m_axi_arready(m_axi_arready),
    .m_axi_rid(m_axi_rid),
    .m_axi_rdata(m_axi_rdata),
    .m_axi_rresp(m_axi_rresp),
    .m_axi_rlast(m_axi_rlast),
    .m_axi_ruser(m_axi_ruser),
    .m_axi_rvalid(m_axi_rvalid),
    .m_axi_rready(m_axi_rready)
);

always #(CLK/2) clk = ~clk;   //generate clock

initial begin
    clk = 0;
    rst = 1;
    #100 rst = 0;
    
    axi_agent.new();
end

endmodule
