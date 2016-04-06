#!/bin/bash

# Developer: Iñaki Larrañaga Murgoitio <dooteo@zundan.com>, 2016
# License: GPL v3 or newer.

draw_board_braids () {
	echo "
	 |-------- Braids -----------------------|
	 |                                       |
	 |                                JTag   |
	 |                                ----   |
	 |                                 * *   |
	 |                                 * *   |
	 |                                 * *   |
	 |                                 * *   |
	 |               Red Stripe -----> * *   |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |  Source Connector                     |
	 |  ----------------                     |
	 |  * * +12v                             |
	 |  * * gnd                              |
	 |  * * gnd                              |
	 |  * * gnd                              |
	 |  * * -12v  <--- Red Stripe            |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"
}

draw_board_branches () {
	echo "
	 |-------- Branches ---------------------|
	 |                                       |
	 |         Source Connector              |
	 |         ----------------              |
	 |         Red      * * * * *            |
	 |         Stripe   * * * * *            |
	 |            +-----^                    |
	 |                                       |
	 |                                       |
	 |                                       |
	 |   +-+--------Black                    |
	 |   | | +------Red                      |
	 |   | | |                               |
	 |   | | |                               |
	 |   v v v     I S P                     |
	 |             -----                     |
	 |   * * *  <-- Connector  1             |
	 |   * * *  <-- Connector  2             |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"
}

draw_board_clouds () {
	echo "
	 |-------- Clouds -----------------------|
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"
}

draw_board_elements () {
	echo "
	 |-------- Elements ---------------------|
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"

}

draw_board_frames () {
	echo "
	 |-------- Frames -----------------------|
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"
}

draw_board_grids () {
	echo "
	 |-------- Grids ------------------------|
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"
}

draw_board_peaks () {
	echo "
	 |-------- Peaks ------------------------|
	 |                                       |
	 |         Source Connector              |
	 |         ----------------              |
	 |         * * * * *                     |
	 |   -12v  * * * * *                     |
	 |         ^ g g g +12v                  |
	 |         | n n n                       |
	 |         | d d d                       |
	 |         |                             |
	 |        Red                            |
	 |        Stripe                         |
	 |                                       |
	 |                                       |
	 |                                       |
	 |  JTag                                 |
	 |  ----                                 |
	 |  * * <---- Red Stripe                 |
	 |  * *                                  |
	 |  * *                                  |
	 |  * *                                  |
	 |  * *                                  |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"
}

draw_board_streams () {
	echo "
	 |-------- Streams ----------------------|
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"
}

draw_board_tides () {
	echo "
	 |-------- Tides ------------------------|
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"
}

draw_board_yarns () {
	echo "
	 |-------- Yarns ------------------------|
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 |                                       |
	 | board Backside                        |
	 |---------------------------------------|
	"
}


