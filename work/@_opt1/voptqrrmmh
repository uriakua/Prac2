library verilog;
use verilog.vl_types.all;
entity RegisterFile is
    generic(
        N               : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        RegWrite        : in     vl_logic;
        WriteRegister   : in     vl_logic_vector(4 downto 0);
        ReadRegister1   : in     vl_logic_vector(4 downto 0);
        ReadRegister2   : in     vl_logic_vector(4 downto 0);
        WriteData       : in     vl_logic_vector(31 downto 0);
        ReadData1       : out    vl_logic_vector(31 downto 0);
        ReadData2       : out    vl_logic_vector(31 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end RegisterFile;
