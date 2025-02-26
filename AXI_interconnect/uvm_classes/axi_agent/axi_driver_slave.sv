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
       vif.AWREADY   <= 0;
        // data write
       vif.WREADY    <= 0;
        // resp write
       vif.BID       <= 0;
	   vif.BRESP     <= 0;
	   vif.BUSER     <= 0;
	   vif.BVALID    <= 0;
        // addr read
	   vif.ARREADY   <= 0;
        // data read
       vif.RID       <= 0;
	   vif.RDATA     <= 0;
	   vif.RRESP     <= 0;        
	   vif.RLAST     <= 0;
	   vif.RUSER     <= 0;
	   vif.RVALID    <= 0;
    endtask : reset

    task write_addr();
        begin
            vif.AWREADY <= 1'b0;
            @(posedge vif.clk);
            vif.AWREADY <= 1'b1;
            @(posedge vif.clk);
            // wait for AWVALID to be received
            while(!vif.AWVALID) @(posedge vif.clk);
        end
    endtask : write_addr
    
    task write_data();
        forever begin
            vif.WREADY <= 1'b0;
            repeat(2) @(posedge vif.clk);
            vif.WREADY <= 1'b1;
            @(posedge vif.clk);
            // wait for AWVALID to be received
            while(!vif.WVALID) @(posedge vif.clk);
            // continuous hold cycle for burst case
            @(posedge vif.clk);
            vif.WREADY <= 1'b1;
            repeat(2) @(posedge vif.clk);
        end
    endtask : write_data


    task sent_resp_write();
        forever begin
            repeat(m_wr_queue.size()==0) @(posedge vif.clk);
            // sent tr
            vif.BVALID <= 1'b1;
            vif.BID    <= tr.id;
            vif.BRESP  <= OKAY;
            @(posedge vif.clk);
            // wait for BREADY to be received
            while(!vif.BREADY) @(posedge vif.clk);
            vif.BVALID <= 1'b0;
            @(posedge vif.clk);
        end
    endtask : sent_resp_write

    task read_addr();
        forever begin
            vif.ARREADY <= 1'b0;
            repeat(2) @(posedge vif.clk);
            vif.ARREADY <= 1'b1;
            @(posedge vif.clk);
            // wait ARVALID received
            while(!vif.ARVALID) @(posedge vif.clk);
        end
    endtask : read_addr

    task read_data();
        int unsigned i = 0;
        forever begin
            repeat(m_rd_queue.size()==0) @(posedge vif.clk);
            if (m_rd_queue.size()!=0) begin
                tr = m_rd_queue[0];
                i = 0;
                repeat(m_conf.data_rd_delay) @(posedge vif.clk);
                // sent tr
                while (i!=tr.len+1) begin
                    vif.RVALID  <= 1'b1;
                    vif.RDATA   <= m_mem[tr.mem_addrs[i]];
                    vif.RID     <= tr.id;
                    vif.RRESP   <= OKAY;
                    vif.RLAST   <= (i==tr.len)? 1'b1 : 1'b0;
                    @(posedge vif.clk);
                    if (vif.RREADY && vif.RVALID) i = i+1;
                end
                vif.RVALID <= 1'b0;
                vif.RLAST  <= 1'b0;
                @(posedge vif.clk);
            end
        end
    endtask : read_data

endclass : axi_driver_slave