NAME="pango"
DESC="Library for laying out and rendering text, with an emphasis on internationalization"
VERSION="1.50.12"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/pango/${SHORT_VERSION}/pango-${VERSION}.tar.xz"
CHECKSUM="fd4b0b23915d6a0255317f811bea4215"
DEPS="fontconfig freetype harfbuzz fribidi glib cairo xorg-libs"
FLAGS=""

# TODO: Add gobject-introspection dependency to this package is GNOME support is needed

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=/usr --buildtype=release --wrap-mode=nofallback -Dintrospection=disabled ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}
