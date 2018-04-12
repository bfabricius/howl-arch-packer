#!/bin/bash

set -eu

ARM_DWNLD=https://developer.arm.com/-/media/Files/downloads/gnu-rm/7-2017q4/gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2?revision=375265d4-e9b5-41c8-bf23-56cbe927e156?product=GNU%20Arm%20Embedded%20Toolchain,64-bit,,Linux,7-2017-q4-major
TLC_AR_NAME=gcc-arm-none-eabi-7-2017-q4-major-linux.tar.bz2

echo "============================================"
echo "Bootsrapping large files for packer build."
echo "============================================"

echo "Checking if ARM Toolchain package needs to be downloaded..."

cd arm-tlc
if [[ -f ${TLC_AR_NAME} ]]; then
	echo "ARM Toolchain package exists. Nothing to do."
	echo "============================================"
	echo "You can now run the packer build."
	echo "============================================"
	exit 0
fi
echo "Downloading ARM Toolchain package..."
curl \
  -o ${TLC_AR_NAME} \
  -L ${ARM_DWNLD}

echo "Finished downloading ARM Toolchain package..."
echo "============================================"
echo "Finished bootstrapping large files."
echo "You can now run the packer build."
echo "============================================"

cd -

exit $?
