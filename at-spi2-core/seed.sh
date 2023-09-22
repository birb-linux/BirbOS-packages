NAME="at-spi2-core"
DESC="Comprehensive accessibility framework for the Assistive Technologies available on the GNOME platform"
VERSION="2.46.0"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/at-spi2-core/${SHORT_VERSION}/at-spi2-core-${VERSION}.tar.xz"
CHECKSUM="16e85a40442d80be960b4e1e3992fd5b"
DEPS="dbus glib gsettings-desktop-schemas xorg-libs meson ninja"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=/usr       \
		  --buildtype=release \
		  -Dsystemd_user_dir=/tmp ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
	rm -f /tmp/at-spi-dbus-bus.service
}
