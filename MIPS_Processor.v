/*
	 CODE BY CÉSAR VILLARREAL & GUILLERMO
	 COMPUTER ARCHITECTURE
	 SECOND PRACTICE: MIPS PROCESSOR
	 TUESDAY 17, APRIL 2018
*/

module MIPS_Processor
#(
	parameter MEMORY_DEPTH = 256
)
(
	input clk,						 //CLK
	input reset,					 //RESET
	input [7:0] PortIn,		    //PORT_IN
	output [31:0] ALUResultOut, //ALUResultOut
	output [4:0] ReadReg1,
	output [4:0] ReadReg2,
	output [4:0] WriteReg,
	output [31:0] PortOut		 //PortOut
);

assign  PortOut = 0;

//WIRE CONNECTIONS//////////////////
wire BranchNE_wire;
wire BranchEQ_wire;
wire RegDst_wire;
wire NotZeroANDBrachNE;
wire ZeroANDBrachEQ;
wire ORForBranch;
wire ALUSrc_wire;
wire RegWrite_wire;
wire Zero_wire;
wire MemtoReg_wire;
wire MemRead_wire;
wire MemWrite_wire;
wire PCsrc_wire;
wire [2:0]  ALUOp_wire;
wire [3:0]  ALUOperation_wire;
wire [4:0]  WriteRegister_wire;
wire [31:0] MUX_PC_wire;
wire [31:0] PC_wire;
wire [31:0] PC_4_wire;
wire [31:0] MUX_OFFSET_wire;
wire [31:0] Instruction_wire;
wire [31:0] ReadData1_wire;
wire [31:0] ReadData2_wire;
wire [31:0] InmmediateExtend_wire;
wire [31:0] ReadData2OrInmmediate_wire;
wire [31:0] ALUResult_wire;
wire [31:0] InmmediateExtendAnded_wire;
wire [31:0] PCtoBranch_wire;
wire [31:0] RAM_ReadData_wire;
wire [31:0] DataMemoryMux_wire;
wire [31:0] BranchAddress_wire;
wire [31:0] OffsetAdded_wire;
integer ALUStatus;

//PROGRAM-COUNTER//////////////////
 PC_Register
#(
	 .N(32)
 )
 programCounter
(
	 .clk(clk),
	 .reset(reset),
	 .NewPC(MUX_OFFSET_wire),
	 .PCValue(PC_wire)
);
///////////////////////////////////
//INSTRUCTION MEMORY///////////////
ProgramMemory
#(
	.MEMORY_DEPTH(MEMORY_DEPTH)   			 //DEFINE MEMORY SIZE
)
ROMProgramMemory
(
	.Address(PC_wire),					   	 //INSTRUCTION'S ADDRESS
	.Instruction(Instruction_wire)			 //INSTRUCTION OUTPUT
);
//////////////////////////////////
//CONTROL UNIT////////////////////
Control
ControlUnit
(
	.OP(Instruction_wire[31:26]), 			 //INSTRUCTION'S OPERATION CODE [31-26]
	.RegDst(RegDst_wire),					    //CHOOSE DESTINATION REGISTER: 0->RT, 1->RD
	.BranchNE(BranchNE_wire),     			 //BRANCH IF NOT EQUAL FLAG
	.BranchEQ(BranchEQ_wire),					 //BRANCH IF EQUAL FLAG
	.ALUOp(ALUOp_wire),							 //ALU OPERATION VALUE
	.ALUSrc(ALUSrc_wire),						 //ALU SRC
	.RegWrite(RegWrite_wire),					 //RegWrite Flag
	.MemRead(MemRead_wire),
	.MemWrite(MemWrite_wire)
);
//////////////////////////////////
//DATA SELECTORS//////////////////
Multiplexer2to1
#(
	.NBits(5)
)
MUX_ForRTypeAndIType
(
	.Selector(RegDst_wire),						//DATA SELECTOR INPUT
	.MUX_Data0(Instruction_wire[20:16]), 	//RT TYPE
	.MUX_Data1(Instruction_wire[15:11]),   //RD TYPE
	.MUX_Output(WriteRegister_wire)			//MuxOutput

);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_ForReadDataAndInmediate
(
	.Selector(ALUSrc_wire),						 //DATA SELECTOR INPUT
	.MUX_Data0(ReadData2_wire),				 //RT TYPE
	.MUX_Data1(InmmediateExtend_wire),		 //RD TYPE
	.MUX_Output(ReadData2OrInmmediate_wire) //MuxOutput
);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_MemtoReg
(
	.Selector(MemtoReg_wire),     			 //If MemtoReg active sends data read from memory to register
	.MUX_Data0(ALUResult_wire),   			 //Data from ALU
	.MUX_Data1(RAM_ReadData_wire), 			 //Data from memory
	.MUX_Output(DataMemoryMux_wire)

);

