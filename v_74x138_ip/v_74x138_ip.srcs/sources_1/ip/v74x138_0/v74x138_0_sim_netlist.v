// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Wed Jun 16 19:00:17 2021
// Host        : Stu60 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Administrator/v_74x138_ip/v_74x138_ip.srcs/sources_1/ip/v74x138_0/v74x138_0_sim_netlist.v
// Design      : v74x138_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "v74x138_0,v74x138,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* X_CORE_INFO = "v74x138,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module v74x138_0
   (g1,
    g2a_l,
    g2b_l,
    a,
    y_l);
  input g1;
  input g2a_l;
  input g2b_l;
  input [2:0]a;
  output [7:0]y_l;

  wire [2:0]a;
  wire g1;
  wire g2a_l;
  wire g2b_l;
  wire [7:0]y_l;

  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFD)) 
    \y_l[0]_INST_0 
       (.I0(g1),
        .I1(g2a_l),
        .I2(g2b_l),
        .I3(a[2]),
        .I4(a[0]),
        .I5(a[1]),
        .O(y_l[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFDF)) 
    \y_l[1]_INST_0 
       (.I0(a[0]),
        .I1(a[2]),
        .I2(g1),
        .I3(g2a_l),
        .I4(g2b_l),
        .I5(a[1]),
        .O(y_l[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFDF)) 
    \y_l[2]_INST_0 
       (.I0(a[1]),
        .I1(a[2]),
        .I2(g1),
        .I3(g2a_l),
        .I4(g2b_l),
        .I5(a[0]),
        .O(y_l[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF7F)) 
    \y_l[3]_INST_0 
       (.I0(a[0]),
        .I1(a[1]),
        .I2(g1),
        .I3(g2a_l),
        .I4(g2b_l),
        .I5(a[2]),
        .O(y_l[3]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFDFF)) 
    \y_l[4]_INST_0 
       (.I0(g1),
        .I1(g2a_l),
        .I2(g2b_l),
        .I3(a[2]),
        .I4(a[0]),
        .I5(a[1]),
        .O(y_l[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF7F)) 
    \y_l[5]_INST_0 
       (.I0(a[0]),
        .I1(a[2]),
        .I2(g1),
        .I3(g2a_l),
        .I4(g2b_l),
        .I5(a[1]),
        .O(y_l[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFF7F)) 
    \y_l[6]_INST_0 
       (.I0(a[1]),
        .I1(a[2]),
        .I2(g1),
        .I3(g2a_l),
        .I4(g2b_l),
        .I5(a[0]),
        .O(y_l[6]));
  LUT6 #(
    .INIT(64'hFFFFFF7FFFFFFFFF)) 
    \y_l[7]_INST_0 
       (.I0(a[0]),
        .I1(a[2]),
        .I2(g1),
        .I3(g2a_l),
        .I4(g2b_l),
        .I5(a[1]),
        .O(y_l[7]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
