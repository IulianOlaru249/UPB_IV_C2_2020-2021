#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Sun Oct 24 20:26:14 EEST 2021
# SW Build 2708876 on Wed Nov  6 21:39:14 MST 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto f50c9cf7da744c2fa58a20cd3cd654d2 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot test1_behav xil_defaultlib.test1 xil_defaultlib.glbl -log elaborate.log"
xelab -wto f50c9cf7da744c2fa58a20cd3cd654d2 --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot test1_behav xil_defaultlib.test1 xil_defaultlib.glbl -log elaborate.log

