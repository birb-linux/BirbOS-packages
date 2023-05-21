NAME="libxscrnsaver"
DESC="Xlib-based X11 Screen Saver extension client library"
VERSION="1.2.4"
SOURCE="https://www.x.org/archive//individual/lib/libXScrnSaver-${VERSION}.tar.xz"
CHECKSUM="e613751d38e13aa0d0fd8e0149cec057"
DEPS="fontconfig libxcb elogind libx11 libxext"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libXScrnSaver-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
