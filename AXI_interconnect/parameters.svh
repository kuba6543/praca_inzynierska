parameter CLK               = 2;
parameter M_COUNT           = 1;
parameter S_COUNT           = 1;
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

typedef enum {
    Wr = 0,
    Re = 1} transaction_type_t;
    
typedef enum { 
    AW = 0,
    W = 1,
    B = 2,
    AR = 3,
    R = 4} transaction_type_e;