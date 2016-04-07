#!/bin/bash

DEFAULTDIR="${HOME}/Proiektuak/MutInstr/eurorack-master";
in_date=`date +"%Y%m%d%H%M"`;

MODULE="branches";

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

echo '---- Step 4: Build ${MODULE}! ----';
rm -rf ${BASEDIR}/build/${MODULE};

make -f ${MODULE}/makefile
echo -e "\n ---- Enter to continue ----";
read

echo '---- Step 5: Build ${MODULE}/BOOTSTRAP ALL ----';
make -f ${MODULE}/makefile bootstrap_all

echo 'If thats not works read commented lines into current script'
# apt-get install gcc-avr gdb-avr avrdude avr-libc 
# if [ ! -f "/etc/udev/avrisp.rules" ]; then
# cat <<EOF >/etc/udev/avrisp.rules
# SUBSYSTEM!="usb", ACTION!="add", GOTO="avrisp_end"
# 
# # Atmel Corp. JTAG ICE mkII
# ATTR{idVendor}=="03eb", ATTR{idProduct}=="2103", MODE="660", GROUP="dialout"
# # Atmel Corp. AVRISP mkII
# ATTR{idVendor}=="03eb", ATTR{idProduct}=="2104", MODE="660", GROUP="dialout"
# # Atmel Corp. Dragon
# ATTR{idVendor}=="03eb", ATTR{idProduct}=="2107", MODE="660", GROUP="dialout"
# 
# LABEL="avrisp_end"
# 
# EOF
# 
# ln /etc/udev/avrisp.rules /etc/udev/rules.d/60-avrisp.rules
# 
# USER=`grep 1000 /etc/passwd | cut -d":" -f1`
# 
# cat /etc/group | sed 's/dialout:x:20:/dialout:x:20:'${USER}'/g' > /tmp/group
# mv /tmp/group /etc/group
# 
# echo "${USER} logout and login again"
# 
# fi


