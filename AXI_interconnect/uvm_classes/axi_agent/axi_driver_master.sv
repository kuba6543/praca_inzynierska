class axi_driver_master extends uvm_driver #(axi_transaction);

    `include "../../parameters.svh"

    virtual interface axi_if    vif;
    vif.cb_drv hook;
    logic [DATA_WIDTH-1:0]  rd_data;
    axi_transaction             m_wr_queue[$];
    axi_transaction             m_rd_queue[$];
    int unsigned                m_wr_addr_indx = 0;
    int unsigned                m_wr_data_indx = 0;
    int unsigned                m_rd_addr_indx = 0;
  
    `uvm_component_utils(axi_driver_master)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction:new

    //UVM connect_phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (!uvm_config_db#(virtual interface axi_if)::get(this, "", "vif", vif))
            `uvm_fatal("axi_master_driver","No virtual interface specified for this instance")
    endfunction : connect_phase

    // UVM run_phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        reset();
        forever begin
            seq_item_port.get_next_item(seq);
            case(seq.op_cmd)
         	    RESET:fork
    		        reset();
    	        join
    	        WRITE:fork 
    		        write_addr();write_data();received_resp_write();
    	        join
    	        READ: fork
    		        read_addr();read_data(rd_data);
    	        join
    	        default:`uvm_fatal("axi_driver","No valid command")
            endcase
            seq_item_port.item_done();
        end
    endtask : run_phase

    task reset();
        begin
            hook.AWID   <= 0;
            hook.AWADDR <= 0;
    	    hook.AWLEN  <= 0;
        end
    endtask:reset

    task write_addr();
        axi_transaction m_tr;
        forever begin
            // if write tr has existed...
            repeat(m_wr_queue.size()==0) @(posedge vif.clk);

            if (m_wr_addr_indx < m_wr_queue.size()) begin
                m_tr = m_wr_queue[m_wr_addr_indx];
                repeat(m_trx.addr_wt_delay) @(posedge vif.clk);
    
                // sent tr
                hook.AWVALID <= 1'b1;
                hook.AWID    <= m_tr.id;
                hook.AWADDR  <= m_tr.addr;
                hook.AWREG   <= m_tr.region;
                hook.AWLEN   <= m_tr.len;
                hook.AWSIZE  <= m_tr.size;
                hook.AWBURST <= m_tr.burst;
                hook.AWLOCK  <= m_tr.lock;
                hook.AWCACHE <= m_tr.cache;
                hook.AWPROT  <= m_tr.prot;
                hook.AWQOS   <= m_tr.qos;

                //wait AWREADY
                while (!hook.AWREADY) @(posedge vif.clk);
                hook.AWVALID <= 1'b0;
                m_wr_addr_indx += 1;
            end 
            else begin
                @(posedge vif.clk);
            end
        end
    endtask : write_addr

    task write_data();
        int unsigned  i = 0;
        axi_transaction  m_tr;
        forever begin
            repeat(m_wr_queue.size()==0) @(posedge vif.clk);
            if (m_wr_data_indx < m_wr_queue.size()) begin
                m_tr = m_wr_queue[m_wr_data_indx];
                repeat(m_tr.data_wt_delay) @(posedge vif.clk);

                // sent trx
                while (i<=m_tr.len) begin
                    hook.WVALID  <= 1'b1;
                    hook.WDATA   <= m_tr.data[i];
                    hook.WSTRB   <= m_tr.strb[i];
                    hook.WID     <= m_tr.id;
                    hook.WLAST   <= (i==m_tr.len)? 1'b1 : 1'b0;
                    @(posedge vif.clk);

                    if (vif.WREADY && vif.WVALID)
                        i = i+1;
                end
    
                // free tr
                hook.WVALID <= 1'b0;
                hook.WLAST  <= 1'b0;
                i = 0;
                @(posedge vif.clk);
                m_wr_data_indx += 1;
            end 
    	    else begin
                @(posedge vif.clk);
            end
        end
    endtask : write_data

    task received_resp_write();
        forever begin
            hook.BREADY <= 1'b0;
            repeat(2) @(posedge vif.clk);

            hook.BREADY <= 1'b1;
            @(posedge vif.clk);

            //wait BVALID received
            while(!vif.BVALID) @(posedge vif.clk);
        end
    endtask : received_resp_write

    task read_addr();
        axi_transaction m_tr;
        forever begin
            repeat(m_rd_queue.size()==0) @(posedge vif.clk);
            if (m_rd_addr_indx < m_rd_queue.size()) begin
                m_trx = m_rd_queue[m_rd_addr_indx];
                repeat(m_tr.addr_rd_delay) @(posedge vif.clk);

                // sent tr
                hook.ARVALID <= 1'b1;
                hook.ARID    <= m_tr.id;
                hook.ARADDR  <= m_tr.addr;
                hook.ARREADY <= m_tr.region;
                hook.ARLEN   <= m_tr.len;
                hook.ARSIZE  <= m_tr.size;
                hook.ARBURST <= m_tr.burst;
                hook.ARLOCK  <= m_tr.lock;
                hook.ARCACHE <= m_tr.cache;
                hook.ARPROT  <= m_tr.prot;
                hook.ARQOS   <= m_tr.qos;

                //wait ARREADY received
                while(!hook.ARREADY) @(posedge vif.clk);
                hook.ARVALID <= 1'b0;
                @(posedge vif.clk);
    	        m_rd_addr_indx += 1;
            end 
            else begin
                @(posedge vif.clk);
            end
        end
    endtask : read_addr

    task read_data(output logic /*[DATA_WIDTH-1:0] */ rd_data);
        @(posedge vif.clk) rd_data = (vif.RVALID && vif.RREADY)? vif.RDATA : 0;
        forever begin
            vif.RREADY <= 1'b0;
            repeat(2) @(posedge vif.clk);
            hook.RREADY <= 1'b1;

            //wait RVALID received
            while(!hook.RVALID) @(posedge vif.clk);   
            // continuous burst case
            while(!hook.RLAST) @(posedge vif.clk);
            hook.RREADY <= 1'b0;
        end
    endtask : read_data

endclass : axi_driver_master

