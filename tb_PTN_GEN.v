`timescale  1ps/100fs
module tb_PTN_GEN;

    localparam SIM_TIME = 30000000;

    // input
    reg         i_clk;
    reg         i_rst;
    reg         i_PTN_type;

    // output
    wire        o_VSync;
    wire        o_DE;
    wire [7:0]  o_R_data;
    wire [7:0]  o_G_data;
    wire [7:0]  o_B_data;

    /* Clock generate */
    always #5 i_clk = ~i_clk;

    /* Pattern Generator instantiation */
    PTN_GEN PTN_GEN
    (
        .i_clk(i_clk)           , 
        .i_rst(i_rst)           , 
        .i_PTN_type(i_PTN_type) , 
        
        .o_R_data(o_R_data)     , 
        .o_G_data(o_G_data)     , 
        .o_B_data(o_B_data)     , 
        .o_VSync(o_VSync)       , 
        .o_DE(o_DE)
    );
   
    /* Set inital input value */
    initial begin
        i_clk = 1'b1;
        i_rst = 1'b0;
        i_PTN_type = 1'b1;
        #10
        i_rst = 1'b1;
    end

    /* Creat dump file */
    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb_PTN_GEN);
        #(SIM_TIME);
        $finish;
    end

endmodule