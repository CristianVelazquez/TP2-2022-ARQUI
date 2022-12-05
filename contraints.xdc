# Clock signal
set_property PACKAGE_PIN W5 [get_ports i_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_clk]

# Reset
set_property PACKAGE_PIN V17 [get_ports i_reset]
set_property IOSTANDARD LVCMOS33 [get_ports i_reset]

##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports i_rx]
    set_property IOSTANDARD LVCMOS33 [get_ports i_rx]
set_property PACKAGE_PIN A18 [get_ports o_tx]
    set_property IOSTANDARD LVCMOS33 [get_ports o_tx]
