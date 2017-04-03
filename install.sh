#!/bin/bash
set -e
    
# Installing SoftHSM dependencies
sudo apt-get update -qq
sudo apt-get install libssl-dev
sudo apt-get install build-essential autoconf automake libtool

# Installing SoftHSM
git clone https://github.com/opendnssec/SoftHSMv2.git -b master --depth 1
cd SoftHSMv2
sh ./autogen.sh
./configure
make
sudo -E make install
cd ..
sudo ldconfig

# initializing SoftHSM
softhsm2-util --init-token --so-pin "12345" --pin "12345" --slot 0 --label "My slot 0"
