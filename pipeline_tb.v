module pipeline_tb;

    reg clk = 0;
    reg rst;

    pipeline_processor uut (.clk(clk), .rst(rst));

    always #5 clk = ~clk;

    initial begin
        // Reset processor
        rst = 1; #10; rst = 0;

        // Initialize memory and registers
        uut.instr_mem[0] = 8'b000_001_010; // ADD R1 = R1 + R2
        uut.instr_mem[1] = 8'b010_011_100; // LOAD R3 = MEM[4]
        uut.instr_mem[2] = 8'b001_001_011; // SUB R1 = R1 - R3

        uut.reg_file[1] = 8'd10;
        uut.reg_file[2] = 8'd5;
        uut.data_mem[4] = 8'd20;

        // Run simulation
        #100;
        $display("R1 = %d", uut.reg_file[1]);
        $display("R3 = %d", uut.reg_file[3]);
        $stop;
    end

endmodule