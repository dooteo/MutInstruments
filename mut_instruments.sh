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

if [ -z $1 ] || [ "$1" = "-h" ]; then
	show_help;
	echo "You must choose an option to run with. Bye!";
	exit 0;
fi

case $1 in
"-d")
	select_module;
	draw_board_${module};
	exit 0;
	;;

"-l")
	select_module;
	. ${FUNCTIONS_DIR}/ftn_${module}.sh;

	list_command_${module};
	exit 0;
	;;

"-c")
	select_module;
	. ${FUNCTIONS_DIR}/ftn_${module}.sh;

	echo " Enter EuroRack Master path (from HOME) ";
	echo " or default [${DEFAULTDIR}]";
	read eurorack_path;

	if [ "${eurorack_path}"="" ]; then
		echo -e "Using default path\n${DEFAULTDIR}";
		export BASEDIR=${DEFAULTDIR};
	else 
		export BASEDIR=${HOME}/${eurorack_path};
	fi

	build_${module};
	;;
*)
	show_help;
	echo "You must choose an option to run with. Bye!";
	exit 0;
	;;
esac


