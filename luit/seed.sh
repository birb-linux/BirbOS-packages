NAME="luit"
DESC="Locale and ISO 2022 support for Unicode terminals"
VERSION="1.1.1"
SOURCE="https://www.x.org/archive//individual/app/luit-${VERSION}.tar.bz2"
CHECKSUM="c4a3664e08e5a47c120ff9263ee2f20c"
DEPS="libpng mesa xbitmaps xcb-util"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i -e "/D_XOPEN/s/5/6/" configure

	./configure $XORG_CONFIG
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
