vlog dut.sv top.sv +acc
vsim tb
add wave -r /*
run -all
