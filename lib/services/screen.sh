#!/usr/bin/env bash

declare -g -x _screen_updated=0
declare -A -x _screen=(
    ['rows']=$LINES
    ['cols']=$COLUMNS
)

function screen_init() {

    clear
    screen_reset
    cursor_init
    printf '\033[?25l'
}

function screen_reset() {

    _screen['cols']=$COLUMNS
    _screen['rows']=$LINES
    clear
}

function screen_resized() { (( COLUMNS == _screen['cols'] )) && (( LINES == _screen['rows'] )) && echo 0 || echo 1; }

function render_init() { [[ $_screen_updated == 1 ]] && clear; }

function draw_chars() {

    local x=$1
    local y=$2
    local s="$3"

    printf "\033[${y};${x}H${s}"
}

function print_debug() { _print_pid && _print_key && _print_dimensions; }

function _print_dimensions() {
    
    local str="[ $(set_color 'cyan')${_screen['cols']}$(set_color) x $(set_color 'cyan')${_screen['rows']}$(set_color) ]"
    local start=$((${_screen['cols']}-$(str_length "$str")))
    draw_chars $start 1 "$str"
}

function _print_pid() {

    local pid=$$
    local str="[ PID: $(set_color 'red')${pid}$(set_color) ]"
    draw_chars 1 1 "$str"
}

function _print_key() {

    local key=$( get_last_key )
    local str="[ key: $(set_color 'light_green')${key}$(set_color) ]"
    local half_width=$(( ${_screen['cols']} / 2 ))
    local half_length=$(( $(str_length "$str") / 2))
    local start=$(( $half_width - $half_length ))
    draw_chars $start 1 "$str"
}