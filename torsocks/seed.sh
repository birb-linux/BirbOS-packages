NAME="torsocks"
DESC="Torsocks allows you to use most applications in a safe way with Tor"
VERSION="2.4.0"
SOURCE="https://gitlab.torproject.org/tpo/core/torsocks/-/archive/v${VERSION}/torsocks-v${VERSION}.tar.gz"
CHECKSUM="5ff691742f4dadb2566658bed625ed08"
DEPS="autoconf automake libtool tor"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-v${VERSION}
}

_build()
{
	./autogen.sh
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
