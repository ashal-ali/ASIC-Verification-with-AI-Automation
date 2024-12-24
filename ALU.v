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

module ALU_tb;
    reg [3:0] A, B;
    reg [2:0] ALU_Sel;
    wire [3:0] Result;
    wire CarryOut;

    ALU uut (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .Result(Result),
        .CarryOut(CarryOut)
    );

    initial begin
        //Test addition
        A = 4'b0101; B = 4'b0011; ALU_Sel = 3'b000; #15;
        $display("Addition: %b + %b = %b, CarryOut: %b", A, B, Result, CarryOut);

        // Test subtraction
        A = 4'b0110; B = 4'b0010; ALU_Sel = 3'b001; #15;
        $display("Subtraction: %b - %b = %b, CarryOut: %b", A, B, Result, CarryOut);

        // Test and
        A = 4'b1100; B = 4'b1010; ALU_Sel = 3'b010; #15;
        $display("AND: %b & %b = %b", A, B, Result);

        // Test or
        A = 4'b1100; B = 4'b1010; ALU_Sel = 3'b011; #15;
        $display("OR: %b | %b = %b", A, B, Result);

        // Test xor
        A = 4'b1100; B = 4'b1010; ALU_Sel = 3'b100; #15;
        $display("XOR: %b ^ %b = %b", A, B, Result);

        // Test left shift
        A = 4'b0111; ALU_Sel = 3'b101; #15;
        $display("Left Shift: %b << 1 = %b", A, Result);

        // Test right shift
        A = 4'b0111; ALU_Sel = 3'b110; #15;
        $display("Right Shift: %b >> 1 = %b", A, Result);

        // Default
        A = 4'b0000; B = 4'b0000; ALU_Sel = 3'b111; #15;
        $display("Default: ALU_Sel = %b, Result = %b", ALU_Sel, Result);
        $finish;
    end
endmodule
