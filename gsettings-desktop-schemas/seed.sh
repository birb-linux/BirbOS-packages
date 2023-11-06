NAME="gsettings-desktop-schemas"
DESC="A collection of GSettings schemas for settings shared by various components of a GNOME Desktop"
VERSION="43.0"
MAJOR_VERSION="$(major_version $VERSION)"
SOURCE="https://download.gnome.org/sources/gsettings-desktop-schemas/${MAJOR_VERSION}/gsettings-desktop-schemas-${VERSION}.tar.xz"
CHECKSUM="38f3f153be78402cbd18e3d4b44ba0fa"
DEPS="glib gobject-introspection meson ninja"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i -r 's:"(/system):"/org/gnome\1:g' schemas/*.in &&

	mkdir build
	cd    build

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
	glib-compile-schemas /usr/share/glib-2.0/schemas
}
