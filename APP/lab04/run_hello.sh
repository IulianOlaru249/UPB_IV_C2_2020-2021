#!/bin/bash
module load libraries/openmpi-2.0.1-gcc-5.4.0 compilers/gnu-5.4.0
mpirun -np 48  --mca btl_tcp_if_include eth0 ./hello
