#! /bin/sh

set -e

unset PKG_CONFIG_PATH

# $1 : arch
# $2 : tarname
# $3 : prefix
# $4 : host
# $5 : taropt
# $6 : jobopt

dir_name=`tar t$5 $2 | head -1 | cut -f1 -d"/"`
cd $dir_name

export PKG_CONFIG_DIR=
export PKG_CONFIG_LIBDIR=$3/lib/pkgconfig
export PKG_CONFIG_SYSROOOT_DIR=$3
export CPPFLAGS=-I$3/include
export CFLAGS="-O2 -pipe -march=$1"
export LDFLAGS="-L$3/lib -s"

./configure --prefix=$3 --host=$4 --disable-static > ../config.log 2>&1

make -j $jobopt install > ../make.log 2>&1
