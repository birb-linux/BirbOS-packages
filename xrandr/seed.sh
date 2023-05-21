NAME="xrandr"
DESC="Primitive command line interface to RandR extension"
VERSION="1.5.2"
SOURCE="https://www.x.org/archive//individual/app/xrandr-${VERSION}.tar.xz"
CHECKSUM="f822a8d5f233e609d27cc22d42a177cb"
DEPS="libpng mesa xbitmaps xcb-util"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG
	make -j${BUILD_JOBS}
}

_install()
{
	make install

	# Replace an undocumented (and possibly broken) script
	rm -fv $XORG_PREFIX/bin/xkeystone
}
