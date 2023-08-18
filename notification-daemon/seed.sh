NAME="notification-daemon"
DESC="Daemon that displays passive pop-up notifications"
VERSION="3.20.0"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/notification-daemon/${SHORT_VERSION}/notification-daemon-${VERSION}.tar.xz"
CHECKSUM="2de7f4075352831f1d98d8851b642124"
DEPS="gtk+ libcanberra"
FLAGS=""

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
