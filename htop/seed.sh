NAME="htop"
DESC="An interactive process viewer"
VERSION="3.2.2"
SOURCE="https://github.com/htop-dev/htop/releases/download/${VERSION}/htop-${VERSION}.tar.xz"
CHECKSUM="65242dcb1dc2564d647cbb4171a3914b"
DEPS="autoconf automake ncurses"
FLAGS=""

# TODO: Add support for lm-sensors

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
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
