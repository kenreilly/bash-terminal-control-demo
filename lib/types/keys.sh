#!/usr/bin/env bash

declare -A -x key_map=(
	['UP']='[A'
	['DOWN']='[B'
	['LEFT']='[D'
	['RIGHT']='[C'
)

declare -a -x _direction_keys=('UP' 'DOWN' 'LEFT' 'RIGHT')

function get_key_name() {

	local input=$1
	[[ $input == '' ]] && return;

	for x in ${!key_map[@]}; do
		if [ $input == ${key_map[$x]} ]; then echo $x && return; fi
	done

	echo $input
}

function is_direction() {

	local input=$1
	[[ $input == '' ]] && return;

	for x in ${_direction_keys[@]}; do
		if [ $input == $x ]; then echo 1 && return; fi
	done

	echo 0
}