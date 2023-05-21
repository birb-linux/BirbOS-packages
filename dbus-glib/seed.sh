NAME="dbus-glib"
DESC="GLib interfaces to the D-Bus API"
VERSION="0.112"
SOURCE="https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-${VERSION}.tar.gz"
CHECKSUM="021e6c8a288df02c227e4aafbf7e7527"
DEPS="dbus glib"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr     \
            --sysconfdir=/etc \
            --disable-static

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
