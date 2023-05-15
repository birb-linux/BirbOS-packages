NAME="mtdev"
DESC="Multitouch Protocol Translation Library"
VERSION="1.1.6"
SOURCE="https://bitmath.org/code/mtdev/mtdev-${VERSION}.tar.bz2"
CHECKSUM="bf8ef2482e84a00b5db8fbd3ce00e249"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
