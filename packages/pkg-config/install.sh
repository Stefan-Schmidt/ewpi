#! /bin/sh

# $1 : name
# $2 : tarname
# $3 : prefix
# $4 : host
# $5 : taropt

cd packages/$1 &> /dev/null
dir_name=`tar t$5 $2 | head -1 | cut -f1 -d"/"`
cd $dir_name
./configure --prefix=$3 --host=$4 --disable-static --with-internal-glib=yes &> ../config.log
make -j install &> ../make.log
sed -i -e 's/installed: no/installed: yes/g' ../$1.ewpi
