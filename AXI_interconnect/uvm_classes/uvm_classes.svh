`include "axi_transaction.sv"
`include "axi_sequence.sv"
`include "axi_agent/axi_sequencer.sv"
`include "axi_agent/axi_driver.sv"
`include "axi_agent/axi_monitor.sv"
`include "axi_agent/axi_agent.sv"
`include "axi_scoreboard.sv"
`include "axi_predictor.sv"
`include "axi_coverage_collector.sv"
`include "axi_env.sv"
`include "axi_test.sv"
`include "../axi_if.sv"

typedef enum {
    W = 0,
    R  = 1} transaction_type_t;