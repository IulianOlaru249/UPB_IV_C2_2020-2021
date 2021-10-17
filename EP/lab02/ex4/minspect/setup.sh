#!/bin/bash

PIN_URL="https://software.intel.com/sites/landingpage/pintool/downloads/pin-3.13-98189-g60a6ef199-gcc-linux.tar.gz"
ARCHIVE="$(basename ${PIN_URL})"

# fetch intel pin
mkdir -p third_party
pushd third_party

wget ${PIN_URL}
tar xf ${ARCHIVE}
rm -f ${ARCHIVE}
mv pin-* pin-3.13

popd