library verilog;
use verilog.vl_types.all;
entity ANDGate is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : out    vl_logic
    );
end ANDGate;
