library verilog;
use verilog.vl_types.all;
entity PC_Register is
    generic(
        N               : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        NewPC           : in     vl_logic_vector;
        PCValue         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end PC_Register;
