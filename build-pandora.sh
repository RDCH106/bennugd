#!/bin/sh

## -- PANDORA USER SETTINGS

## PANDORA - This should point to the root of your tool-chain {i.e. folder above the BIN dir}

PANDORA=~/Geca/BennuGD_Pandora/pandora-toolchain/arm-angstrom-linux-gnueabi

## HOST and TARGET - These should be the canonical tool names of your tool.
## For the sake of this script HOST and TARGET should be the same.
## Defaults would be 'arm-angstrom-linux-gnueabi' for a normal Pandora tool-chain.

HOST=arm-angstrom-linux-gnueabi
TARGET=arm-angstrom-linux-gnueabi
BUILD=`uname -m`
PKG_CONFIG_PATH=~/Geca/BennuGD_Pandora/pandora-toolchain/arm-angstrom-linux-gnueabi/lib/pkgconfig

## -- END PANDORA USER SETTINGS

export PANDORA
export HOST
export TARGET
export PKG_CONFIG_PATH

PREFIX=$PANDORA
export PREFIX

PATH=$PANDORA/bin:$PATH
export PATH

#ln -s `whereis -b pkg-config | sed 's/pkg-config\: //g'` ~/Geca/BennuGD_Pandora/pandora-toolchain/arm-angstrom-linux-gnueabil/bin/pkg-config

# Do not edit below here
CC="${PANDORA}/../bin/${HOST}-gcc"
CXX="${PANDORA}/../bin/${HOST}-g++"
AR="${PANDORA}/../bin/${HOST}-ar"
STRIP="${PANDORA}/../bin/${HOST}-strip"
RANLIB="${PANDORA}/../bin/${HOST}-ranlib"

#CFLAGS="-DTARGET_PANDORA -O2 -ffast-math -fomit-frame-pointer -mcpu=arm920t -DARM -D_ARM_ASSEM_ -I${PANDORA}/include -I${PANDORA}/include/libxml2 -I${PANDORA}/include/SDL"
#CFLAGS="-DTARGET_PANDORA -mcpu=arm926ej-s -mtune=arm926ej-s -fsigned-char -O3 -msoft-float -fomit-frame-pointer -fstrict-aliasing -mstructure-size-boundary=32 -fexpensive-optimizations -fweb -frename-registers -falign-functions=16 -falign-loops -falign-labels -falign-jumps -finline -finline-functions -fno-common -fno-builtin -fsingle-precision-constant -DARM -D_ARM_ASSEM_ -I${PANDORA}/include -I${PANDORA}/include/libxml2 -I${PANDORA}/include/SDL"
CFLAGS="-DTARGET_PANDORA -mcpu=arm926ej-s -mtune=arm926ej-s -O3 -DARM -D_ARM_ASSEM_ -I${PANDORA}/include -I${PANDORA}/include/libxml2 -I${PANDORA}/include/SDL"

LDFLAGS="-L${PANDORA}/lib"
#PKG_CONFIG="${PANDORA}/bin/pkg-config"

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
echo Install root/Working dir	= $PANDORA
echo Tool locations 		    = $PANDORA/bin
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

