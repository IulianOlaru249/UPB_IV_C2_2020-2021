#!bash

touch ex3_out
touch ex3_serial_out

echo  -n "Parallel approach:"
time ./ex3 > ex3_out

echo
echo -n "Serial approach:"
time ./ex3_serial > ex3_serial_out

rm ex3_out
rm ex3_serial_out
