#!/usr/bin/env bash

declare -g -x -a _clock_listeners=()
declare -g -x _tick=0

function clock_listen() { _clock_listeners+=$1; }

function clock_cycle() {

	_tick=$(($_tick+1))
	[[ $_tick == '10' ]] && _on_trigger
	sleep ${_config['delay']}
}

function _on_trigger() { _tick=0 && _fire_event; }

function _fire_event() { for listener in ${_clock_listeners[@]}; do $listener; done; }