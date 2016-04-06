#!/bin/bash

# Developer: Iñaki Larrañaga Murgoitio <dooteo@zundan.com>, 2016
# License: GPL v3 or newer.


FUNCTIONS_DIR="$(dirname "$0")/functions"

. ${FUNCTIONS_DIR}/auxiliary.sh
. ${FUNCTIONS_DIR}/draw_mutinst_board.sh

# ---- ---- Initialize global vars ---- ----

export module="" 
export DEFAULTDIR="${HOME}/Projects/MutInstr/eurorack-master";
export in_date=`date +"%Y%m%d%H%M"`;


if [ ! -z $1 ]; then

	case $1 in
	"-h")
		show_help;
		;;

	"-d")
		if [ "${module}" = "" ]; then
			select_module;
		fi

		draw_board_${module};
		exit 0;
		;;

	"-l")
		if [ "${module}" = "" ]; then
			select_module;
		fi
		. ${FUNCTIONS_DIR}/ftn_${module}.sh;
		list_command_${module};
		exit 0;
		;;

	"-c")
		;;
	esac

elif

	echo "You must choose an option to run with. Bye!"
fi


