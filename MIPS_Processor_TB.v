/******************************************************************
* Description
*	This is the verifaction envioroment ofr testeting the basic MIPS
*	procesor.
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	12/06/2015
******************************************************************/

module MIPS_Processor_TB;
reg clk = 0;
reg reset = 0; 
reg [7:0] PortIn; 
wire [31:0] ALUResultOut;  
wire [31:0] PortOut;
wire [4:0]	ReadReg1;
wire [4:0]	ReadReg2;
wire [4:0]  WriteReg;
  
MIPS_Processor
DUV
(
	.clk(clk),
	.reset(reset),
	.ALUResultOut(ALUResultOut),
	.PortOut(PortOut),
	.ReadReg1(ReadReg1),
	.ReadReg2(ReadReg2),
	.WriteReg(WriteReg)
);
/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#5 reset = 1;
end
/*********************************************************/
initial begin // reset generator
	#4 PortIn = 3;
end

/*********************************************************/

endmodule