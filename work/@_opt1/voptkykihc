library verilog;
use verilog.vl_types.all;
entity Adder32bits is
    generic(
        NBits           : integer := 32
    );
    port(
        Data0           : in     vl_logic_vector;
        Data1           : in     vl_logic_vector;
        Result          : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NBits : constant is 1;
end Adder32bits;