Multiplexer2to1
#(
	.NBits(32)
)
MUX_PC_OFFSET
(
	.Selector(PCsrc_wire),     			 //If MemtoReg active sends data read from memory to register
	.MUX_Data0(PC_4_wire),   			 //Data from ALU
	.MUX_Data1(OffsetAdded_wire), 			 //Data from memory
	.MUX_Output(MUX_OFFSET_wire)

);
//////////////////////////////////
//REGISTER FILE///////////////////
RegisterFile
Register_File
(
	.clk(clk),										  //CLK
	.reset(reset),									  //RESET
	.RegWrite(RegWrite_wire),				     //RegWrite (Control)
	.WriteRegister(WriteRegister_wire),		  //Register to be written
	.ReadRegister1(Instruction_wire[25:21]), //Register 1
	.ReadRegister2(Instruction_wire[20:16]), //Register 2
	.WriteData(DataMemoryMux_wire),			  //WriteData Flag
	.ReadData1(ReadData1_wire),				  //RegisterOutput 1
	.ReadData2(ReadData2_wire)					  //RegisterOutput 2

);
//////////////////////////////////
//SIGN EXTENSION/////////////////
SignExtend
SignExtendForConstants
(
  .DataInput(Instruction_wire[15:0]),		 //Inmmediate
  .SignExtendOutput(InmmediateExtend_wire) //Extended-Instruction
);
//////////////////////////////////

//ARITHMETIC LOGIC UNIT (ALU)////
ALUControl
ArithmeticLogicUnitControl
(
	.ALUOp(ALUOp_wire),
	.ALUFunction(Instruction_wire[5:0]),
	.ALUOperation(ALUOperation_wire)
);

ALU
ArithmeticLogicUnit
(
	.ALUOperation(ALUOperation_wire),
	.A(ReadData1_wire),
	.B(ReadData2OrInmmediate_wire),
	.Zero(Zero_wire),
	.ALUResult(ALUResult_wire)
);
//////////////////////////////////
//ADDERS//////////////////////////
Adder32bits
PC_Puls_4
(
	.Data0(PC_wire),
	.Data1(4),

	.Result(PC_4_wire)
);

Adder32bits
PC_OFFSET
(
	.Data0(PC_4_wire),
	.Data1(BranchAddress_wire), //SHIFT LEFT 2

	.Result(OffsetAdded_wire)
);
//////////////////////////////////
//DATA MEMORY/////////////////////
DataMemory
#(
	.DATA_WIDTH(32),
	.MEMORY_DEPTH(256)
)
RAM
(
	.clk(clk),
	.WriteData(ReadData2_wire),
	.Address(ALUResult_wire),
	.MemWrite(MemWrite_wire),
	.MemRead(MemRead_wire),
	.ReadData(RAM_ReadData_wire)
);
////////////////////////////////
//SHIFT-LEFT////////////////////*****
ShiftLeft2
BranchAddressShifter
(
	.DataInput(InmmediateExtend_wire),
   .DataOutput(BranchAddress_wire)
);

////////////////////////////////

assign ALUResultOut = ALUResult_wire;
assign ReadReg1 = Instruction_wire[25:21];
assign ReadReg2 = Instruction_wire[20:16];
assign WriteReg = WriteRegister_wire;

endmodule
