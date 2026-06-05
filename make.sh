#!/bin/bash

CROCON_ROOT=$(pwd)/..
CC="gcc"
CC_FLAGS="-Wall -Wextra -O2"
LD_FLAGS=""
CROCON_DEBUG=false
CROCON_LEGACY=false

show_help() {
    cat << EOF
Crocon TUI Framework Build Script

Usage: $0 [options]
    
Help options:
    --help                    print this message

Standard options:
    --enable-debug            build and include debug symbols to binaries
    --enable-legacy-support   disable new-styled library functions to improve compatibility
                              with older UNIX/Linux versions
    --build-aout-executable   build legacy a.out-compatible binaries (deprecated since Linux 5.19)
    --disable-logging         do not log configure debug information
    --prefix                  install library into specified path
EOF
}

while [ $# -gt 0 ]; do
    case $1 in
      --help)
          show_help
          exit 0
          ;;
      --enable-debug)
          CROCON_DEBUG=true
          shift
          ;;
      --enable-legacy-support)
          CROCON_LEGACY=true
          shift
          ;;
      --build-aout-executable)
          CROCON_AOUT=true
          shift
          ;;
      --prefix)
          PREFIX="$2"
          shift 2
          ;;
      *)
          echo "Unknown parameter '$1'"
          exit 1
          ;;
    esac
done

makeCrocon() {
    echo "[1/4] Cleaning previous builds..."
    rm -rf ../out

    echo "[2/4] Building Crocon TUI Framework from source..."

    cd $CROCON_ROOT/library/proj/gcc
    make CROCON_DEBUG=$CROCON_DEBUG CROCON_LEGACY=$CROCON_LEGACY CROCON_AOUT=$CROCON_AOUT
    
    if [ $? -ne 0 ]; then
        echo "CroconTUI build failed with error code $?."
        exit $?
    fi
    
    cd $CROCON_ROOT

    echo "[3/4] Installing Crocon TUI Framework... (requires su permissions)"

    su -c "cp out/library/bin/libcrocon.so $PREFIX/libcrocon.so"
    
    if [ $? -ne 0 ]; then
        echo "Crocon TUI Framework installation failed with error code $?."
        exit $?
    fi

    echo
    echo "[4/4] Building Crocon Demos..."

    cd $CROCON_ROOT/demos/barebns1/proj/gcc
    
    make CROCON_DEBUG=$CROCON_DEBUG CROCON_LEGACY=$CROCON_LEGACY CROCON_AOUT=$CROCON_AOUT
    
    if [ $? -ne 0 ]; then
        echo "Crocon Demos build failed with error code $?."
        exit $?
    fi
    
    cd $CROCON_ROOT/build

    echo Done!
    echo 
}

makeCrocon