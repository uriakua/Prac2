library verilog;
use verilog.vl_types.all;
entity \Register\ is
    generic(
        N               : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        DataInput       : in     vl_logic_vector;
        DataOutput      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end \Register\;
