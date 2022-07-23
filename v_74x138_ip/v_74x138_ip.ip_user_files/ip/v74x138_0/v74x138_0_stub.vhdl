-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Wed Jun 16 19:00:17 2021
-- Host        : Stu60 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/Administrator/v_74x138_ip/v_74x138_ip.srcs/sources_1/ip/v74x138_0/v74x138_0_stub.vhdl
-- Design      : v74x138_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity v74x138_0 is
  Port ( 
    g1 : in STD_LOGIC;
    g2a_l : in STD_LOGIC;
    g2b_l : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 2 downto 0 );
    y_l : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end v74x138_0;

architecture stub of v74x138_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "g1,g2a_l,g2b_l,a[2:0],y_l[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "v74x138,Vivado 2017.4";
begin
end;
