/* 2digit Counter */
module TENSONES
#(
    parameter W = 12
)
(
    input           i_clk       ,
    input           i_rst       ,
    output  [W-1:0] o_TENS      ,
    output  [W-1:0] o_ONES
);

    localparam TOTAL_VERTICAL = 12'd1500;
    localparam TOTAL_HORIZONTAL = 12'd2400;

    reg     [W-1:0] r_TENS;
    reg     [W-1:0] r_ONES;

    wire            TENS_flag = (o_TENS == TOTAL_VERTICAL);
    wire            ONES_flag = (o_ONES == TOTAL_HORIZONTAL);

    /* instance register */ 
    REG #(.W(W)) REG_TNES
    (
        .CLK(i_clk)     ,
        .RST(i_rst)     ,
        .EN(1'b1)       ,
        .D(r_TENS)      ,
        .Q(o_TENS)
    );

    REG #(.W(W)) REG_ONES
    (
        .CLK(i_clk)     ,   
        .RST(i_rst)     ,
        .EN(1'b1)       ,
        .D(r_ONES)      ,
        .Q(o_ONES)
    );

    /* 2digit counter body */
    always @ (*) begin
        casex ({TENS_flag, ONES_flag})
            2'b00 : {r_TENS, r_ONES} = {o_TENS, o_ONES + 12'd1};
            2'b01 : {r_TENS, r_ONES} = {o_TENS + 12'd1, 12'd0};
            2'b10 : {r_TENS, r_ONES} = {o_TENS, o_ONES + 12'd1};
            2'b11 : {r_TENS, r_ONES} = {12'd0, 12'd0};
        endcase
    end

endmodule