class axi_driver_slave extends uvm_driver #(axi_transaction);
    //declaring AXI virtual interface
   virtual interface axi_if vif;
    int unsigned m_mem[int unsigned];

    // UVM automation macros for general components
    `uvm_component_utils(axi_driver_slave)

    // constructor of AXI slave driver
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(!uvm_config_db#(virtual interface axi_if)::get(this, "", "vif", vif))
            `uvm_fatal("axi_slave_driver",{"No virtual interface specified for this instance"});
    endfunction: connect_phase

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        this.reset();
        fork
            read_addr();
    	    read_data();
  	        write_addr();
   	        write_data();
   	        sent_resp_write();
        join
    endtask : run_phase
    
    virtual task reset();
        // addr write
       vif.s_axi_awready   <= 0;
        // data write
       vif.s_axi_wready    <= 0;
        // resp write
       vif.s_axi_bid       <= 0;
	   vif.s_axi_bresp     <= 0;
	   vif.s_axi_buser     <= 0;
	   vif.s_axi_bvalid    <= 0;
        // addr read
	   vif.s_axi_arready   <= 0;
        // data read
       vif.s_axi_rid       <= 0;
	   vif.s_axi_rdata     <= 0;
	   vif.s_axi_rresp     <= 0;        
	   vif.s_axi_rlast     <= 0;
	   vif.s_axi_ruser     <= 0;
	   vif.s_axi_rvalid    <= 0;
    endtask : reset

    task write_addr();
        begin
            vif.s_axi_awready <= 1'b0;
            @(posedge vif.clk);
            vif.s_axi_awready <= 1'b1;
            @(posedge vif.clk);
            // wait for AWVALID to be received
            while(!vif.s_axi_awvalid) @(posedge vif.clk);
        end
    endtask : write_addr
    
    task write_data();
        forever begin
            vif.s_axi_wready <= 1'b0;
            repeat(2) @(posedge vif.clk);
            vif.s_axi_wready <= 1'b1;
            @(posedge vif.clk);
            // wait for AWVALID to be received
            while(!vif.s_axi_wvalid) @(posedge vif.clk);
            // continuous hold cycle for burst case
            @(posedge vif.clk);
            vif.s_axi_wready <= 1'b1;
            repeat(2) @(posedge vif.clk);
        end
    endtask : write_data


    task sent_resp_write();
        forever begin
            repeat(m_wr_queue.size()==0) @(posedge vif.clk);
            // sent tr
            vif.s_axi_bvalid <= 1'b1;
            vif.s_axi_bid    <= tr.id;
            vif.s_axi_bresp  <= 3'b000;
            @(posedge vif.clk);
            // wait for BREADY to be received
            while(!vif.s_axi_bready) @(posedge vif.clk);
            vif.s_axi_bvalid <= 1'b0;
            @(posedge vif.clk);
        end
    endtask : sent_resp_write

    task read_addr();
        forever begin
            vif.s_axi_arready <= 1'b0;
            repeat(2) @(posedge vif.clk);
            vif.s_axi_arready <= 1'b1;
            @(posedge vif.clk);
            // wait ARVALID received
            while(!vif.s_axi_arvalid) @(posedge vif.clk);
        end
    endtask : read_addr

    task read_data();
        int unsigned i = 0;
        int m_rd_queue[];
        int tr;
        forever begin
            repeat(m_rd_queue.size()==0) @(posedge vif.clk);
            if (m_rd_queue.size()!=0) begin
                tr = m_rd_queue[0];
                i = 0;
                repeat(m_conf.data_rd_delay) @(posedge vif.clk);
                // sent tr
                while (i!=tr.length+1) begin
                    vif.s_axi_rvalid  <= 1'b1;
                    vif.s_axi_rdata   <= m_mem[tr.mem_addrs[i]];
                    vif.s_axi_rid     <= tr.id;
                    vif.s_axi_rresp   <= 3'b000;
                    vif.s_axi_rlast   <= (i==tr.length)? 1'b1 : 1'b0;
                    @(posedge vif.clk);
                    if (vif.s_axi_rready && vif.s_axi_rvalid) i = i+1;
                end
                vif.s_axi_rvalid <= 1'b0;
                vif.s_axi_rlast  <= 1'b0;
                @(posedge vif.clk);
            end
        end
    endtask : read_data

endclass : axi_driver_slave