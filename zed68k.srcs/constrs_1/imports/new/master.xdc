## This file is a general .xdc for the Arty A7-35 Rev. D
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

set_property INTERNAL_VREF 0.675 [get_iobanks 34]

# Config setup
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

## Clock signal
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports sys_clock]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports sys_clock]


## Switches


## RGB LEDs
#set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { led0_b }]; #IO_L18N_T2_35 Sch=led0_b
#set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { led0_g }]; #IO_L19N_T3_VREF_35 Sch=led0_g
#set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { led0_r }]; #IO_L19P_T3_35 Sch=led0_r
#set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { led1_b }]; #IO_L20P_T3_35 Sch=led1_b
#set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { led1_g }]; #IO_L21P_T3_DQS_35 Sch=led1_g
#set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { led1_r }]; #IO_L20N_T3_35 Sch=led1_r
#set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { led2_b }]; #IO_L21N_T3_DQS_35 Sch=led2_b
#set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { led2_g }]; #IO_L22N_T3_35 Sch=led2_g
#set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { led2_r }]; #IO_L22P_T3_35 Sch=led2_r
#set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { led3_b }]; #IO_L23P_T3_35 Sch=led3_b
#set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports { led3_g }]; #IO_L24P_T3_35 Sch=led3_g
#set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { led3_r }]; #IO_L23N_T3_35 Sch=led3_r

## LEDs
set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {led[3]}]

## Buttons
#set_property -dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports { btn[1] }]; #IO_L11P_T1_SRCC_16 Sch=btn[1]
#set_property -dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; #IO_L11N_T1_SRCC_16 Sch=btn[2]
#set_property -dict { PACKAGE_PIN B8    IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]; #IO_L12P_T1_MRCC_16 Sch=btn[3]

## Pmod Header JA
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports eth_cs]
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports eth_mosi]
set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports eth_miso]
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports eth_sclk]
set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS33} [get_ports eth_spisel]

set_property PULLUP true [get_ports eth_spisel]

#set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { ja[5] }]; #IO_L10P_T1_AD11P_15 Sch=ja[8]
#set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { ja[6] }]; #IO_L10N_T1_AD11N_15 Sch=ja[9]
#set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { ja[7] }]; #IO_25_15 Sch=ja[10]



#1 RTS / SS	UART Request to Send / SPI Slave Select
#2	RXD / MOSI	UART Receive Data / SPI Master Out Slave In
#3	TXD / MISO	UART Transmit Data / SPI Master In Slave Out
#4	CTS / SCK	UART Clear to Send / SPI Serial Clock
# Pmod Header JB
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports ps2_data]
#set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports txd3]
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports ps2_clock]
#set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports rts3]
set_property PULLUP true [get_ports ps2_data]
set_property PULLUP true [get_ports ps2_clock]


## USB-UART Interface
set_property -dict {PACKAGE_PIN D10 IOSTANDARD LVCMOS33} [get_ports uart_rxd_out]
set_property -dict {PACKAGE_PIN A9 IOSTANDARD LVCMOS33} [get_ports uart_txd_in]


# dazzler pins
#13 in SPI SCK
#12 out SPI MISO
#11 in SPI MOSI
#10 in DAZZLER SEL
#9 in SD SEL
#8 in GPU SEL
#2 out INTERRUPT
#1 in SERIAL IN

## ChipKit Outer Digital Header
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports op_sck]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports gd_uart_txd_out]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports op_a0]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports op_a1]
set_property -dict {PACKAGE_PIN R12 IOSTANDARD LVCMOS33} [get_ports op_a2]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports op_wr]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports op_ic]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports op_mosi]
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports gd_gpu_sel]
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports gd_sd_sel]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports gd_daz_sel]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports gd_mosi]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports gd_miso]
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports gd_sclk]


