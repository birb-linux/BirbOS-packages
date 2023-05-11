NAME="time"
DESC="Program that measures many of the CPU resources, such as time and memory, that other programs use"
VERSION="1.9"
SOURCE="https://ftp.gnu.org/gnu/time/time-${VERSION}.tar.gz"
CHECKSUM="d2356e0fe1c0b85285d83c6b2ad51b5f"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	make -j${MAKEOPTS} check
}
