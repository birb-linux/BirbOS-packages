NAME="tmate"
DESC="Instant terminal sharing"
VERSION="2.4.0"
SOURCE="https://github.com/tmate-io/tmate/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="5571be65f5c54a35cc92ca7c9fb031c9"
DEPS="git libevent ncurses zlib libssh2 automake pkg-config libtool msgpack-c"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./autogen.sh
	./configure
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
