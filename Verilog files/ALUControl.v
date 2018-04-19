module ALUControl
(
	input [1:0] ALUOp,
	input [5:0] ALUFunction,
	output [3:0] ALUOperation

);
//00 ADITION
//01 SUBSTRACITON
//10 FUNCT
localparam R_Type_AND  = 8'b10_100100;
localparam R_Type_OR   = 8'b10_100101;
localparam R_Type_NOR  = 8'b10_100111;
localparam R_Type_ADD  = 8'b10_100000;
localparam I_Type_ADDI = 8'b00_xxxxxx;
localparam I_Type_ORI  = 8'b01_xxxxxx;
localparam BEQ_AND_BNE = 8'b01_xxxxxx;

reg [3:0] ALUControlValues;
wire [8:0] Selector;

assign Selector = {ALUOp, ALUFunction};

always@(Selector)begin
	casex(Selector)
		R_Type_AND:    ALUControlValues = 4'b0000;
		R_Type_OR: 		ALUControlValues = 4'b0001;
		R_Type_NOR: 	ALUControlValues = 4'b0010;
	   R_Type_ADD: 	ALUControlValues = 4'b0011;
		I_Type_ADDI:	ALUControlValues = 4'b0011;
		I_Type_ORI: 	ALUControlValues = 4'b0001;
		BEQ_AND_BNE: 	ALUControlValues = 4'b0100;
		default: ALUControlValues = 4'b1001;
	endcase
end


assign ALUOperation = ALUControlValues;

endmodule