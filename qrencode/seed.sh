NAME="qrencode"
DESC="Fast and compact library and a CLI application for encoding data in a QR Code symbol"
VERSION="4.1.1"
SOURCE="https://fukuchi.org/works/qrencode/qrencode-${VERSION}.tar.gz"
CHECKSUM="a046d19b4ad90d9f28ee0b3f29b60da6"
DEPS="autoconf automake libtool pkg-config libpng"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	cmake -DCMAKE_INSTALL_PREFIX=/usr ..
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
