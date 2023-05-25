NAME="playerctl"
DESC="mpris media player command-line controller"
VERSION="2.4.1"
SOURCE="https://github.com/altdesktop/playerctl/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="795c7f66fb865aa87a301b11f2a78940"
DEPS="gobject-introspection glib"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	meson setup --prefix=/usr -Dgtk-doc=false build
	cd build

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}
