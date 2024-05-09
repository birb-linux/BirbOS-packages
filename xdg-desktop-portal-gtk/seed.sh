# shellcheck disable=SC2034
NAME="xdg-desktop-portal-gtk"
DESC="Backend for xdg-desktop-portal"
VERSION="1.15.1"
SOURCE="https://github.com/flatpak/xdg-desktop-portal-gtk/releases/download/${VERSION}/xdg-desktop-portal-gtk-${VERSION}.tar.xz"
CHECKSUM="9c7836b1fe09bc914ea4c06b9c58231f"
DEPS="gtk+ xdg-desktop-portal"
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
