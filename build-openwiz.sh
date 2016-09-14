#!/bin/sh

## -- OPEN2X USER SETTINGS

## OPEN2X - This should point to the root of your tool-chain {i.e. folder above the BIN dir}

OPEN2X=/opt/openwiz/arm-openwiz-linux-gnu

## HOST and TARGET - These should be the canonical tool names of your tool.
## For the sake of this script HOST and TARGET should be the same.
## Defaults would be 'arm-open2x-linux' for a normal Open2x tool-chain.

HOST=arm-openwiz-linux-gnu
TARGET=arm-openwiz-linux-gnu
BUILD=`uname -m`
PKG_CONFIG_PATH=/opt/openwiz/arm-openwiz-linux-gnu/lib/pkgconfig

## -- END OPEN2X USER SETTINGS

export OPEN2X
export HOST
export TARGET
export PKG_CONFIG_PATH

PREFIX=$OPEN2X
export PREFIX

PATH=$PATH:$OPEN2X/bin
export PATH

#ln -s `whereis -b pkg-config | sed 's/pkg-config\: //g'` /opt/openwiz/arm-openwiz-linux-gnu/bin/pkg-config

# Do not edit below here
CC="${OPEN2X}/bin/${HOST}-gcc"
CXX="${OPEN2X}/bin/${HOST}-g++"
AR="${OPEN2X}/bin/${HOST}-ar"
STRIP="${OPEN2X}/bin/${HOST}-strip"
RANLIB="${OPEN2X}/bin/${HOST}-ranlib"

CFLAGS="-DTARGET_GP2X_WIZ -O2 -ffast-math -fomit-frame-pointer -mcpu=arm920t -DARM -D_ARM_ASSEM_ -I${OPEN2X}/include -I${OPEN2X}/include/libxml2 -I${OPEN2X}/include/SDL"
LDFLAGS="-L${OPEN2X}/lib"
#PKG_CONFIG="${OPEN2X}/bin/pkg-config"

export CC
export CXX
export AR
export STRIP
export RANLIB
export CFLAGS
export LDFLAGS
export PKG_CONFIG

echo Current settings.
echo
echo Install root/Working dir	= $OPEN2X
echo Tool locations 		    = $OPEN2X/bin
echo Host/Target		        = $HOST / $TARGET
echo

echo CC         = $CC
echo CXX        = $CXX
echo AR         = $AR
echo STRIP      = $STRIP
echo RANLIB     = $RANLIB

echo CFLAGS     = $CFLAGS
echo LDFLAGS    = $LDFLAGS
echo PKG_CONFIG = $PKG_CONFIG

echo "### Building 3rd party software ###"
cd 3rdparty/des-4.04b
case $1 in
    release)
        make clean && make
        ;;

    *)
        make
        ;;
esac
if [ $? -ne 0 ]; then
    echo "*** ABORT ***"
    exit 1
fi
cd -

echo "### Building BennuGD Core ###"

cd core
case $1 in
    release)
        ./configure --prefix=${PREFIX} --target=${TARGET} --host=${HOST} --build=${BUILD} --enable-shared PKG_CONFIG_LIBDIR=${PKG_CONFIG_PATH} && make clean && make
        ;;

    *)
        make
        ;;
esac
if [ $? -ne 0 ]; then
    echo "*** ABORT ***"
    exit 1
fi
cd -

echo "### Building BennuGD Modules ###"

cd modules
case $1 in
    release)
        ./configure --prefix=${PREFIX} --target=${TARGET} --host=${HOST} --build=${BUILD} --enable-shared PKG_CONFIG_LIBDIR=${PKG_CONFIG_PATH} && make clean && make
        ;;

    *)
        make
        ;;
esac
if [ $? -ne 0 ]; then
    echo "*** ABORT ***"
    exit 1
fi
cd -

echo "### Building BennuGD Tools ###"

cd tools/moddesc
case $1 in
    release)
        ./configure --prefix=${PREFIX} --target=${TARGET} --host=${HOST} --build=${BUILD} --enable-shared PKG_CONFIG_LIBDIR=${PKG_CONFIG_PATH} && make clean && make
        ;;

    *)
        make
        ;;
esac
if [ $? -ne 0 ]; then
    echo "*** ABORT ***"
    exit 1
fi
cd -

echo "### Copying files to bin folder ###"

mkdir -p bin/$TARGET 2>/dev/null
cp 3rdparty/des-4.04b/libdes.so bin/$TARGET
cp core/bgdi/src/.libs/bgdi bin/$TARGET
cp core/bgdc/src/bgdc bin/$TARGET
cp core/bgdrtm/src/.libs/libbgdrtm.so bin/$TARGET
cp $(find modules -name '*.so') bin/$TARGET
cp tools/moddesc/moddesc bin/$TARGET

echo "### Build done! ###"

exit 0
