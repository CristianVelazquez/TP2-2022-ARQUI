# Clock signal
#set_property PACKAGE_PIN W5 [get_ports CLK100MHZ]							
#	set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]
#	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]

set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]

#Reset pulsador
set_property PACKAGE_PIN T18 [get_ports reset]						
	set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Switches
set_property PACKAGE_PIN V17 [get_ports {i_data[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {i_data[0]}]
set_property PACKAGE_PIN V16 [get_ports {i_data[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {i_data[1]}]
set_property PACKAGE_PIN W16 [get_ports {i_data[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {i_data[2]}]
set_property PACKAGE_PIN W17 [get_ports {i_data[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {i_data[3]}]
set_property PACKAGE_PIN W15 [get_ports {i_data[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {i_data[4]}]
set_property PACKAGE_PIN V15 [get_ports {i_data[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {i_data[5]}]
set_property PACKAGE_PIN W14 [get_ports {i_data[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {i_data[6]}]
set_property PACKAGE_PIN W13 [get_ports {i_data[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {i_data[7]}]
#set_property PACKAGE_PIN V2 [get_ports {i_data[8]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {i_data[8]}]
#set_property PACKAGE_PIN T3 [get_ports {i_data[9]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {i_data[9]}]
#set_property PACKAGE_PIN T2 [get_ports {i_data[10]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {i_data[10]}]
#set_property PACKAGE_PIN R3 [get_ports {i_data[11]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {i_data[11]}]
#set_property PACKAGE_PIN W2 [get_ports {i_data[12]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {i_data[12]}]
#set_property PACKAGE_PIN U1 [get_ports {i_data[13]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {i_data[13]}]
#set_property PACKAGE_PIN T1 [get_ports {i_data[14]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {i_data[14]}]
#set_property PACKAGE_PIN R2 [get_ports {i_data[15]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {i_data[15]}]

#debug
set_property PACKAGE_PIN J1 [get_ports tx_full]					
	set_property IOSTANDARD LVCMOS33 [get_ports tx_full]

#tx
set_property PACKAGE_PIN A18 [get_ports tx]						
	set_property IOSTANDARD LVCMOS33 [get_ports tx]


##Buttons (ENABLE)
#i_rx_done
set_property PACKAGE_PIN T17 [get_ports i_rx_done]		 	
	set_property IOSTANDARD LVCMOS33 [get_ports i_rx_done]