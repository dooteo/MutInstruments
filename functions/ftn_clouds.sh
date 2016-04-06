#!/bin/bash

# Developer: Iñaki Larrañaga Murgoitio <dooteo@zundan.com>, 2016
# License: GPL v3 or newer.

list_command_clouds () {
	echo "
	Just take in mind (it's not a must): 
		Hold the RESET switch on the side of the module.
		Press the SYSBOOT switch next to it,
		and release RESET. 

	Run next command to upload firmware to Clouds: 

	make -f ${module}/makefile upload_combo_jtag_erase_first
	"
}

build_clouds () {
	echo "empty function"
}

upload_clouds () {
	make -f ${module}/makefile upload_combo_jtag_erase_first
}

