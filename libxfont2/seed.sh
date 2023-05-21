NAME="libxfont2"
DESC="X.Org Xfont library"
VERSION="2.0.6"
SOURCE="https://www.x.org/archive//individual/lib/libXfont2-${VERSION}.tar.xz"
CHECKSUM="c179daa707f5f432f1bc13977e5bb329"
DEPS="fontconfig libxcb elogind libx11 libfontenc"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXfont2-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION \
		--disable-devel-docs

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
