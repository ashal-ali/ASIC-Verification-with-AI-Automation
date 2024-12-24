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

        // Test NOT operation
        A = 4'b1010; ALU_Sel = 3'b111; #10;
        $display("NOT: ~%b = %b", A, Result);

        // Default
        A = 4'b0000; B = 4'b0000; ALU_Sel = 3'b111; #15;
        $display("Default: ALU_Sel = %b, Result = %b", ALU_Sel, Result);
        $finish;
    end
endmodule