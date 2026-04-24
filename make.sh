#!/bin/bash

CROCON_ROOT=$(pwd)/..
CC="gcc"
CC_FLAGS="-Wall -Wextra -O2"
LD_FLAGS=""
CROCON_DEBUG=false

show_help() {
    cat << EOF
Crocon TUI Framework Build Script

Usage: $0 [options]
    
Help options:
    --help		print this message
	
Standard options:
    --disable-logging	do not log configure debug information
EOF
}

while [[ $# -gt 0 ]]; do
    case $1 in
	--help)
	    show_help
	    exit 0
	    ;;
	*)
	    echo "Unknown parameter '$1'"
	    exit 1
	    ;;
    esac
    shift
done

makeCrocon() {
    echo "[1/2] Building Crocon TUI Framework from source..."

    cd $CROCON_ROOT/library/proj/gcc
    make
    cd $CROCON_ROOT

    echo
    echo "[2/2] Building Crocon Demos..."

    cd $CROCON_ROOT/demos/barebns1/proj/gcc
    make
    cd $CROCON_ROOT/build
    
    echo Done!
    echo 
}

makeCrocon