## ChipKit Inner Digital Header
#set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { ck_io26 }]; #IO_L19N_T3_A09_D25_VREF_14 	Sch=ck_io[26]
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { ck_io27 }]; #IO_L16N_T2_A15_D31_14 		Sch=ck_io[27]
#set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { ck_io28 }]; #IO_L6N_T0_D08_VREF_14 		Sch=ck_io[28]
#set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { ck_io29 }]; #IO_25_14 		 			Sch=ck_io[29]
#set_property -dict { PACKAGE_PIN R11   IOSTANDARD LVCMOS33 } [get_ports { ck_io30 }]; #IO_0_14  		 			Sch=ck_io[30]
#set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { ck_io31 }]; #IO_L5N_T0_D07_14 			Sch=ck_io[31]
#set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { ck_io32 }]; #IO_L13N_T2_MRCC_14 			Sch=ck_io[32]
#set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { ck_io33 }]; #IO_L13P_T2_MRCC_14 			Sch=ck_io[33]
#set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { ck_io34 }]; #IO_L15P_T2_DQS_RDWR_B_14 	Sch=ck_io[34]
#set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { ck_io35 }]; #IO_L11N_T1_SRCC_14 			Sch=ck_io[35]
#set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { ck_io36 }]; #IO_L8P_T1_D11_14 			Sch=ck_io[36]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { ck_io37 }]; #IO_L17P_T2_A14_D30_14 		Sch=ck_io[37]
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { ck_io38 }]; #IO_L7N_T1_D10_14 			Sch=ck_io[38]
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { ck_io39 }]; #IO_L7P_T1_D09_14 			Sch=ck_io[39]
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { ck_io40 }]; #IO_L9N_T1_DQS_D13_14 		Sch=ck_io[40]
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { ck_io41 }]; #IO_L9P_T1_DQS_14 			Sch=ck_io[41]

## ChipKit Outer Analog Header - as Single-Ended Analog Inputs
## NOTE: These ports can be used as single-ended analog inputs with voltages from 0-3.3V (ChipKit analog pins A0-A5) or as digital I/O.
## WARNING: Do not use both sets of constraints at the same time!
## NOTE: The following constraints should be used with the XADC IP core when using these ports as analog inputs.
#set_property -dict { PACKAGE_PIN C5    IOSTANDARD LVCMOS33 } [get_ports { vaux4_n  }]; #IO_L1N_T0_AD4N_35 		Sch=ck_an_n[0]	ChipKit pin=A0
#set_property -dict { PACKAGE_PIN C6    IOSTANDARD LVCMOS33 } [get_ports { vaux4_p  }]; #IO_L1P_T0_AD4P_35 		Sch=ck_an_p[0]	ChipKit pin=A0
#set_property -dict { PACKAGE_PIN A5    IOSTANDARD LVCMOS33 } [get_ports { vaux5_n  }]; #IO_L3N_T0_DQS_AD5N_35 	Sch=ck_an_n[1]	ChipKit pin=A1
#set_property -dict { PACKAGE_PIN A6    IOSTANDARD LVCMOS33 } [get_ports { vaux5_p  }]; #IO_L3P_T0_DQS_AD5P_35 	Sch=ck_an_p[1]	ChipKit pin=A1
#set_property -dict { PACKAGE_PIN B4    IOSTANDARD LVCMOS33 } [get_ports { vaux6_n  }]; #IO_L7N_T1_AD6N_35 		Sch=ck_an_n[2]	ChipKit pin=A2
#set_property -dict { PACKAGE_PIN C4    IOSTANDARD LVCMOS33 } [get_ports { vaux6_p  }]; #IO_L7P_T1_AD6P_35 		Sch=ck_an_p[2]	ChipKit pin=A2
#set_property -dict { PACKAGE_PIN A1    IOSTANDARD LVCMOS33 } [get_ports { vaux7_n  }]; #IO_L9N_T1_DQS_AD7N_35 	Sch=ck_an_n[3]	ChipKit pin=A3
#set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33 } [get_ports { vaux7_p  }]; #IO_L9P_T1_DQS_AD7P_35 	Sch=ck_an_p[3]	ChipKit pin=A3
#set_property -dict { PACKAGE_PIN B2    IOSTANDARD LVCMOS33 } [get_ports { vaux15_n }]; #IO_L10N_T1_AD15N_35 	Sch=ck_an_n[4]	ChipKit pin=A4
#set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33 } [get_ports { vaux15_p }]; #IO_L10P_T1_AD15P_35 	Sch=ck_an_p[4]	ChipKit pin=A4
#set_property -dict { PACKAGE_PIN C14   IOSTANDARD LVCMOS33 } [get_ports { vaux0_n  }]; #IO_L1N_T0_AD0N_15 		Sch=ck_an_n[5]	ChipKit pin=A5
#set_property -dict { PACKAGE_PIN D14   IOSTANDARD LVCMOS33 } [get_ports { vaux0_p  }]; #IO_L1P_T0_AD0P_15 		Sch=ck_an_p[5]	ChipKit pin=A5
## ChipKit Outer Analog Header - as Digital I/O
## NOTE: the following constraints should be used when using these ports as digital I/O.
#set_property -dict { PACKAGE_PIN F5    IOSTANDARD LVCMOS33 } [get_ports { ck_a0 }]; #IO_0_35           	Sch=ck_a[0]		ChipKit pin=A0
#set_property -dict { PACKAGE_PIN D8    IOSTANDARD LVCMOS33 } [get_ports { ck_a1 }]; #IO_L4P_T0_35      	Sch=ck_a[1]		ChipKit pin=A1
#set_property -dict { PACKAGE_PIN C7    IOSTANDARD LVCMOS33 } [get_ports { ck_a2 }]; #IO_L4N_T0_35      	Sch=ck_a[2]		ChipKit pin=A2
#set_property -dict { PACKAGE_PIN E7    IOSTANDARD LVCMOS33 } [get_ports { ck_a3 }]; #IO_L6P_T0_35      	Sch=ck_a[3]		ChipKit pin=A3
#set_property -dict { PACKAGE_PIN D7    IOSTANDARD LVCMOS33 } [get_ports { ck_a4 }]; #IO_L6N_T0_VREF_35 	Sch=ck_a[4]		ChipKit pin=A4
#set_property -dict { PACKAGE_PIN D5    IOSTANDARD LVCMOS33 } [get_ports { ck_a5 }]; #IO_L11P_T1_SRCC_35	Sch=ck_a[5]		ChipKit pin=A5

