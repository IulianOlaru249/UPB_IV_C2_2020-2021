#!/bin/bash
qsub -q ibm-dp.q -pe openmpi 48 -cwd run_hello.sh
