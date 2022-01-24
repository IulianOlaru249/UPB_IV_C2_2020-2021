//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
//Date        : Mon Jan 24 22:43:10 2022
//Host        : ghostmachine running 64-bit Linux Mint 19.3 Tricia
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=5,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   ();

  wire [2:0]ddr_0_SBS_A;
  wire ddr_0_SCAS_A;
  wire [3:0]ddr_0_SCKE_A;
  wire [2:0]ddr_0_SCLK_A;
  wire [1:0]ddr_0_SCS_A;
  wire [7:0]ddr_0_SDM_A;
  wire [14:0]ddr_0_SMA_A;
  wire [1:0]ddr_0_SODT_A;
  wire ddr_0_SRAS_A;
  wire ddr_0_SWE_A;
  wire [2:0]gmch_0_BSEL;
  wire gmch_0_DMI_ZCOMP;
  wire gmch_0_HACCVREF;
  wire gmch_0_HDVREF;
  wire gmch_0_HPCREQ;
  wire gmch_0_HSWING;
  wire [2:3]gmch_0_RXN;
  wire [0:1]gmch_0_RXN_A;
  wire [2:3]gmch_0_RXP;
  wire [0:1]gmch_0_RXP_A;
  wire ich8_0_DMI_IRCOMP;
  wire ich8_0_GPIO29;
  wire ich8_0_GPIO30;
  wire ich8_0_GPIO31;
  wire [4:0]ich8_0_OC;
  wire [2:3]ich8_0_TXN;
  wire [0:1]ich8_0_TXN_A;
  wire [2:3]ich8_0_TXP;
  wire [0:1]ich8_0_TXP_A;
  wire ich8_0_USBRBIAS_I;
  wire processor_0_HBPRI;
  wire processor_0_HDEFER;
  wire [2:0]processor_0_HRS;
  wire processor_0_HTRDY;
  wire usb_0_USBRBIAS_O;

  design_1_ddr_0_1 ddr_0
       (.SBS_A(ddr_0_SBS_A),
        .SCAS_A(ddr_0_SCAS_A),
        .SCKE_A(ddr_0_SCKE_A),
        .SCLK_A(ddr_0_SCLK_A),
        .SCS_A(ddr_0_SCS_A),
        .SDM_A(ddr_0_SDM_A),
        .SMA_A(ddr_0_SMA_A),
        .SODT_A(ddr_0_SODT_A),
        .SRAS_A(ddr_0_SRAS_A),
        .SWE_A(ddr_0_SWE_A));
  design_1_gmch_0_1 gmch_0
       (.BSEL(gmch_0_BSEL),
        .DMI_IRCOMP(ich8_0_DMI_IRCOMP),
        .DMI_ZCOMP(gmch_0_DMI_ZCOMP),
        .HACCVREF(gmch_0_HACCVREF),
        .HBPRI(processor_0_HBPRI),
        .HDEFER(processor_0_HDEFER),
        .HDVREF(gmch_0_HDVREF),
        .HPCREQ(gmch_0_HPCREQ),
        .HRS(processor_0_HRS),
        .HSWING(gmch_0_HSWING),
        .HTRDY(processor_0_HTRDY),
        .RXN(gmch_0_RXN),
        .RXN_A(gmch_0_RXN_A),
        .RXP(gmch_0_RXP),
        .RXP_A(gmch_0_RXP_A),
        .SBS_A(ddr_0_SBS_A),
        .SCAS_A(ddr_0_SCAS_A),
        .SCKE_A(ddr_0_SCKE_A),
        .SCLK_A(ddr_0_SCLK_A),
        .SCS_A(ddr_0_SCS_A),
        .SDM_A(ddr_0_SDM_A),
        .SMA_A(ddr_0_SMA_A),
        .SODT_A(ddr_0_SODT_A),
        .SRAS_A(ddr_0_SRAS_A),
        .SWE_A(ddr_0_SWE_A),
        .TXN(ich8_0_TXN),
        .TXN_A(ich8_0_TXN_A),
        .TXP(ich8_0_TXP),
        .TXP_A(ich8_0_TXP_A));
  design_1_ich8_0_1 ich8_0
       (.DMI_IRCOMP(ich8_0_DMI_IRCOMP),
        .DMI_ZCOMP(gmch_0_DMI_ZCOMP),
        .GPIO29(ich8_0_GPIO29),
        .GPIO30(ich8_0_GPIO30),
        .GPIO31(ich8_0_GPIO31),
        .OC(ich8_0_OC),
        .RXN(gmch_0_RXN),
        .RXN_A(gmch_0_RXN_A),
        .RXP(gmch_0_RXP),
        .RXP_A(gmch_0_RXP_A),
        .TXN(ich8_0_TXN),
        .TXN_A(ich8_0_TXN_A),
        .TXP(ich8_0_TXP),
        .TXP_A(ich8_0_TXP_A),
        .USBRBIAS_I(ich8_0_USBRBIAS_I),
        .USBRBIAS_O(usb_0_USBRBIAS_O));
  design_1_processor_0_1 processor_0
       (.BSEL(gmch_0_BSEL),
        .HACCVREF(gmch_0_HACCVREF),
        .HBPRI(processor_0_HBPRI),
        .HDEFER(processor_0_HDEFER),
        .HDVREF(gmch_0_HDVREF),
        .HPCREQ(gmch_0_HPCREQ),
        .HRS(processor_0_HRS),
        .HSWING(gmch_0_HSWING),
        .HTRDY(processor_0_HTRDY));
  design_1_usb_0_0 usb_0
       (.GPIO29(ich8_0_GPIO29),
        .GPIO30(ich8_0_GPIO30),
        .GPIO31(ich8_0_GPIO31),
        .OC(ich8_0_OC),
        .USBRBIAS_I(ich8_0_USBRBIAS_I),
        .USBRBIAS_O(usb_0_USBRBIAS_O));
endmodule
