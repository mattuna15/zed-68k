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
#set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports ps2_data]
#set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { ja[1] }]; #IO_L4P_T0_15 Sch=ja[2]
#set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports ps2_clock]
#set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { ja[3] }]; #IO_L6P_T0_15 Sch=ja[4]

set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports fram_sck1]
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports fram_miso1]
set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports fram_mosi1]
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports fram_cs1]

set_property -dict {PACKAGE_PIN D13 IOSTANDARD LVCMOS33} [get_ports fram_sck2]
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports fram_miso2]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports fram_mosi2]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports fram_cs2]

## Pmod Header JB
#Pin 1 RTS / SS
#Pin 2 RXD / MOSI
#Pin 3 TXD / MISO
#Pin 4 CTS / SCK
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports esp_cts]
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports esp_txd]
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports esp_rxd]
set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports esp_rts]
set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { jb[4] }]; #IO_L23P_T3_FOE_B_15 Sch=jb_p[3]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { jb[5] }]; #IO_L23N_T3_FWE_B_15 Sch=jb_n[3]
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { jb[6] }]; #IO_L24P_T3_RS1_15 Sch=jb_p[4]
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { jb[7] }]; #IO_L24N_T3_RS0_15 Sch=jb_n[4]


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
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports ps2_data]
#set_property -dict {PACKAGE_PIN D3 IOSTANDARD LVCMOS33} [get_ports SD_CMD]
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports ps2_clock]
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

connect_debug_port u_ila_0/probe0 [get_nets [list {fram1/data_i[0]} {fram1/data_i[1]} {fram1/data_i[2]} {fram1/data_i[3]} {fram1/data_i[4]} {fram1/data_i[5]} {fram1/data_i[6]} {fram1/data_i[7]}]]







connect_debug_port u_ila_0/probe3 [get_nets [list computer/fpu1/in_progress_reg_0]]
connect_debug_port u_ila_0/probe4 [get_nets [list computer/fpu1/valid_1]]


connect_debug_port u_ila_0/probe1 [get_nets [list {computer/fpu1/fpu_op[0]} {computer/fpu1/fpu_op[1]} {computer/fpu1/fpu_op[2]}]]
connect_debug_port u_ila_0/probe2 [get_nets [list computer/fpu1/ack]]
connect_debug_port u_ila_0/probe3 [get_nets [list computer/fpu1/enable]]
connect_debug_port u_ila_0/probe4 [get_nets [list computer/fpu1/valid]]



connect_debug_port u_ila_0/probe4 [get_nets [list computer/ack]]











