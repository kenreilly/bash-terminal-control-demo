#!/usr/bin/env bash
# @copyright 2019 - LevelUP
# @author Kenneth Reilly <@8_bit_hacker>

DEBUG=1

declare -g -x _DIR="$( cd "$(dirname "$0")" ; pwd -P )"
declare -g -x _ROOT="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"

source ${_ROOT}/lib/base.sh
source ${_ROOT}/lib/services/clock.sh
source ${_ROOT}/lib/services/cursor.sh
source ${_ROOT}/lib/services/input.sh
source ${_ROOT}/lib/services/screen.sh
source ${_ROOT}/lib/types/colors.sh
source ${_ROOT}/lib/types/keys.sh

function main() {

	input_init
	screen_init

	while [ : ]; do

		[[ $(screen_resized) == 1 ]] && screen_reset
	
		process_input
		render_init
		render_cursor

		[[ $DEBUG == 1 ]] && print_debug
		clock_cycle
	done
}

main