NAME="itstool"
DESC="Extracts messages from XML files and outputs PO template files"
VERSION="2.0.7"
SOURCE="https://files.itstool.org/itstool/itstool-${VERSION}.tar.bz2"
CHECKSUM="267a3bdc72a2d8abb1b824f2ea32ee9b"
DEPS="docbook-xml"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	PYTHON=/usr/bin/python3 ./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
