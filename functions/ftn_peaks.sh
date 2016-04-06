#!/bin/bash

# Developer: Iñaki Larrañaga Murgoitio <dooteo@zundan.com>, 2016
# License: GPL v3 or newer.

list_command_peaks () {
	echo "
	Just take in mind (it's not a must): 
		Hold the RESET switch on the side of the module.
		Press the SYSBOOT switch next to it,
		and release RESET. 

	Run next command to upload firmware to Peaks: 

	make -f ${module}/makefile  upload_combo_jtag
	"
}

build_peaks () {
	echo "empty function"
}

upload_peaks () {
	make -f ${module}/makefile  upload_combo_jtag
}

