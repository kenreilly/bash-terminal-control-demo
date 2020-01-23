#!/usr/bin/env bash

declare -g -x -A _cursor=( ['x']=5 ['y']=5 )
declare -g -x -A _prev=( ['x']=5 ['y']=5 )
declare -g -x visible=0

function cursor_init() { clock_listen _on_clock_tick; }

function render_cursor() { _draw_cursor $(_get_cursor_char); }

function parse_direction() {

	local direction=$1

	case $direction in
		"UP") (( _cursor['y'] > 1 )) && _cursor['y']=$(( ${_cursor['y']}-1 )) ;;
		"DOWN") (( _cursor['y'] < _screen['rows'] )) && _cursor['y']=$(( ${_cursor['y']}+1 )) ;;
		"LEFT") (( _cursor['x'] > 1 )) && _cursor['x']=$(( ${_cursor['x']}-1 )) ;;
		"RIGHT") (( _cursor['x'] < _screen['cols'] )) && _cursor['x']=$(( ${_cursor['x']}+1 )) ;;
	esac

	if [[ ${_cursor['x']} != ${_prev['x']} ]] || [[ ${_cursor['y']} != ${_prev['y']} ]]; then

		_screen_updated=1
		_prev['x']=${_cursor['x']}
		_prev['y']=${_cursor['y']}
	fi
}

function _on_clock_tick() { visible=$(( visible ^ 1 )); }

function _color_cursor() { echo "$(set_color 'light_magenta') $1 $(set_color)"; }

function _get_cursor_char() { [[ $visible == 1 ]] && echo "▒" || echo "░"; }

function _draw_cursor() { draw_chars ${_cursor['x']} ${_cursor['y']} "$(_color_cursor $1)"; }