## ChipKit Inner Analog Header - as Differential Analog Inputs
## NOTE: These ports can be used as differential analog inputs with voltages from 0-1.0V (ChipKit Analog pins A6-A11) or as digital I/O.
## WARNING: Do not use both sets of constraints at the same time!
## NOTE: The following constraints should be used with the XADC core when using these ports as analog inputs.
#set_property -dict { PACKAGE_PIN B7    IOSTANDARD LVCMOS33 } [get_ports { vaux12_p }]; #IO_L2P_T0_AD12P_35	Sch=ad_p[12]	ChipKit pin=A6
#set_property -dict { PACKAGE_PIN B6    IOSTANDARD LVCMOS33 } [get_ports { vaux12_n }]; #IO_L2N_T0_AD12N_35	Sch=ad_n[12]	ChipKit pin=A7
#set_property -dict { PACKAGE_PIN E6    IOSTANDARD LVCMOS33 } [get_ports { vaux13_p }]; #IO_L5P_T0_AD13P_35	Sch=ad_p[13]	ChipKit pin=A8
#set_property -dict { PACKAGE_PIN E5    IOSTANDARD LVCMOS33 } [get_ports { vaux13_n }]; #IO_L5N_T0_AD13N_35	Sch=ad_n[13]	ChipKit pin=A9
#set_property -dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33 } [get_ports { vaux14_p }]; #IO_L8P_T1_AD14P_35	Sch=ad_p[14]	ChipKit pin=A10
#set_property -dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33 } [get_ports { vaux14_n }]; #IO_L8N_T1_AD14N_35	Sch=ad_n[14]	ChipKit pin=A11
## ChipKit Inner Analog Header - as Digital I/O
## NOTE: the following constraints should be used when using the inner analog header ports as digital I/O.
#set_property -dict { PACKAGE_PIN B7    IOSTANDARD LVCMOS33 } [get_ports { ck_io20 }]; #IO_L2P_T0_AD12P_35	Sch=ad_p[12]	ChipKit pin=A6
#set_property -dict { PACKAGE_PIN B6    IOSTANDARD LVCMOS33 } [get_ports { ck_io21 }]; #IO_L2N_T0_AD12N_35	Sch=ad_n[12]	ChipKit pin=A7
#set_property -dict { PACKAGE_PIN E6    IOSTANDARD LVCMOS33 } [get_ports { ck_io22 }]; #IO_L5P_T0_AD13P_35	Sch=ad_p[13]	ChipKit pin=A8
#set_property -dict { PACKAGE_PIN E5    IOSTANDARD LVCMOS33 } [get_ports { ck_io23 }]; #IO_L5N_T0_AD13N_35	Sch=ad_n[13]	ChipKit pin=A9
#set_property -dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33 } [get_ports { ck_io24 }]; #IO_L8P_T1_AD14P_35	Sch=ad_p[14]	ChipKit pin=A10
#set_property -dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33 } [get_ports { ck_io25 }]; #IO_L8N_T1_AD14N_35	Sch=ad_n[14]	ChipKit pin=A11

