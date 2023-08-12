NAME="uchardet"
DESC="Encoding detector library"
VERSION="0.0.8"
SOURCE="https://www.freedesktop.org/software/uchardet/releases/uchardet-${VERSION}.tar.xz"
CHECKSUM="9e267be7aee81417e5875086dd9d44fd"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	cmake -DCMAKE_INSTALL_PREFIX=/usr .
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
