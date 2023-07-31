/* Pattern Generator (Video Generator) */
module PTN_GEN
#(  
    //1920x1080에서 대략 비율 맞춰서 blank 범위를 포함한 total display 크기를 설정했습니다.
    parameter ACTIVE_VERTICAL = 1080    ,
    parameter ACTICE_HORIZONTAL = 1920  ,
    parameter TOTAL_VERTICAL = 1500     ,
    parameter TOTAL_HORIZONTAL = 2400   ,
    parameter COUNT_DEPTH = 12          ,      
    parameter PIXEL_DATA = 8            ,
    parameter GRAY_LEVEL = 10
)
(
    /* input port */
    input			            i_clk       ,
    input			            i_rst	    ,
    input                       i_PTN_type  ,


    /* output port */
    output  [PIXEL_DATA-1:0]    o_R_data     ,
    output  [PIXEL_DATA-1:0]    o_G_data     ,
    output  [PIXEL_DATA-1:0]    o_B_data     ,
    output                      o_VSync      ,
    output                      o_DE     
);  

    reg     [PIXEL_DATA-1:0]   r_o_R_data;
    reg     [PIXEL_DATA-1:0]   r_o_G_data;
    reg     [PIXEL_DATA-1:0]   r_o_B_data;

    wire    [COUNT_DEPTH-1:0]  w_Vcnt;
    wire    [COUNT_DEPTH-1:0]  w_Hcnt;

    wire    [GRAY_LEVEL-1:0]   Gray_level;
    
    /* Sync signal generator */
    SYNC_GEN SYNC_GEN
    (   
        //input
        .i_clk(i_clk)               ,
        .i_rst(i_rst)               ,
        
        //output
        .o_VSync(o_VSync)           ,
        .o_HSync(o_DE)              ,
        .o_Vcnt(w_Vcnt)             ,
        .o_Hcnt(w_Hcnt)             
    );

    /* Set gray level value */ 
    assign Gray_level[0] = (w_Vcnt >= 12'd0) & (w_Vcnt < 12'd108);
    assign Gray_level[1] = (w_Vcnt >= 12'd108) & (w_Vcnt < 12'd216);
    assign Gray_level[2] = (w_Vcnt >= 12'd216) & (w_Vcnt < 12'd324);
    assign Gray_level[3] = (w_Vcnt >= 12'd324) & (w_Vcnt < 12'd432);
    assign Gray_level[4] = (w_Vcnt >= 12'd432) & (w_Vcnt < 12'd540);
    assign Gray_level[5] = (w_Vcnt >= 12'd540) & (w_Vcnt < 12'd648);
    assign Gray_level[6] = (w_Vcnt >= 12'd648) & (w_Vcnt < 12'd756);
    assign Gray_level[7] = (w_Vcnt >= 12'd756) & (w_Vcnt < 12'd864);
    assign Gray_level[8] = (w_Vcnt >= 12'd864) & (w_Vcnt < 12'd972);
    assign Gray_level[9] = (w_Vcnt >= 12'd972) & (w_Vcnt < 12'd1080);

    /* RGB data by Gray level */ 
    always @ (*) begin
        /* prevent to latch */
        r_o_R_data = 8'd0;
        r_o_G_data = 8'd0;
        r_o_B_data = 8'd0;
        /*
        if (w_Vcnt >= 12'd1080) begin
            r_o_R_data = 8'd0;
            r_o_G_data = 8'd0;
            r_o_B_data = 8'd0;
        end
        */
        casex(Gray_level)
            10'd1 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd255, 8'd255, 8'd255};
            10'd2 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd229, 8'd229, 8'd229};
            10'd4 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd203, 8'd203, 8'd203};
            10'd8 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd177, 8'd177, 8'd177};
            10'd16 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd151, 8'd151, 8'd151};
            10'd32 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd126, 8'd126, 8'd126};
            10'd64 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd100, 8'd100, 8'd100};
            10'd128 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd64, 8'd64, 8'd64};
            10'd256 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd58, 8'd58, 8'd58}; 
            10'd512 : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd26, 8'd26, 8'd26};
            default : {r_o_R_data, r_o_G_data, r_o_B_data} = {8'd0, 8'd0, 8'd0};
        endcase


    end

    /* Assign output */
    assign {o_R_data, o_G_data, o_B_data} = {r_o_R_data, r_o_G_data, r_o_B_data};

endmodule
