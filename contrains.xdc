# Clock signal
#set_property PACKAGE_PIN W5 [get_ports CLK100MHZ]							
#	set_property IOSTANDARD LVCMOS33 [get_ports CLK100MHZ]
#	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK100MHZ]

set_property PACKAGE_PIN W5 [get_ports clk]
	set_property IOSTANDARD LVCMOS33 [get_ports clk]

#Reset pulsador
set_property PACKAGE_PIN T18 [get_ports reset]						
	set_property IOSTANDARD LVCMOS33 [get_ports reset]

# LEDs with carry
set_property PACKAGE_PIN U16 [get_ports {r_data[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {r_data[0]}]
set_property PACKAGE_PIN E19 [get_ports {r_data[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {r_data[1]}]
set_property PACKAGE_PIN U19 [get_ports {r_data[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {r_data[2]}]
set_property PACKAGE_PIN V19 [get_ports {r_data[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {r_data[3]}]
set_property PACKAGE_PIN W18 [get_ports {r_data[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {r_data[4]}]
set_property PACKAGE_PIN U15 [get_ports {r_data[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {r_data[5]}]
set_property PACKAGE_PIN U14 [get_ports {r_data[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {r_data[6]}]
set_property PACKAGE_PIN V14 [get_ports {r_data[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {r_data[7]}]

#Led salida resultado	
set_property PACKAGE_PIN V13 [get_ports {tx_fifo_out[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {tx_fifo_out[0]}]
set_property PACKAGE_PIN V3 [get_ports {tx_fifo_out[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {tx_fifo_out[1]}]
set_property PACKAGE_PIN W3 [get_ports {tx_fifo_out[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {tx_fifo_out[2]}]
set_property PACKAGE_PIN U3 [get_ports {tx_fifo_out[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {tx_fifo_out[3]}]
set_property PACKAGE_PIN P3 [get_ports {tx_fifo_out[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {tx_fifo_out[4]}]
set_property PACKAGE_PIN N3 [get_ports {tx_fifo_out[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {tx_fifo_out[5]}]
set_property PACKAGE_PIN P1 [get_ports {tx_fifo_out[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {tx_fifo_out[6]}]
set_property PACKAGE_PIN L1 [get_ports {tx_fifo_out[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {tx_fifo_out[7]}]

##USB-RS232 Interface - rx
set_property PACKAGE_PIN B18 [get_ports rx]						
	set_property IOSTANDARD LVCMOS33 [get_ports rx]

#tx
set_property PACKAGE_PIN A18 [get_ports tx]						
	set_property IOSTANDARD LVCMOS33 [get_ports tx]

##Buttons (ENABLE)
#Dato A
set_property PACKAGE_PIN T17 [get_ports {rd_uart}]		 	
	set_property IOSTANDARD LVCMOS33 [get_ports {rd_uart}]
##Enviar resultado a pc
set_property PACKAGE_PIN W19 [get_ports {wr_uart}]		 	
	set_property IOSTANDARD LVCMOS33 [get_ports {wr_uart}]
#debug
set_property PACKAGE_PIN J1 [get_ports tx_full]					
	set_property IOSTANDARD LVCMOS33 [get_ports tx_full]
	
# Switches
#set_property PACKAGE_PIN V17 [get_ports {rd_uart}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {rd_uart}]