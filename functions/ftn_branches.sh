#!/bin/bash

# Developer: Iñaki Larrañaga Murgoitio <dooteo@zundan.com>, 2016
# License: GPL v3 or newer.


list_command_branches () {
	echo "
Run next command to upload firmware to Branches:

make -f ${module}/makefile bootstrap_all

-------------------------------
To force writting use -F option, like:

/usr/bin/avrdude -F -V -p m88p -c avrispmkII -P usb -B 10 \\
	-e -u -U efuse:w:0xf8:m \\
	-U hfuse:w:0xdd:m -U lfuse:w:0xe2:m \\
	-U flash:w:build/branches/branches.hex:i \\
	-U flash:w:build/branches_bootloader/branches_bootloader.hex:i \\
	-U lock:w:0x2f:m

		"

	echo '
-------------------------------
Note: If thats not works, try to setup your system:

apt-get install gcc-avr gdb-avr avrdude avr-libc 

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
	'
}

upload_branches () {

	make -f ${module}/makefile bootstrap_all

	echo "Did that command work as expected?(y/n)"
	read answer

	worked=${answer,,}
	case ${worked} in
	y | yes)
		echo "Congratulations! Well done!"
		;;
	n | no)
		echo "Let gonna try with this other one: "

		/usr/bin/avrdude -F -V -p m88p -c avrispmkII -P usb -B 10 -e -u \
			-U efuse:w:0xf8:m -U hfuse:w:0xdd:m -U lfuse:w:0xe2:m \
			-U flash:w:build/branches/branches.hex:i \
			-U flash:w:build/branches_bootloader/branches_bootloader.hex:i \
			-U lock:w:0x2f:m
		;;
	*)
		"Bye bye"
		;;
	esac

}

build_branches () {

	echo " ---- Base dir: ${BASEDIR} ----";
	echo '---- Step 1: Configure GCC compiler path ----';
	

	# Note: maybe next statements could be delete... Think and test about it!
	# echo " Modifying ${BASEDIR}/stmlib/makefile.inc "
	#cp ${BASEDIR}/avrlib/makefile.mk ${BASEDIR}/avrlib/makefile.inc.${in_date}
	#cat ${BASEDIR}/avrlib/makefile.mk | sed 's/\/usr\/local\/CrossPack-AVR\/bin\//\/usr\/bin\//g' > /tmp/avrlib_makefile.mk
	#mv /tmp/avrlib_makefile.mk ${BASEDIR}/avrlib/makefile.mk


	#echo '---- Step 2: Check and Configure avrlib interface ----';
	#if [ ! -f "${BASEDIR}/avrlib/README" ]; then
	#	echo "Not found avrlib module. You should Git clone it! Bye!" 
	#	exit
	#fi


	# ---- Enviroment variable for Python -----
	export PYTHONPATH=${BASEDIR};

	cd ${BASEDIR};

	echo '---- Step 2: Build ${module}! ----';
	rm -rf ${BASEDIR}/build/${module};
	make -f ${module}/makefile

	echo '---- Step 3: Build ${module}/BOOTSTRAP ALL ----';
	make -f ${module}/makefile bootstrap_all


	# ---- Upload firmware ----
	upload_branches;
}