create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 2 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list pll2/inst/eth_clk]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 3 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {ethernet_FSM/eth_state[0]} {ethernet_FSM/eth_state[1]} {ethernet_FSM/eth_state[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {ethernet_FSM/axis_tx_data[0]} {ethernet_FSM/axis_tx_data[1]} {ethernet_FSM/axis_tx_data[2]} {ethernet_FSM/axis_tx_data[3]} {ethernet_FSM/axis_tx_data[4]} {ethernet_FSM/axis_tx_data[5]} {ethernet_FSM/axis_tx_data[6]} {ethernet_FSM/axis_tx_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {ethernet_FSM/axis_rx_data[0]} {ethernet_FSM/axis_rx_data[1]} {ethernet_FSM/axis_rx_data[2]} {ethernet_FSM/axis_rx_data[3]} {ethernet_FSM/axis_rx_data[4]} {ethernet_FSM/axis_rx_data[5]} {ethernet_FSM/axis_rx_data[6]} {ethernet_FSM/axis_rx_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 64 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {computer/fpu1/opb_reg[0]} {computer/fpu1/opb_reg[1]} {computer/fpu1/opb_reg[2]} {computer/fpu1/opb_reg[3]} {computer/fpu1/opb_reg[4]} {computer/fpu1/opb_reg[5]} {computer/fpu1/opb_reg[6]} {computer/fpu1/opb_reg[7]} {computer/fpu1/opb_reg[8]} {computer/fpu1/opb_reg[9]} {computer/fpu1/opb_reg[10]} {computer/fpu1/opb_reg[11]} {computer/fpu1/opb_reg[12]} {computer/fpu1/opb_reg[13]} {computer/fpu1/opb_reg[14]} {computer/fpu1/opb_reg[15]} {computer/fpu1/opb_reg[16]} {computer/fpu1/opb_reg[17]} {computer/fpu1/opb_reg[18]} {computer/fpu1/opb_reg[19]} {computer/fpu1/opb_reg[20]} {computer/fpu1/opb_reg[21]} {computer/fpu1/opb_reg[22]} {computer/fpu1/opb_reg[23]} {computer/fpu1/opb_reg[24]} {computer/fpu1/opb_reg[25]} {computer/fpu1/opb_reg[26]} {computer/fpu1/opb_reg[27]} {computer/fpu1/opb_reg[28]} {computer/fpu1/opb_reg[29]} {computer/fpu1/opb_reg[30]} {computer/fpu1/opb_reg[31]} {computer/fpu1/opb_reg[32]} {computer/fpu1/opb_reg[33]} {computer/fpu1/opb_reg[34]} {computer/fpu1/opb_reg[35]} {computer/fpu1/opb_reg[36]} {computer/fpu1/opb_reg[37]} {computer/fpu1/opb_reg[38]} {computer/fpu1/opb_reg[39]} {computer/fpu1/opb_reg[40]} {computer/fpu1/opb_reg[41]} {computer/fpu1/opb_reg[42]} {computer/fpu1/opb_reg[43]} {computer/fpu1/opb_reg[44]} {computer/fpu1/opb_reg[45]} {computer/fpu1/opb_reg[46]} {computer/fpu1/opb_reg[47]} {computer/fpu1/opb_reg[48]} {computer/fpu1/opb_reg[49]} {computer/fpu1/opb_reg[50]} {computer/fpu1/opb_reg[51]} {computer/fpu1/opb_reg[52]} {computer/fpu1/opb_reg[53]} {computer/fpu1/opb_reg[54]} {computer/fpu1/opb_reg[55]} {computer/fpu1/opb_reg[56]} {computer/fpu1/opb_reg[57]} {computer/fpu1/opb_reg[58]} {computer/fpu1/opb_reg[59]} {computer/fpu1/opb_reg[60]} {computer/fpu1/opb_reg[61]} {computer/fpu1/opb_reg[62]} {computer/fpu1/opb_reg[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 64 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {computer/fpu1/opa_reg[0]} {computer/fpu1/opa_reg[1]} {computer/fpu1/opa_reg[2]} {computer/fpu1/opa_reg[3]} {computer/fpu1/opa_reg[4]} {computer/fpu1/opa_reg[5]} {computer/fpu1/opa_reg[6]} {computer/fpu1/opa_reg[7]} {computer/fpu1/opa_reg[8]} {computer/fpu1/opa_reg[9]} {computer/fpu1/opa_reg[10]} {computer/fpu1/opa_reg[11]} {computer/fpu1/opa_reg[12]} {computer/fpu1/opa_reg[13]} {computer/fpu1/opa_reg[14]} {computer/fpu1/opa_reg[15]} {computer/fpu1/opa_reg[16]} {computer/fpu1/opa_reg[17]} {computer/fpu1/opa_reg[18]} {computer/fpu1/opa_reg[19]} {computer/fpu1/opa_reg[20]} {computer/fpu1/opa_reg[21]} {computer/fpu1/opa_reg[22]} {computer/fpu1/opa_reg[23]} {computer/fpu1/opa_reg[24]} {computer/fpu1/opa_reg[25]} {computer/fpu1/opa_reg[26]} {computer/fpu1/opa_reg[27]} {computer/fpu1/opa_reg[28]} {computer/fpu1/opa_reg[29]} {computer/fpu1/opa_reg[30]} {computer/fpu1/opa_reg[31]} {computer/fpu1/opa_reg[32]} {computer/fpu1/opa_reg[33]} {computer/fpu1/opa_reg[34]} {computer/fpu1/opa_reg[35]} {computer/fpu1/opa_reg[36]} {computer/fpu1/opa_reg[37]} {computer/fpu1/opa_reg[38]} {computer/fpu1/opa_reg[39]} {computer/fpu1/opa_reg[40]} {computer/fpu1/opa_reg[41]} {computer/fpu1/opa_reg[42]} {computer/fpu1/opa_reg[43]} {computer/fpu1/opa_reg[44]} {computer/fpu1/opa_reg[45]} {computer/fpu1/opa_reg[46]} {computer/fpu1/opa_reg[47]} {computer/fpu1/opa_reg[48]} {computer/fpu1/opa_reg[49]} {computer/fpu1/opa_reg[50]} {computer/fpu1/opa_reg[51]} {computer/fpu1/opa_reg[52]} {computer/fpu1/opa_reg[53]} {computer/fpu1/opa_reg[54]} {computer/fpu1/opa_reg[55]} {computer/fpu1/opa_reg[56]} {computer/fpu1/opa_reg[57]} {computer/fpu1/opa_reg[58]} {computer/fpu1/opa_reg[59]} {computer/fpu1/opa_reg[60]} {computer/fpu1/opa_reg[61]} {computer/fpu1/opa_reg[62]} {computer/fpu1/opa_reg[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 4 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {computer/fpu1/Q[0]} {computer/fpu1/Q[1]} {computer/fpu1/Q[2]} {computer/fpu1/Q[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 27 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {cpuAddress[0]} {cpuAddress[1]} {cpuAddress[2]} {cpuAddress[3]} {cpuAddress[4]} {cpuAddress[5]} {cpuAddress[6]} {cpuAddress[7]} {cpuAddress[8]} {cpuAddress[9]} {cpuAddress[10]} {cpuAddress[11]} {cpuAddress[12]} {cpuAddress[13]} {cpuAddress[14]} {cpuAddress[15]} {cpuAddress[16]} {cpuAddress[17]} {cpuAddress[18]} {cpuAddress[19]} {cpuAddress[20]} {cpuAddress[21]} {cpuAddress[22]} {cpuAddress[23]} {cpuAddress[24]} {cpuAddress[25]} {cpuAddress[26]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 16 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {cpuDataIn[0]} {cpuDataIn[1]} {cpuDataIn[2]} {cpuDataIn[3]} {cpuDataIn[4]} {cpuDataIn[5]} {cpuDataIn[6]} {cpuDataIn[7]} {cpuDataIn[8]} {cpuDataIn[9]} {cpuDataIn[10]} {cpuDataIn[11]} {cpuDataIn[12]} {cpuDataIn[13]} {cpuDataIn[14]} {cpuDataIn[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 16 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {cpuDataOut[0]} {cpuDataOut[1]} {cpuDataOut[2]} {cpuDataOut[3]} {cpuDataOut[4]} {cpuDataOut[5]} {cpuDataOut[6]} {cpuDataOut[7]} {cpuDataOut[8]} {cpuDataOut[9]} {cpuDataOut[10]} {cpuDataOut[11]} {cpuDataOut[12]} {cpuDataOut[13]} {cpuDataOut[14]} {cpuDataOut[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list computer/fpu1/enable_reg]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list computer/fpu1/enable_reg_1]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list computer/fpu1/enable_reg_2]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list computer/fpu1/enable_reg_3]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list computer/fpu1/op_enable]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list computer/fpu1/ready_o]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets cpu_clock]
