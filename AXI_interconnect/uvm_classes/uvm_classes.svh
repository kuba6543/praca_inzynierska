`include "axi_transaction.sv"
`include "axi_sequence.sv"
`include "axi_agent/axi_sequencer.sv"
`include "axi_agent/axi_driver.sv"
`include "axi_agent/axi_monitor.sv"
`include "axi_agent/axi_agent.sv"
`include "axi_scoreboard.sv"
`include "axi_env.sv"
`include "axi_test.sv"
`include "../axi_if.sv"

typedef enum {
    AW = 0,
    W  = 1,
    AR = 2,
    B  = 3,
    R  = 4} transaction_type_t;