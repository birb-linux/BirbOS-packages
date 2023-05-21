NAME="libtheora"
DESC="Reference implementation of the Theora video compression format"
VERSION="1.1.1"
SOURCE="https://downloads.xiph.org/releases/theora/libtheora-${VERSION}.tar.xz"
CHECKSUM="9eeabf1ad65b7f41533854a59f7a716d"
DEPS="libogg libvorbis"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix a bug with libpng 1.6
	sed -i 's/png_\(sizeof\)/\1/g' examples/png2theora.c &&

	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static

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
