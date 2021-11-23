#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Tue Nov 23 15:55:52 EET 2021
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim my_simulation_behav -key {Behavioral:sim_1:Functional:my_simulation} -tclbatch my_simulation.tcl -protoinst "protoinst_files/design_1.protoinst" -view /home/ghostpants/Documents/UPB_IV_C2_2020-2021/SMP/lab03_solved/my_simulation_behav.wcfg -log simulate.log"
xsim my_simulation_behav -key {Behavioral:sim_1:Functional:my_simulation} -tclbatch my_simulation.tcl -protoinst "protoinst_files/design_1.protoinst" -view /home/ghostpants/Documents/UPB_IV_C2_2020-2021/SMP/lab03_solved/my_simulation_behav.wcfg -log simulate.log

