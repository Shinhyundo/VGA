/* Generate Sync signal */
module SYNC_GEN
#(
    parameter ACTIVE_VERTICAL = 1080    ,
    parameter ACTICE_HORIZONTAL = 1920  ,
    parameter COUNT_DEPTH = 12
)
(
    /* input port */
    input			            i_clk   ,
    input			            i_rst	,

    /* output port */
    output                      o_VSync ,
    output                      o_HSync ,
    output  [COUNT_DEPTH-1:0]   o_Vcnt  ,
    output  [COUNT_DEPTH-1:0]   o_Hcnt         
);  
    
    /* Vertical & Horizontral pixel counter */
    /* instance 2digit counter */
    TENSONES #(.W(COUNT_DEPTH))
    PIXEL_COUNTER
    (
        //input
        .i_clk(i_clk)                   ,
        .i_rst(i_rst)                   ,

        //output
        .o_TENS(o_Vcnt)                 ,
        .o_ONES(o_Hcnt)     
    );
    
    /* Assign output */
    assign o_VSync = (o_Vcnt < ACTIVE_VERTICAL) ? 1'b1 : 1'b0;
    assign o_HSync = (o_Hcnt < ACTICE_HORIZONTAL) ? 1'b1 : 1'b0;

endmodule