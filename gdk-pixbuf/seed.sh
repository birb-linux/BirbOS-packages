NAME="gdk-pixbuf"
DESC="Toolkit for image loading and pixel buffer manipulation"
VERSION="2.42.10"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://download.gnome.org/sources/gdk-pixbuf/${SHORT_VERSION}/gdk-pixbuf-${VERSION}.tar.xz"
CHECKSUM="4a62f339cb1424693fba9bb7ffef8150"
DEPS="glib libjpeg-turbo libpng shared-mime-info libtiff"
FLAGS="test"

# TODO: Add librsvg runtime dependency when rustc has been packaged (>_<)
# TODO: Add gobject-introspection dependency if GNOME support is needed

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=/usr --buildtype=release --wrap-mode=nofallback ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

_test()
{
	ninja test
}
