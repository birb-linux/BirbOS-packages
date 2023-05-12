NAME="gobject-introspection"
DESC="The GObject Introspection is used to describe the program APIs and collect them in a uniform, machine readable format"
VERSION="1.74.0"
SHORT_VERSION="$(echo ${VERSION} | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/gobject-introspection/${SHORT_VERSION}/gobject-introspection-${VERSION}.tar.xz"
CHECKSUM="ed4e290c5ca8737a62c9a7f5347ae10d"
DEPS="glib"
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

	meson --prefix=$FAKEROOT/$NAME/usr --buildtype=release ..
	ninja
}

_install()
{
	ninja install
}
