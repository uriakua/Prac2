library verilog;
use verilog.vl_types.all;
entity Multiplexer2to1 is
    generic(
        NBits           : integer := 32
    );
    port(
        Selector        : in     vl_logic;
        MUX_Data0       : in     vl_logic_vector;
        MUX_Data1       : in     vl_logic_vector;
        MUX_Output      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NBits : constant is 1;
end Multiplexer2to1;
