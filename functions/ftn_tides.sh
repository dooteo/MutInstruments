#!/bin/bash

# Developer: Iñaki Larrañaga Murgoitio <dooteo@zundan.com>, 2016
# License: GPL v3 or newer.

list_command_tides () {
	echo "
Just take in mind (it's not a must): 
	Hold the RESET switch on the side of the module.
	Press the SYSBOOT switch next to it,
	and release RESET. 

Run next command to upload firmware to Tides: 

make -f ${module}/makefile upload_combo_jtag
	"
}

upload_tides () {
	make -f ${module}/makefile upload_combo_jtag
}

build_tides () {

	# ---- Build module ----
	echo " ---- Base dir: ${BASEDIR} ----";
	echo '---- Step 1: Configure GCC compiler path ----';
	echo " Modifying ${BASEDIR}/stmlib/makefile.inc "

	cp ${BASEDIR}/stmlib/makefile.inc ${BASEDIR}/stmlib/makefile.inc.${in_date}
	cat ${BASEDIR}/stmlib/makefile.inc | sed 's/\/usr\/local\/arm\//\/usr\//g' > /tmp/stmlib_makefile.inc
	mv /tmp/stmlib_makefile.inc ${BASEDIR}/stmlib/makefile.inc


	echo '---- Step 2: Check and Configure stmlib interface ----';
	if [ ! -f "${BASEDIR}/stmlib/LICENSE" ]; then
		echo "Not found STMLIB module. You should Git clone it! Bye!" 
		exit
	fi


	cp -f ${BASEDIR}/stmlib/programming/jtag/interface.cfg ${BASEDIR}/stmlib/programming/jtag/interface.${in_date}.old
	cat <<EOF > ${BASEDIR}/stmlib/programming/jtag/interface.cfg
	# Dooteo 4 Ever!

	tcl_port 5555
	telnet_port 4444
	gdb_port 3333

	# Dooteo hack
	interface ftdi
	ftdi_layout_init 0x0c08 0x0f1b
	ftdi_layout_signal nSRST -oe 0x0200
	ftdi_layout_signal nTRST -data 0x0100 -noe 0x0400
	ftdi_layout_signal LED -data 0x0800

	ftdi_device_desc "Olimex OpenOCD JTAG ARM-USB-OCD-H"
	ftdi_vid_pid 0x15ba 0x002b

	EOF

	STMCFG_FILE="stm32f10x.cfg"
	cp -f ${BASEDIR}/stmlib/programming/jtag/${STMCFG_FILE} ${BASEDIR}/stmlib/programming/jtag/${STMCFG_FILE}.${in_date}
	cat ${BASEDIR}/stmlib/programming/jtag/${STMCFG_FILE} | sed -e 's/jtag_khz/adapter_khz/g' \
	-e 's/jtag_nsrst_delay/adapter_nsrst_delay/g' > /tmp/${STMCFG_FILE}
	mv /tmp/${STMCFG_FILE} ${BASEDIR}/stmlib/programming/jtag/${STMCFG_FILE}


	echo '---- Step 3: Check stm_audio_bootloader ----';
	if [ ! -f "${BASEDIR}/stm_audio_bootloader/LICENSE" ]; then
		echo "Not found stm_audio_bootloader module. You should Git clone it! Bye!" ;
		exit;
	fi

	# ---- Enviroment variable for Python -----
	export PYTHONPATH=${BASEDIR};

	cd ${BASEDIR};

	echo '---- Step 4: Build ${module}! ----';
	rm -rf ${BASEDIR}/build/${module};
	make -f ${module}/makefile

	echo '---- Step 5: Build ${module} --> WAV ----';
	make -f ${module}/makefile wav

	echo '---- Step 5: Build ${module}/bootloader --> HEX ----';
	make -f ${module}/bootloader/makefile hex

	# ---- Upload firmware ----
	upload_tides;
}

