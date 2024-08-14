# shellcheck disable=SC2034
NAME="xdg-desktop-portal"
DESC="D-Bus service that allows applications to interact with the desktop in a safe way"
VERSION="1.18.2"
SOURCE="https://github.com/flatpak/xdg-desktop-portal/releases/download/${VERSION}/xdg-desktop-portal-${VERSION}.tar.xz"
CHECKSUM="20e0b28c1528e57b13cc236ba7840e03"
DEPS="fuse gdk-pixbuf json-glib pipewire dbus bubblewrap"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	mkdir build
	cd    build || exit 1

	meson setup --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR="$FAKEROOT/$NAME" ninja install

	# Remove unnecessary systemd files
	rm -rvf "$FAKEROOT/$NAME/usr/lib/systemd"
}
