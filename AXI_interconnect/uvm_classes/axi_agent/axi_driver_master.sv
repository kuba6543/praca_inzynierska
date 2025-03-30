class axi_driver_master extends uvm_driver #(axi_transaction);

    `include "../../parameters.svh"

    virtual interface axi_if vif;
    virtual interface axi_if hook;
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
            //seq_item_port.get_next_item(seq);
            //case(seq.op_cmd)
            seq_item_port.get_next_item(vif);
            case(axi_sequence)
//         	    RESET:fork
//    		        reset();
//    	        join
//    	        WRITE:fork 
                write(): fork
    		        write_addr();write_data();received_resp_write();
    	        join
//    	        READ: fork
                read(): fork
    		        read_addr();read_data(rd_data);
    	        join
    	        default:`uvm_fatal("axi_driver","No valid command")
            endcase
            seq_item_port.item_done();
        end
    endtask : run_phase

    task reset();
        begin
            hook.m_axi_awid   <= 0;
            hook.m_axi_awaddr <= 0;
    	    hook.m_axi_awlen  <= 0;
        end
    endtask:reset

    task write_addr();
        axi_transaction m_tr;
        axi_transaction m_trx;
        forever begin
            // if write tr has existed...
            repeat(m_wr_queue.size()==0) @(posedge vif.clk);

            if (m_wr_addr_indx < m_wr_queue.size()) begin
                m_trx = m_wr_queue[m_wr_addr_indx];
                repeat(m_trx.addr_wt_delay) @(posedge vif.clk);
    
                // sent tr
                hook.m_axi_awvalid <= 1'b1;
                hook.m_axi_awid    <= m_tr.m_axi_awid;
                hook.m_axi_awaddr  <= m_tr.m_axi_awaddr;
                hook.m_axi_awreg   <= m_tr.m_axi_awreg;
                hook.m_axi_awlen   <= m_tr.m_axi_awlen;
                hook.m_axi_awsize  <= m_tr.m_axi_awsize;
                hook.m_axi_awburst <= m_tr.m_axi_awburst;
                hook.m_axi_awlock  <= m_tr.m_axi_awlock;
                hook.m_axi_awcache <= m_tr.m_axi_awcache;
                hook.m_axi_awprot  <= m_tr.m_axi_awprot;
                hook.m_axi_awqos   <= m_tr.m_axi_awqos;

                //wait AWREADY
                while (!hook.m_axi_awready) @(posedge vif.clk);
                hook.m_axi_awvalid <= 1'b0;
                m_wr_addr_indx += 1;
            end 
            else begin
                @(posedge vif.clk);
            end
        end
    endtask : write_addr

    task write_data();
        int unsigned  i = 0;
        axi_transaction m_tr;
        axi_transaction m_trx;
        forever begin
            repeat(m_wr_queue.size()==0) @(posedge vif.clk);
            if (m_wr_data_indx < m_wr_queue.size()) begin
                m_trx = m_wr_queue[m_wr_data_indx];
                repeat(m_trx.data_wt_delay) @(posedge vif.clk);

                // sent trx
                while (i<=m_tr.length) begin
                    hook.m_axi_wvalid  <= 1'b1;
                    hook.m_axi_wdata   <= m_tr.data[i];
                    hook.m_axi_wstrb   <= m_tr.strb[i];
                    hook.m_axi_wid     <= m_tr.id;
                    hook.m_axi_wlast   <= (i==m_tr.length)? 1'b1 : 1'b0;
                    @(posedge vif.clk);

                    if (vif.m_axi_wready && vif.m_axi_wvalid)
                        i = i+1;
                end
    
                // free tr
                hook.m_axi_wvalid <= 1'b0;
                hook.m_axi_wlast  <= 1'b0;
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
            hook.m_axi_bready <= 1'b0;
            repeat(2) @(posedge vif.clk);

            hook.m_axi_bready <= 1'b1;
            @(posedge vif.clk);

            //wait BVALID received
            while(!vif.m_axi_bvalid) @(posedge vif.clk);
        end
    endtask : received_resp_write

    task read_addr();
        axi_transaction m_tr;
        axi_transaction m_trx;
        forever begin
            repeat(m_rd_queue.size()==0) @(posedge vif.clk);
            if (m_rd_addr_indx < m_rd_queue.size()) begin
                m_trx = m_rd_queue[m_rd_addr_indx];
                repeat(m_trx.addr_rd_delay) @(posedge vif.clk);

                // sent tr
                hook.m_axi_arvalid <= 1'b1;
                hook.m_axi_arid    <= m_tr.m_axi_arid;
                hook.m_axi_araddr  <= m_tr.m_axi_araddr;
                hook.m_axi_arready <= m_tr.m_axi_arready;
                hook.m_axi_arlen   <= m_tr.m_axi_arlen;
                hook.m_axi_arsize  <= m_tr.m_axi_arsize;
                hook.m_axi_arburst <= m_tr.m_axi_arburst;
                hook.m_axi_arlock  <= m_tr.m_axi_arlock;
                hook.m_axi_arcache <= m_tr.m_axi_arcache;
                hook.m_axi_arprot  <= m_tr.m_axi_arprot;
                hook.m_axi_arqos   <= m_tr.m_axi_arqos;

                //wait ARREADY received
                while(!hook.m_axi_arready) @(posedge vif.clk);
                hook.m_axi_arvalid <= 1'b0;
                @(posedge vif.clk);
    	        m_rd_addr_indx += 1;
            end 
            else begin
                @(posedge vif.clk);
            end
        end
    endtask : read_addr

    task read_data(output logic /*[DATA_WIDTH-1:0] */ rd_data);
        @(posedge vif.clk) rd_data = (vif.m_axi_rvalid && vif.m_axi_rready)? vif.m_axi_rdata : 0;
        forever begin
            vif.m_axi_rready <= 1'b0;
            repeat(2) @(posedge vif.clk);
            hook.m_axi_rready <= 1'b1;

            //wait RVALID received
            while(!hook.m_axi_rvalid) @(posedge vif.clk);   
            // continuous burst case
            while(!hook.m_axi_rlast) @(posedge vif.clk);
            hook.m_axi_rready <= 1'b0;
        end
    endtask : read_data

endclass : axi_driver_master

