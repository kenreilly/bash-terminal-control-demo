#!/usr/bin/env bash

declare -g -x _key_input=''
declare -g -x _esc=$( printf '\033')

function input_init() { stty raw -echo -isig -ixon -ixoff time 0 2>/dev/null; }

function get_last_key() { echo "$_key_name"; }

function process_input() {

	_read_key _key_input
	_parse_key $_key_input || return

	_key_name=$(get_key_name $_key_input)
	[[ $( is_direction $_key_name ) == 1 ]] && parse_direction $_key_name
}

function _read_key() { IFS='' read -n1 -r -t 0.01 $1 2>/dev/null; }

function _parse_key() {

	[[ $_key_input == '' || $_key_input = $_esc ]] && return 1
	local key=$1

	[ $key == '[' ] || return 0
	_read_key _key_input
	_key_input=${key}${_key_input}
}