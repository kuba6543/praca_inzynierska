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

    parameter CLK = 10;
    
    /*
        AXI clock and reset
    */

    reg clk;
    reg rst = 1;

    /*
        AXI Slave connections 
    */

    // AXI Slave Address Write

    wire s_axi_awid;
    wire s_axi_awaddr;
    wire s_axi_awlen;
    wire s_axi_awsize;
    wire s_axi_awburst;
    wire s_axi_awlock;
    wire s_axi_awcache;
    wire s_axi_awprot;
    wire s_axi_awqos;
    wire s_axi_awuser;
    wire s_axi_awvalid;
    wire s_axi_awready;

   // AXI Slave Write

    wire s_axi_wdata;
    wire s_axi_wstrb;
    wire s_axi_wlast;
    wire s_axi_wuser;
    wire s_axi_wvalid;
    wire s_axi_wready;

   // AXI Slave Write Response

    wire s_axi_bid;
    wire s_axi_bresp;
    wire s_axi_buser;
    wire s_axi_bvalid;
    wire s_axi_bready;

   // AXI Slave Address Read

    wire s_axi_arid;
    wire s_axi_araddr;
    wire s_axi_arlen;
    wire s_axi_arsize;
    wire s_axi_arburst;
    wire s_axi_arlock;
    wire s_axi_arcache;
    wire s_axi_arprot;
    wire s_axi_arqos;
    wire s_axi_aruser;
    wire s_axi_arvalid;
    wire s_axi_arready;

    // AXI Slave Read

    wire s_axi_rid;
    wire s_axi_rdata;
    wire s_axi_rresp;
    wire s_axi_rlast;
    wire s_axi_ruser;
    wire s_axi_rvalid;
    wire s_axi_rready;


    /*
        AXI Master connections 
    */

    // AXI Master Address Write

    wire m_axi_awid;
    wire m_axi_awaddr;
    wire m_axi_awlen;
    wire m_axi_awsize;
    wire m_axi_awburst;
    wire m_axi_awlock;
    wire m_axi_awcache;
    wire m_axi_awprot;
    wire m_axi_awqos;
    wire m_axi_awregion;
    wire m_axi_awuser;
    wire m_axi_awvalid;
    wire m_axi_awready;

    // AXI Master Write

    wire m_axi_wdata;
    wire m_axi_wstrb;
    wire m_axi_wlast;
    wire m_axi_wuser;
    wire m_axi_wvalid;
    wire m_axi_wready;

    // AXI Master Write Response

    wire m_axi_bid;
    wire m_axi_bresp;
    wire m_axi_buser;
    wire m_axi_bvalid;
    wire m_axi_bready;

    // AXI Master Address Read

    wire m_axi_arid;
    wire m_axi_araddr;
    wire m_axi_arlen;
    wire m_axi_arsize;
    wire m_axi_arburst;
    wire m_axi_arlock;
    wire m_axi_arcache;
    wire m_axi_arprot;
    wire m_axi_arqos;
    wire m_axi_arregion;
    wire m_axi_aruser;
    wire m_axi_arvalid;
    wire m_axi_arready;

    // AXI Master Read

    wire m_axi_rid;
    wire m_axi_rdata;
    wire m_axi_rresp;
    wire m_axi_rlast;
    wire m_axi_ruser;
    wire m_axi_rvalid;
    wire m_axi_rready;

axi_interconnect #(

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

always #(CLK/2) clk = ~clk;   // generate clock

initial begin
    clk = 0;
    rst = 1;
    #100 rst = 0;
end

endmodule
