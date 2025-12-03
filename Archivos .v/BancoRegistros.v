// Banco de Registros (Register File) - MIPS Pipeline
// ============================================================================
// Características:
//   - 32 registros de 32 bits cada uno
//   - Registro $0 siempre es 0
//   - Dos puertos de lectura (asíncronos)
//   - Un puerto de escritura (síncrono)
// ============================================================================

module BancoRegistros (
    input         clk,           // Reloj del sistema
    input         reset,         // Reset asíncrono
    input         RegWrite,      // Habilitador de escritura
    input  [4:0]  ReadReg1,      // Dirección del registro a leer 1 (rs)
    input  [4:0]  ReadReg2,      // Dirección del registro a leer 2 (rt)
    input  [4:0]  WriteReg,      // Dirección del registro a escribir
    input  [31:0] WriteData,     // Dato a escribir
    output [31:0] ReadData1,     // Dato leído del registro 1
    output [31:0] ReadData2      // Dato leído del registro 2
);

    // Arreglo de 32 registros de 32 bits
    reg [31:0] registers [0:31];
    
    integer i;

    // Inicialización
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end

    // LECTURA - Combinacional (asíncrona)
    // El registro $0 siempre retorna 0
    assign ReadData1 = (ReadReg1 == 5'b0) ? 32'b0 : registers[ReadReg1];
    assign ReadData2 = (ReadReg2 == 5'b0) ? 32'b0 : registers[ReadReg2];
    
    // ESCRITURA - Síncrona (flanco positivo)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                registers[i] <= 32'b0;
            end
        end
        else if (RegWrite && (WriteReg != 5'b0)) begin
            // No permitir escritura en $0
            registers[WriteReg] <= WriteData;
        end
    end

endmodule
