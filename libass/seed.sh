NAME="libass"
DESC="Portable subtitle renderer for the ASS/SSA subtitle format"
VERSION="0.17.0"
SOURCE="https://github.com/libass/libass/releases/download/${VERSION}/libass-${VERSION}.tar.xz"
CHECKSUM="25f7435779aa28eb7dbd3f76f4d17d15"
DEPS="freetype fribidi nasm fontconfig"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
