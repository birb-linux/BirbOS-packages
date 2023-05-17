NAME="x264"
DESC="Library for encoding video streams into the H.264/MPEG-4 AVC format"
VERSION="20230215"
SOURCE="https://anduin.linuxfromscratch.org/BLFS/x264/x264-${VERSION}.tar.xz"
CHECKSUM="24eb4eae0d6358f31228c9ff86046c6f"
DEPS="nasm"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --enable-shared \
            --disable-cli

	make -j${MAKEOPTS}
}

_install()
{
	make install
}