## ChipKit SPI
#set_property -dict { PACKAGE_PIN G1    IOSTANDARD LVCMOS33 } [get_ports { ck_miso }]; #IO_L17N_T2_35 Sch=ck_miso
#set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { ck_mosi }]; #IO_L17P_T2_35 Sch=ck_mosi
#set_property -dict { PACKAGE_PIN F1    IOSTANDARD LVCMOS33 } [get_ports { ck_sck }]; #IO_L18P_T2_35 Sch=ck_sck
#set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33 } [get_ports { ck_ss }]; #IO_L16N_T2_35 Sch=ck_ss

## ChipKit I2C
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports ck_scl]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports ck_sda]
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports scl_pup]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports sda_pup]

## Misc. ChipKit Ports
#set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { ck_ioa }]; #IO_L10N_T1_D15_14 Sch=ck_ioa
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports resetn]

## SMSC Ethernet PHY
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports eth_col]
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports eth_crs]
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports eth_mdc]
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports eth_mdio]
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports eth_ref_clk]
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports eth_rstn]
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports eth_rx_clk]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports eth_rx_dv]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[0]}]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[1]}]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[2]}]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {eth_rxd[3]}]
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports eth_rxerr]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports eth_tx_clk]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports eth_tx_en]
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports {eth_txd[0]}]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {eth_txd[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {eth_txd[2]}]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {eth_txd[3]}]

##Quad SPI Flash

set_property -dict {PACKAGE_PIN L13 IOSTANDARD LVCMOS33} [get_ports qspi_cs]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[0]}]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[1]}]
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[2]}]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {qspi_dq[3]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports qspi_sck]

## Power Measurements
#set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33     } [get_ports { vsnsvu_n }]; #IO_L7N_T1_AD2N_15 Sch=ad_n[2]
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33     } [get_ports { vsnsvu_p }]; #IO_L7P_T1_AD2P_15 Sch=ad_p[2]
#set_property -dict { PACKAGE_PIN B12   IOSTANDARD LVCMOS33     } [get_ports { vsns5v0_n }]; #IO_L3N_T0_DQS_AD1N_15 Sch=ad_n[1]
#set_property -dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS33     } [get_ports { vsns5v0_p }]; #IO_L3P_T0_DQS_AD1P_15 Sch=ad_p[1]
#set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33     } [get_ports { isns5v0_n }]; #IO_L5N_T0_AD9N_15 Sch=ad_n[9]
#set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33     } [get_ports { isns5v0_p }]; #IO_L5P_T0_AD9P_15 Sch=ad_p[9]
#set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33     } [get_ports { isns0v95_n }]; #IO_L8N_T1_AD10N_15 Sch=ad_n[10]
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33     } [get_ports { isns0v95_p }]; #IO_L8P_T1_AD10P_15 Sch=ad_p[10]

#set_property PACKAGE_PIN E3 [get_ports diff_clock_rtl_clk_p]
#set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports diff_clock_rtl_clk_n]
#set_property IOSTANDARD DIFF_HSTL_II_18 [get_ports diff_clock_rtl_clk_p]

