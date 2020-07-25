#!/bin/bash

#SETUP BUILD ENVIROMENT
#
export ARCH=arm64
export PATH=/home/yes/android-toolchain/aarch64-linux-android-4.9-refs_heads_brillo-m7-mr-dev/bin:$PATH

#CLEAN SOURCE
#
OUTDIR=out
rm -rf $OUTDIR
mkdir $OUTDIR
make clean  $OUTDIR && make mrproper $OUTDIR

#MAKE DEFCONFIG
#
CCV="CROSS_COMPILE=aarch64-linux-android-"
make -C $(pwd) O=$OUTDIR $CCV j4primelte_defconfig

#GET CPU COUNT AND BUILD
#
CORE_COUNT=`grep processor /proc/cpuinfo|wc -l`
make -j$CORE_COUNT -C $(pwd) O=$OUTDIR $CCV
cp $OUTDIR/arch/arm/boot/zImage $(pwd)/arch/arm/boot/zImage
