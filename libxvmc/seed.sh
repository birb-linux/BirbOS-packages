NAME="libxvmc"
DESC="X.Org XvMC library"
VERSION="1.0.13"
SOURCE="https://www.x.org/archive//individual/lib/libXvMC-${VERSION}.tar.xz"
CHECKSUM="11a358e7229fa28dc9801c1e64fe2e18"
DEPS="fontconfig libxcb elogind libx11 libxext libxv"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXvMC-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION
	make -j${MAKEOPTS}
}

_install()
{
	make install

	# Overwrite a file created by xorgproto
	rm -fv /usr/include/X11/extensions/vldXvMC.h
}