# A list of memory associated pins, suitable for ingesting into Xilinx's
# Memory Interface Generator.

## Memory

# Memory address lines
set_property PACKAGE_PIN R2 [get_ports {ddr3_addr[0]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[0]}]
set_property PACKAGE_PIN M6 [get_ports {ddr3_addr[1]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[1]}]
set_property PACKAGE_PIN N4 [get_ports {ddr3_addr[2]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[2]}]
set_property PACKAGE_PIN T1 [get_ports {ddr3_addr[3]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[3]}]
set_property PACKAGE_PIN N6 [get_ports {ddr3_addr[4]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[4]}]
set_property PACKAGE_PIN R7 [get_ports {ddr3_addr[5]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[5]}]
set_property PACKAGE_PIN V6 [get_ports {ddr3_addr[6]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[6]}]
set_property PACKAGE_PIN U7 [get_ports {ddr3_addr[7]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[7]}]
set_property PACKAGE_PIN R8 [get_ports {ddr3_addr[8]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[8]}]
set_property PACKAGE_PIN V7 [get_ports {ddr3_addr[9]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[9]}]
set_property PACKAGE_PIN R6 [get_ports {ddr3_addr[10]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[10]}]
set_property PACKAGE_PIN U6 [get_ports {ddr3_addr[11]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[11]}]
set_property PACKAGE_PIN T6 [get_ports {ddr3_addr[12]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[12]}]
set_property PACKAGE_PIN T8 [get_ports {ddr3_addr[13]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_addr[13]}]
set_property PACKAGE_PIN R1 [get_ports {ddr3_ba[0]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_ba[0]}]
set_property PACKAGE_PIN P4 [get_ports {ddr3_ba[1]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_ba[1]}]
set_property PACKAGE_PIN P2 [get_ports {ddr3_ba[2]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_ba[2]}]
#
set_property PACKAGE_PIN M4 [get_ports ddr3_cas_n]
set_property IOSTANDARD SSTL135 [get_ports ddr3_cas_n]
# Clock lines
set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_ck_p[0]}]
set_property PACKAGE_PIN U9 [get_ports {ddr3_ck_p[0]}]
set_property PACKAGE_PIN V9 [get_ports {ddr3_ck_n[0]}]
set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_ck_n[0]}]
#
set_property PACKAGE_PIN N5 [get_ports {ddr3_cke[0]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_cke[0]}]
#
set_property PACKAGE_PIN L1 [get_ports {ddr3_dm[0]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dm[0]}]
set_property PACKAGE_PIN U1 [get_ports {ddr3_dm[1]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dm[1]}]
# Data (DQ) lines
set_property PACKAGE_PIN K5 [get_ports {ddr3_dq[0]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[0]}]
set_property PACKAGE_PIN L3 [get_ports {ddr3_dq[1]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[1]}]
set_property PACKAGE_PIN K3 [get_ports {ddr3_dq[2]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[2]}]
set_property PACKAGE_PIN L6 [get_ports {ddr3_dq[3]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[3]}]
set_property PACKAGE_PIN M3 [get_ports {ddr3_dq[4]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[4]}]
set_property PACKAGE_PIN M1 [get_ports {ddr3_dq[5]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[5]}]
set_property PACKAGE_PIN L4 [get_ports {ddr3_dq[6]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[6]}]
set_property PACKAGE_PIN M2 [get_ports {ddr3_dq[7]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[7]}]
set_property PACKAGE_PIN V4 [get_ports {ddr3_dq[8]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[8]}]
set_property PACKAGE_PIN T5 [get_ports {ddr3_dq[9]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[9]}]
set_property PACKAGE_PIN U4 [get_ports {ddr3_dq[10]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[10]}]
set_property PACKAGE_PIN V5 [get_ports {ddr3_dq[11]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[11]}]
set_property PACKAGE_PIN V1 [get_ports {ddr3_dq[12]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[12]}]
set_property PACKAGE_PIN T3 [get_ports {ddr3_dq[13]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[13]}]
set_property PACKAGE_PIN U3 [get_ports {ddr3_dq[14]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[14]}]
set_property PACKAGE_PIN R3 [get_ports {ddr3_dq[15]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_dq[15]}]
# DQS
set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_dqs_n[0]}]
set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_dqs_n[1]}]
set_property PACKAGE_PIN N2 [get_ports {ddr3_dqs_p[0]}]
set_property PACKAGE_PIN N1 [get_ports {ddr3_dqs_n[0]}]
set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_dqs_p[0]}]
set_property PACKAGE_PIN U2 [get_ports {ddr3_dqs_p[1]}]
set_property PACKAGE_PIN V2 [get_ports {ddr3_dqs_n[1]}]
set_property IOSTANDARD DIFF_SSTL135 [get_ports {ddr3_dqs_p[1]}]

