#!/bin/bash

# Developer: Iñaki Larrañaga Murgoitio <dooteo@zundan.com>, 2016
# License: GPL v3 or newer.

list_command_grids () {
	echo "
Note: Not use make -f ${module}/makefile slow_upload

Run next command to upload firmware to Grids: 

make -f ${module}/makefile bake
	"

	echo "
Last runs 2 avrdude commands:
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

upload_grids () {
	make -f ${module}/makefile bake
}

build_grids () {
	# ---- Build module ----
	AVRDUDE=`which avrdude`

	if [ "${AVRDUDE}" == "" ];then
		echo 'avrdude not installed. You know what to do! Bye'
		exit 1
	fi

	# ---- Enviroment variable for Python -----
	export PYTHONPATH=${BASEDIR};

	cd ${BASEDIR};

	echo '---- Step 4: Build ${module}! ----';
	rm -rf ${BASEDIR}/build/${module};

	make -f ${module}/makefile
	make -f ${module}/bootloader/makefile

	# ---- Upload firmware ----
	upload_grids;
}

