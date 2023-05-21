NAME="yasm"
DESC="Complete rewrite of the NASM assembler"
VERSION="1.3.0"
SOURCE="https://www.tortall.net/projects/yasm/releases/yasm-${VERSION}.tar.gz"
CHECKSUM="fc9e586751ff789b34b1f21d572d96af"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Don't compile 2 programs that are only of use on Windows
	sed -i 's#) ytasm.*#)#' Makefile.in

	./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j${BUILD_JOBS} check
}