set_property PACKAGE_PIN R5 [get_ports {ddr3_odt[0]}]
set_property IOSTANDARD SSTL135 [get_ports {ddr3_odt[0]}]
set_property PACKAGE_PIN P3 [get_ports ddr3_ras_n]
set_property IOSTANDARD SSTL135 [get_ports ddr3_ras_n]
set_property PACKAGE_PIN P5 [get_ports ddr3_we_n]
set_property IOSTANDARD SSTL135 [get_ports ddr3_we_n]
##Internal VREF
#set_property INTERNAL_VREF 0.675 [get_iobanks 34]

## Pmod Header JC
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports SD_CSn]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports SD_CMD]
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports SD_DAT0]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports SD_SCK]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports SD_DAT1]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports SD_DAT2]
set_property -dict {PACKAGE_PIN T13 IOSTANDARD LVCMOS33} [get_ports SD_CD]
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports SD_WP]

#set_property PULLUP TRUE [get_ports jc_pin1_io]
#set_property PULLUP true [get_ports jc_pin2_io]

##Pmod Header JD

## Pmod Header JD
#set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports SD_CSn]
#set_property -dict {PACKAGE_PIN D3 IOSTANDARD LVCMOS33} [get_ports SD_CMD]
#set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports SD_DAT0]
#set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports SD_SCK]
#set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports SD_DAT1]
#set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports SD_DAT2]
#set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports SD_CD]
#set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports SD_WP]

#         SD_RESET: inout std_logic; -- #IO_L14P_T2_SRCC_35 Sch=sd_reset
#         SD_CD : in std_logic;  --#IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
#         SD_SCK : out std_logic; --
#         SD_CMD : out std_logic; -- #IO_L16N_T2_35 Sch=sd_cmd
#         SD_DAT0 : in std_logic; -- #IO_L16P_T2_35 Sch=sd_dat[0]
#         SD_DAT1 : inout std_logic;-- #IO_L18N_T2_35 Sch=sd_dat[1]
#         SD_DAT2: inout std_logic;-- #IO_L18P_T2_35 Sch=sd_dat[2]
#         SD_DAT3 : inout std_logic;--
#         SD_WP : inout std_logic;--
#Pin 1 ~CS also dat3
#Pin 2 MOSI
#Pin 3 MISO
#Pin 4 SCK
#Pin 5 GND
#Pin 6 VCC
#Pin 7 DAT1
#Pin 8 DAT2
#Pin 9 CD
#Pin 10 WP
#Pin 11 GND
#Pin 12 VCC

