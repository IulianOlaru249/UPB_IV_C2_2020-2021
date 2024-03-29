#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Sun Oct 24 20:25:44 EEST 2021
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim test1_behav -key {Behavioral:sim_1:Functional:test1} -tclbatch test1.tcl -protoinst "protoinst_files/design_1.protoinst" -log simulate.log"
xsim test1_behav -key {Behavioral:sim_1:Functional:test1} -tclbatch test1.tcl -protoinst "protoinst_files/design_1.protoinst" -log simulate.log

