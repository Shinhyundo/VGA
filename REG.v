/* Actice low reset Register */
module REG 
#(
    parameter W = 1
) 
(
    input               CLK,
    input               RST,
    input               EN,
    input       [W-1:0] D,
    output reg  [W-1:0] Q
);
    
    always @ (posedge CLK, negedge RST) begin
        if (!RST) 
            Q <= 1'b0;
        else if (EN)
            Q <= D;
    end
    
endmodule