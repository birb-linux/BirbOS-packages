NAME="lxappearance"
DESC="Desktop-independent theme switcher for GTK+"
VERSION="0.6.3"
SOURCE="https://downloads.sourceforge.net/lxde/lxappearance-${VERSION}.tar.xz"
CHECKSUM="f10345313e2c12bad51c1b58bd46b454"
DEPS="gtk+"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-dbus

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