set_property BITSTREAM.GENERAL.COMPRESS True [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

# Data (DQ) lines
# DQS

set_property PACKAGE_PIN K6 [get_ports ddr3_reset_n]
set_property IOSTANDARD SSTL135 [get_ports ddr3_reset_n]
#Internal VREF



connect_debug_port u_ila_0/probe4 [get_nets [list {computer/mykeyboard/comState__0[0]} {computer/mykeyboard/comState__0[1]} {computer/mykeyboard/comState__0[2]}]]
connect_debug_port u_ila_0/probe9 [get_nets [list computer/cpu1_n_70]]
connect_debug_port u_ila_0/probe10 [get_nets [list computer/cpu1_n_76]]
connect_debug_port u_ila_0/probe12 [get_nets [list computer/cpu1_n_86]]
connect_debug_port u_ila_0/probe13 [get_nets [list computer/currentBit_i_1_n_0]]
connect_debug_port u_ila_0/probe14 [get_nets [list computer/kbdrecv]]
connect_debug_port u_ila_0/probe15 [get_nets [list computer/kbdrecvreg]]
connect_debug_port u_ila_0/probe16 [get_nets [list computer/kbdrecvreg_i_1_n_0]]
connect_debug_port u_ila_0/probe17 [get_nets [list computer/kbdsendtrigger]]
connect_debug_port u_ila_0/probe18 [get_nets [list computer/kbdsendtrigger_i_1_n_0]]
connect_debug_port u_ila_0/probe19 [get_nets [list computer/mouserecv]]
connect_debug_port u_ila_0/probe20 [get_nets [list computer/mouserecvreg]]
connect_debug_port u_ila_0/probe21 [get_nets [list computer/mouserecvreg_i_1_n_0]]
connect_debug_port u_ila_0/probe22 [get_nets [list computer/mousesenddone]]
connect_debug_port u_ila_0/probe23 [get_nets [list computer/mousesendtrigger_i_1_n_0]]
connect_debug_port u_ila_0/probe24 [get_nets [list computer/mykeyboard/ena]]
connect_debug_port u_ila_0/probe25 [get_nets [list computer/mymouse/ena]]
connect_debug_port u_ila_0/probe26 [get_nets [list computer/parity_i_1_n_0]]
connect_debug_port u_ila_0/probe30 [get_nets [list computer/peripheral_n_7]]
connect_debug_port u_ila_0/probe31 [get_nets [list computer/peripheral_n_8]]
connect_debug_port u_ila_0/probe32 [get_nets [list computer/peripheral_n_14]]
connect_debug_port u_ila_0/probe33 [get_nets [list computer/peripheral_n_17]]
connect_debug_port u_ila_0/probe34 [get_nets [list computer/peripheral_n_19]]
connect_debug_port u_ila_0/probe35 [get_nets [list computer/peripheral_n_23]]
connect_debug_port u_ila_0/probe36 [get_nets [list computer/peripheral_n_24]]
connect_debug_port u_ila_0/probe37 [get_nets [list computer/peripheral_n_41]]
connect_debug_port u_ila_0/probe38 [get_nets [list computer/peripheral_n_42]]
connect_debug_port u_ila_0/probe39 [get_nets [list computer/peripheral_n_43]]
connect_debug_port u_ila_0/probe40 [get_nets [list computer/peripheral_n_44]]
connect_debug_port u_ila_0/probe41 [get_nets [list computer/peripheral_n_45]]
connect_debug_port u_ila_0/probe42 [get_nets [list computer/peripheral_n_46]]
connect_debug_port u_ila_0/probe43 [get_nets [list computer/peripheral_n_47]]
connect_debug_port u_ila_0/probe44 [get_nets [list computer/peripheral_n_48]]
connect_debug_port u_ila_0/probe45 [get_nets [list computer/peripheral_n_49]]
connect_debug_port u_ila_0/probe46 [get_nets [list computer/peripheral_n_50]]
connect_debug_port u_ila_0/probe47 [get_nets [list computer/peripheral_n_51]]
connect_debug_port u_ila_0/probe48 [get_nets [list computer/peripheral_n_52]]
connect_debug_port u_ila_0/probe49 [get_nets [list computer/peripheral_n_53]]
connect_debug_port u_ila_0/probe51 [get_nets [list computer/interrupts/ps2_int]]
connect_debug_port u_ila_0/probe52 [get_nets [list computer/ps2k_clk_out]]
connect_debug_port u_ila_0/probe53 [get_nets [list computer/ps2k_dat_in]]
connect_debug_port u_ila_0/probe54 [get_nets [list computer/ps2k_dat_out]]
connect_debug_port u_ila_0/probe55 [get_nets [list computer/recvTrigger_i_1__0_n_0]]
connect_debug_port u_ila_0/probe56 [get_nets [list {computer/reg_data_out_reg[0]}]]
connect_debug_port u_ila_0/probe57 [get_nets [list computer/reg_dtack_reg]]
connect_debug_port u_ila_0/probe59 [get_nets [list computer/sendDone_i_1__0_n_0]]
connect_debug_port u_ila_0/probe60 [get_nets [list computer/interrupts/timer_int]]
connect_debug_port u_ila_0/probe61 [get_nets [list computer/timer_set]]
connect_debug_port u_ila_0/probe62 [get_nets [list computer/timer_set_i_1_n_0]]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list sys_clock_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 2 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {computer/interrupts/int_out[0]} {computer/interrupts/int_out[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 24 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {cpuAddress[0]} {cpuAddress[1]} {cpuAddress[2]} {cpuAddress[3]} {cpuAddress[4]} {cpuAddress[5]} {cpuAddress[6]} {cpuAddress[7]} {cpuAddress[8]} {cpuAddress[9]} {cpuAddress[10]} {cpuAddress[11]} {cpuAddress[12]} {cpuAddress[13]} {cpuAddress[14]} {cpuAddress[15]} {cpuAddress[16]} {cpuAddress[17]} {cpuAddress[18]} {cpuAddress[19]} {cpuAddress[20]} {cpuAddress[21]} {cpuAddress[22]} {cpuAddress[23]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 16 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {cpuDataOut[0]} {cpuDataOut[1]} {cpuDataOut[2]} {cpuDataOut[3]} {cpuDataOut[4]} {cpuDataOut[5]} {cpuDataOut[6]} {cpuDataOut[7]} {cpuDataOut[8]} {cpuDataOut[9]} {cpuDataOut[10]} {cpuDataOut[11]} {cpuDataOut[12]} {cpuDataOut[13]} {cpuDataOut[14]} {cpuDataOut[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 16 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {cpuDataIn[0]} {cpuDataIn[1]} {cpuDataIn[2]} {cpuDataIn[3]} {cpuDataIn[4]} {cpuDataIn[5]} {cpuDataIn[6]} {cpuDataIn[7]} {cpuDataIn[8]} {cpuDataIn[9]} {cpuDataIn[10]} {cpuDataIn[11]} {cpuDataIn[12]} {cpuDataIn[13]} {cpuDataIn[14]} {cpuDataIn[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 7 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {computer/addr_out[16]} {computer/addr_out[17]} {computer/addr_out[18]} {computer/addr_out[20]} {computer/addr_out[21]} {computer/addr_out[22]} {computer/addr_out[23]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 12 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {computer/per_reg_addr[0]} {computer/per_reg_addr[1]} {computer/per_reg_addr[2]} {computer/per_reg_addr[3]} {computer/per_reg_addr[4]} {computer/per_reg_addr[5]} {computer/per_reg_addr[6]} {computer/per_reg_addr[7]} {computer/per_reg_addr[8]} {computer/per_reg_addr[9]} {computer/per_reg_addr[10]} {computer/per_reg_addr[11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 16 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {computer/per_reg_datain[0]} {computer/per_reg_datain[1]} {computer/per_reg_datain[2]} {computer/per_reg_datain[3]} {computer/per_reg_datain[4]} {computer/per_reg_datain[5]} {computer/per_reg_datain[6]} {computer/per_reg_datain[7]} {computer/per_reg_datain[8]} {computer/per_reg_datain[9]} {computer/per_reg_datain[10]} {computer/per_reg_datain[11]} {computer/per_reg_datain[12]} {computer/per_reg_datain[13]} {computer/per_reg_datain[14]} {computer/per_reg_datain[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 16 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {computer/per_reg_dataout[0]} {computer/per_reg_dataout[1]} {computer/per_reg_dataout[2]} {computer/per_reg_dataout[3]} {computer/per_reg_dataout[4]} {computer/per_reg_dataout[5]} {computer/per_reg_dataout[6]} {computer/per_reg_dataout[7]} {computer/per_reg_dataout[8]} {computer/per_reg_dataout[9]} {computer/per_reg_dataout[10]} {computer/per_reg_dataout[11]} {computer/per_reg_dataout[12]} {computer/per_reg_dataout[13]} {computer/per_reg_dataout[14]} {computer/per_reg_dataout[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list computer/cpu1_n_84]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list computer/per_ps2_int]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list computer/per_reg_rw]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list computer/per_timer_int]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list computer/ps2_clock_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list computer/rtc_ack]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets sys_clock_IBUF_BUFG]
