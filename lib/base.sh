#!/usr/bin/env bash

declare -A -x _config=( ['delay']=.01 )

function str_length() {

	local str=$(echo "$1" | sed -E 's/\\033\[[0-9]+;[0-9]+m//g')
	printf ${#str}
}