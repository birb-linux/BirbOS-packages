NAME="libwnck"
DESC="Window Navigator Construction Kit"
VERSION="43.0"
MAJOR_VERSION="$(major_version $VERSION)"
SOURCE="https://download.gnome.org/sources/libwnck/${MAJOR_VERSION}/libwnck-${VERSION}.tar.xz"
CHECKSUM="cd21ef743a1e9286554401c5b28d5ec6"
DEPS="gtk+ startup-notification"
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

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}
