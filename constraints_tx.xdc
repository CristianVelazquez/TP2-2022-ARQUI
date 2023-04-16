# Clock signal
#set_property PACKAGE_PIN W5 [get_ports CLK100MHZ]							
#	set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]
#	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]

set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]

#Reset pulsador
set_property PACKAGE_PIN T18 [get_ports reset]						
	set_property IOSTANDARD LVCMOS33 [get_ports reset]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {data_in[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_in[0]}]
set_property PACKAGE_PIN E19 [get_ports {data_in[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_in[1]}]
set_property PACKAGE_PIN U19 [get_ports {data_in[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_in[2]}]
set_property PACKAGE_PIN V19 [get_ports {data_in[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_in[3]}]
set_property PACKAGE_PIN W18 [get_ports {data_in[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_in[4]}]
set_property PACKAGE_PIN U15 [get_ports {data_in[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_in[5]}]
set_property PACKAGE_PIN U14 [get_ports {data_in[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_in[6]}]
set_property PACKAGE_PIN V14 [get_ports {data_in[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data_in[7]}]

#Led salida resultado	
set_property PACKAGE_PIN V13 [get_ports {led_resultado[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_resultado[0]}]
set_property PACKAGE_PIN V3 [get_ports {led_resultado[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_resultado[1]}]
set_property PACKAGE_PIN W3 [get_ports {led_resultado[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_resultado[2]}]
set_property PACKAGE_PIN U3 [get_ports {led_resultado[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_resultado[3]}]
set_property PACKAGE_PIN P3 [get_ports {led_resultado[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_resultado[4]}]
set_property PACKAGE_PIN N3 [get_ports {led_resultado[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_resultado[5]}]
set_property PACKAGE_PIN P1 [get_ports {led_resultado[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_resultado[6]}]
set_property PACKAGE_PIN L1 [get_ports {led_resultado[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_resultado[7]}]

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
	
##Buttons (ENABLE)
#Dato A
set_property PACKAGE_PIN T17 [get_ports {rd_uart}]		 	
	set_property IOSTANDARD LVCMOS33 [get_ports {rd_uart}]
	
##USB-RS232 Interface - rx
set_property PACKAGE_PIN B18 [get_ports rx]						
	set_property IOSTANDARD LVCMOS33 [get_ports rx]
	

set_property PACKAGE_PIN V13 [get_ports {rx_empty}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rx_empty}]
	
