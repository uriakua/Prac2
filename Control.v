
module Control
(
	input [5:0]OP,	//OPCODE 
	output RegDst,
	output BranchEQ,
	output BranchNE,
	output MemRead,
	output MemtoReg,
	output MemWrite,
	output ALUSrc,
	output RegWrite,
	output Jump,
	output [1:0]ALUOp
);
localparam R_Type = 0;
localparam I_Type_ADDI = 6'h8;
localparam I_Type_ORI =  6'h0d;
localparam I_Type_LUI =  6'h0f;
localparam I_Type_BEQ =  6'h04;
localparam I_Type_BNE =  6'h05;
localparam I_Type_SW =   6'h2b;
localparam I_Type_LW =   6'h23;
localparam J_Type_Jump = 6'h02;
localparam J_Type_Jal =  6'h03;

reg [10:0] ControlValues;
//00 ADITION
//01 SUBSTRACITON
//10 FUNCT
always@(OP) begin
	casex(OP)
		R_Type:        ControlValues=  11'b1_001_00_00_0_10; 
		I_Type_ORI: 	ControlValues = 11'b0_101_00_00_0_01;
		I_Type_LUI: 	ControlValues = 11'b0_001_00_00_0_00;
		I_Type_BEQ: 	ControlValues = 11'b0_000_00_01_0_01;
		I_Type_BNE: 	ControlValues = 11'b0_100_00_10_0_01;	
		I_Type_ADDI: 	ControlValues = 11'b0_101_00_00_0_00;
		I_Type_SW: 		ControlValues = 11'b0_100_01_00_0_00;
		I_Type_LW: 		ControlValues = 11'b0_111_10_00_0_00;	
		I_Type_BEQ:    ControlValues = 11'b0_000_00_01_0_01;
		I_Type_BNE:		ControlValues = 11'b0_000_00_10_0_01;
		J_Type_Jump: 	ControlValues = 11'b0_000_00_00_1_00;
		J_Type_Jal: 	ControlValues = 11'b0_001_00_00_1_00;
		default:
		ControlValues= 10'b0000000000;
		endcase
end	
	
assign RegDst   = ControlValues[9];
assign ALUSrc   = ControlValues[8];
assign MemtoReg = ControlValues[7];
assign RegWrite = ControlValues[6];
assign MemRead  =  ControlValues[5];
assign MemWrite = ControlValues[4];
assign BranchNE = ControlValues[3];
assign BranchEQ = ControlValues[2];
assign ALUOp    = ControlValues[1:0];	

endmodule
