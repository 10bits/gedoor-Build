#!/bin/sh

function set_env() { echo "$1=$2" >> $GITHUB_ENV; }
function debug() { echo "::debug::$1"; }
function version_gt() { test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"; }
