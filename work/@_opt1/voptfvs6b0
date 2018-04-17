library verilog;
use verilog.vl_types.all;
entity DataMemory is
    generic(
        DATA_WIDTH      : integer := 8;
        MEMORY_DEPTH    : integer := 1024
    );
    port(
        WriteData       : in     vl_logic_vector;
        Address         : in     vl_logic_vector;
        MemWrite        : in     vl_logic;
        MemRead         : in     vl_logic;
        clk             : in     vl_logic;
        ReadData        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of MEMORY_DEPTH : constant is 1;
end DataMemory;
