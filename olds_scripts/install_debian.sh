#!/bin/bash

apt-get -y install openocd binutils-arm-none-eabi gcc-arm-none-eabi \
	libstdc++-arm-none-eabi-newlib libnewlib-arm-none-eabi \
	libftdi1 libhidapi-hidraw0 libnewlib-dev

ARCH=`uname -m`
if [ "${ARCH}" != "ppc" ]; then
	apt-get -y install binutils-arm-linux-gnueabi binutils-arm-linux-gnueabihf  
fi
 
# To use by JSnyder / arm-eabi-toolchain
apt-get -y install curl flex bison texinfo \
      libelf-dev autoconf build-essential libncurses5-dev

echo "To build Branches and other AVR based boards installs: gcc-avr gdb-avr avrdude avr-libc " 
read
apt-get install gcc-avr gdb-avr avrdude avr-libc 

clear;
if [ ! -f "/etc/udev/avrisp.rules" ]; then
cat <<EOF >/etc/udev/avrisp.rules
SUBSYSTEM!="usb", ACTION!="add", GOTO="avrisp_end"

# Atmel Corp. JTAG ICE mkII
ATTR{idVendor}=="03eb", ATTR{idProduct}=="2103", MODE="660", GROUP="dialout"
# Atmel Corp. AVRISP mkII
ATTR{idVendor}=="03eb", ATTR{idProduct}=="2104", MODE="660", GROUP="dialout"
# Atmel Corp. Dragon
ATTR{idVendor}=="03eb", ATTR{idProduct}=="2107", MODE="660", GROUP="dialout"

LABEL="avrisp_end"

EOF

ln /etc/udev/avrisp.rules /etc/udev/rules.d/60-avrisp.rules

USER=`grep 1000 /etc/passwd | cut -d":" -f1`

cat /etc/group | sed 's/dialout:x:20:/dialout:x:20:'${USER}'/g' > /tmp/group
mv /tmp/group /etc/group

echo "${USER} logout and login again"

fi

# echo "avrdude -V -p m328p"
# /usr/bin/avrdude  -V -p m328p -c avrispmkII -P usb \
#		-B 1 -U flash:w:build/grids/grids.hex:i -U lock:w:0x2f:m 

