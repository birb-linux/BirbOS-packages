NAME="dunst"
DESC="Lightweight and customizable notification daemon"
VERSION="1.9.2"
SOURCE="https://github.com/dunst-project/dunst/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="138b0a3542a8d0b69125c3c31e977405"
DEPS="dbus libxinerama libxrandr glib cairo pango libnotify"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make PREFIX=/usr DESTDIR=$FAKEROOT/$NAME -j${BUILD_JOBS}
}

_install()
{
	make PREFIX=/usr DESTDIR=$FAKEROOT/$NAME install
}
