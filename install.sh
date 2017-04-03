#!/bin/bash
set -e
    
# Installing SoftHSM dependencies
echo
echo "Install dependencies..."
echo
sudo apt-get update -qq
sudo apt-get install libssl-dev
sudo apt-get install build-essential autoconf automake libtool
echo
echo "Add missing..."
echo
sudo libtoolize && sudo aclocal && sudo autoheader && sudo autoconf && sudo automake --add-missing

# Installing SoftHSM
echo
echo "Installing SoftHSM..."
echo
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
