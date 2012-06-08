#!/bin/sh

VERSION=10.0.2
SOURCE_URL=http://www.sogo.nu/files/downloads/extensions
UPSTREAM_URL=http://sogo-demo.inverse.ca
OUR_URL=https://mail.unyonsys.com

rm -rf build
mkdir build

if [ ! -f upstream-plugins/sogo-connector-$VERSION.xpi ]; then
	wget $SOURCE_URL/sogo-connector-$VERSION.xpi -O upstream-plugins/sogo-connector-$VERSION.xpi
fi
if [ ! -e upstream-plugins/sogo-integrator-$VERSION-sogo-demo.xpi ]; then
	wget $SOURCE_URL/sogo-integrator-$VERSION-sogo-demo.xpi -O upstream-plugins/sogo-integrator-$VERSION-sogo-demo.xpi
fi

unzip -d build upstream-plugins/sogo-integrator-$VERSION-sogo-demo.xpi
sed -i s%$UPSTREAM_URL%$OUR_URL%g build/chrome/content/extensions.rdf
sed -i s%$UPSTREAM_URL%$OUR_URL%g updates.php
cd build
zip sogo-integrator-$VERSION.xpi *
mv sogo-integrator-$VERSION.xpi ../
