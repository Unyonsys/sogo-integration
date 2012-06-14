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
sed -i "s%</Seq>%  <li>\n      <Description\n        em:id=\"{e2fda1a4-762b-4020-b5ad-a41df1933103}\"\n        em:name=\"Lightning\"/>\n    </li>\n  </Seq>%g" build/chrome/content/extensions.rdf

cd build
zip -r sogo-integrator-$VERSION.xpi *
mv sogo-integrator-$VERSION.xpi ../

cd ..
cp upstream-plugins/updates.php .
sed -i s%$UPSTREAM_URL%$OUR_URL%g updates.php
