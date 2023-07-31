#!/bin/bash

topmodule="tb_PTN_GEN"
subModule="REG.v TENSONES.v SYNC_GEN.v PTN_GEN.v tb_PTN_GEN.v"

iverilog -s $topmodule -o test $subModule
vvp ./test