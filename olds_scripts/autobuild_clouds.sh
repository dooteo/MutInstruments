#!/bin/bash

DEFAULTDIR="${HOME}/Proiektuak/MutInstr/eurorack-master";
in_date=`date +"%Y%m%d%H%M"`;
MODULE="clouds"

echo " Enter EuroRack Master path (from HOME) ";
echo " or default [${DEFAULTDIR}]";
read AUXPATH;

if [ "${AUXPATH}"=="" ]; then
	echo -e "Using default path\n${DEFAULTDIR}";
	BASEDIR=${DEFAULTDIR};
else 
	BASEDIR=${HOME}/${AUXPATH};
fi
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

echo '---- Step 3: Check stm_audio_bootloader ----';
if [ ! -f "${BASEDIR}/stm_audio_bootloader/LICENSE" ]; then
	echo "Not found stm_audio_bootloader module. You should Git clone it! Bye!" ;
	exit;
fi

# ---- Enviroment variable for Python -----
export PYTHONPATH=${BASEDIR};

cd ${BASEDIR};

echo "---- Step 4: Build ${MODULE}! ----";
rm -rf ${BASEDIR}/build/${MODULE};

make -f ${MODULE}/makefile
echo -e "\n ---- Enter to continue ----";
read

echo '---- Step 5: Build ${MODULE}/bootloader --> HEX ----';
make -f ${MODULE}/bootloader/makefile hex
echo -e "\n ---- Enter to continue ----";
read

echo '---- Step 5: Build ${MODULE} --> WAV ----';
make -f ${MODULE}/makefile wav
echo -e "\n ---- Enter to continue ----";
read

echo '---- Step 6: Upload module ----';
echo -e "' Just take in mind: \nHold the RESET switch on the side of the module.\n Press the SYSBOOT switch next to it,\n and release RESET. ";
echo -e "\n ---- Enter to continue ----";
read

make -f ${MODULE}/makefile upload_combo_jtag_erase_first

