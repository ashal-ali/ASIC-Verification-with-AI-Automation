module ALU (
    input [3:0] A,
    input [3:0] B,
    input [2:0] ALU_Sel, // need to support 7 operations so 3-bit
    output reg [3:0] Result,
    output reg CarryOut 
    ); 
        always @(*) begin
        case (ALU_Sel)
            3'b000: {CarryOut, Result} = A + B;        // Addition
            3'b001: {CarryOut, Result} = A - B;        // Subtraction
            3'b010: Result = A & B;                    // AND
            3'b011: Result = A | B;                    // OR
            3'b100: Result = A ^ B;                    // XOR
            3'b101: Result = A << 1;                   // Left Shift
            3'b110: Result = A >> 1;                   // Right Shift
            3'b111: Result= ~A;                        // Not
            default: Result = 4'b0000;                 // Default: Zero output
        endcase
        // For non-addition/subtraction, CarryOut is set to 0
        if (ALU_Sel > 3'b001) CarryOut = 0;
    end
endmodule 
