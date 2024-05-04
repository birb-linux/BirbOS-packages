NAME="libass"
DESC="Portable subtitle renderer for the ASS/SSA subtitle format"
VERSION="0.17.1"
SOURCE="https://github.com/libass/libass/releases/download/${VERSION}/libass-${VERSION}.tar.xz"
CHECKSUM="73f00a898161be424e05d4bee1962dbb"
DEPS="freetype fribidi nasm fontconfig"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
