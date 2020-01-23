#!/usr/bin/env bash

declare -A -x color_map_16=(
	['black']='0;30'
	['red']='0;31'
	['green']='0;32'
	['brown']='0;33'
	['blue']='0;34'
	['magenta']='0;35'
	['cyan']='0;36'
	['light_gray']='0;37'
	['dark_gray']='1;30'
	['light_red']='1;31'
	['light_green']='1;32'
	['yellow']='1;33'
	['light_blue']='1;34'
	['light_magenta']='1;35'
	['light_cyan']='1;36'
	['white']='1;37'
)

function set_color() {

	local color_name=${1:-white}
	local color=${color_map_16[$color_name]}

	echo "\033[${color}m"
}