#!/bin/bash

# Developer: Iñaki Larrañaga Murgoitio <dooteo@zundan.com>, 2016
# License: GPL v3 or newer.

 show_help () {
	echo -e "
	Usage: $0 [option]

	-c      Compile whole module and upload brand new firmare. Default.	
	-d      Show diagram how to connect.
	-l      Show last command to upload firmware.
	-h      Show this help.
	"
}

 select_module () {
	echo "
	Enter module's number to draw its board.

	1 - Braids - A
	2 - Branches - B
	3 - Clouds - C
	4 - Elements - E
	5 - Frames - F
	6 - Grids - G
	7 - Peaks - P
	8 - Streams - S
	9 - Tides - T
	10 - Yarns - Y
	"

	read module;
	which_module="${module,,}"

	case "${which_module}" in
	1 | braids | a)
		module="braids"
		;;
	2 | branches | b)
		module="branches"
		;;
	3 | clouds | c)
		module="clouds"
		;;
	4 | elements | e)
		module="elements"
		;;
	5 | frames | f)
		module="frames"
		;;
	6 | grids | g)
		module="grids"
		;;
	7 | peaks | p)
		module="peaks"
		;;
	8 | streams | s)
		module="streams"
		;;
	9 | tides | t)
		module="tides"
		;;
	10 | yarns | y)
		module="yarns"
		;;
	*)
		echo -e "Module unknown. Did you entered wrong number? ${module}";
		exit 1
		;;
	esac


	echo "
	---- ---- ${module^^} was selected ---- ----
	"

}

