// ============================================================================
// Testbench - MIPS Pipeline (Mejorado)
// ============================================================================
`timescale 1ns / 1ps

module tb_MIPS_Pipeline;

    // Señales
    reg clk;
    reg reset;
    
    // Instanciar el procesador
    MIPS_Pipeline uut (
        .clk(clk),
        .reset(reset)
    );
    
    // Generador de reloj (periodo = 10ns)
    initial begin
        clk = 0;
    end
    
    always begin
        #50 clk = ~clk;
    end
    
    // Variables para monitoreo
    integer cycle_count;
    
    // Proceso principal
    initial begin
        // Inicializar
        cycle_count = 0;
        
        $display("============================================================");
        $display("        MIPS Pipeline - Simulacion Iniciada");
        $display("============================================================");
        
        // Reset inicial
        reset = 1;
        #25;
        reset = 0;
        
        $display("\nReset completado. Iniciando ejecución...\n");
        $display("Ciclo | PC       | Instruccion  | Estado");
        $display("------+----------+--------------+--------");
        
        // Ejecutar ciclos
        repeat(100) begin
            @(posedge clk);
            cycle_count = cycle_count + 1;
            
            // Mostrar información cada ciclo
            $display("%5d | %h | %h | OK", 
                     cycle_count, 
                     uut.PC_current, 
                     uut.Instruction_IF);
        end
        
        // Mostrar resultados finales
        $display("\n============================================================");
        $display("              RESULTADOS FINALES");
        $display("============================================================");
        $display("Ciclos ejecutados: %d", cycle_count);
        $display("PC final: %h", uut.PC_current);
        $display("============================================================");
        
        // Mostrar contenido de algunos registros del banco de registros
        $display("\nContenido del Banco de Registros:");
        $display("$0  = %h (siempre 0)", uut.regfile.registers[0]);
        $display("$8  = %h ($t0)", uut.regfile.registers[8]);
        $display("$9  = %h ($t1)", uut.regfile.registers[9]);
        $display("$10 = %h ($t2)", uut.regfile.registers[10]);
        $display("$11 = %h ($t3)", uut.regfile.registers[11]);
        $display("$12 = %h ($t4)", uut.regfile.registers[12]);
        $display("$13 = %h ($t5)", uut.regfile.registers[13]);
        $display("$14 = %h ($t6)", uut.regfile.registers[14]);
        
        $display("\nContenido de Memoria de Datos (primeras direcciones):");
        $display("Addr 0x14 = %h", uut.dmem.memory[5]);
        $display("Addr 0x18 = %h", uut.dmem.memory[6]);
        $display("Addr 0x1C = %h", uut.dmem.memory[7]);
        $display("Addr 0x20 = %h", uut.dmem.memory[8]);
        $display("Addr 0x24 = %h", uut.dmem.memory[9]);
        
        $display("\n============================================================");
        $display("              Simulacion Terminada");
        $display("============================================================");
        
        $finish;
    end

endmodule
