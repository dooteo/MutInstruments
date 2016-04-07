#!/bin/bash

DEFAULTDIR="${HOME}/Proiektuak/MutInstr/eurorack-master";
in_date=`date +"%Y%m%d%H%M"`;

MODULE="grids";
AVRDUDE=`which avrdude`

if [ "${AVRDUDE}" == "" ];then
	echo 'avrdude not installed. You know what to do! Bye'
	exit
fi

echo " Enter EuroRack Master path (from HOME) ";
echo " or default [${DEFAULTDIR}]";
read AUXPATH;

if [ "${AUXPATH}"=="" ]; then
	echo -e "Using default path\n${DEFAULTDIR}";
	BASEDIR=${DEFAULTDIR};
else 
	BASEDIR=${HOME}/${AUXPATH};
fi


# ---- Enviroment variable for Python -----
export PYTHONPATH=${BASEDIR};

cd ${BASEDIR};

echo '---- Step 4: Build ${MODULE}! ----';
rm -rf ${BASEDIR}/build/${MODULE};

make -f ${MODULE}/makefile
make -f ${MODULE}/bootloader/makefile

echo "Not use make -f ${MODULE}/makefile slow_upload"

make -f ${MODULE}/makefile bake

echo " Last runs 2 avrdude commands:
/usr/bin/avrdude -V -p m328p -c avrispmkII -P usb -B 10 -e -u \
		-U efuse:w:0x05:m \
		-U hfuse:w:0xd8:m \
		-U lfuse:w:0xff:m \
		-U lock:w:0x2f:m

/usr/bin/avrdude -V -p m328p -c avrispmkII -P usb -B 1 \
		-U flash:w:build/grids/grids.hex:i -U lock:w:0x2f:m

"
echo "If this fails, check next file to know how to solve transmission speed."
echo -e "Edit carerfully next file: \navrlib/makefile.mk "


