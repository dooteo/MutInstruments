#!/bin/bash

# Developer: Iñaki Larrañaga Murgoitio <dooteo@zundan.com>, 2016
# License: GPL v3 or newer.

list_command_grids () {
	echo "
	Note: Not use make -f ${MODULE}/makefile slow_upload

	Run next command to upload firmware to Grids: 

	make -f ${module}/makefile bake
	"

	echo " Last runs 2 avrdude commands:
	/usr/bin/avrdude -V -p m328p -c avrispmkII -P usb -B 10 -e -u \
			-U efuse:w:0x05:m \
			-U hfuse:w:0xd8:m \
			-U lfuse:w:0xff:m \
			-U lock:w:0x2f:m

	/usr/bin/avrdude -V -p m328p -c avrispmkII -P usb -B 1 \
			-U flash:w:build/grids/grids.hex:i -U lock:w:0x2f:m

	If this fails, check next file to know how to solve transmission speed.

	Edit carefully next file: 
			avrlib/makefile.mk 
	"
}
build_grids () {
	echo "empty function"
}

upload_grids () {
	make -f ${module}/makefile bake
}

