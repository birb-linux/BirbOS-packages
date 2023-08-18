NAME="gdk-pixbuf"
DESC="Toolkit for image loading and pixel buffer manipulation"
VERSION="2.42.10"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/gdk-pixbuf/${SHORT_VERSION}/gdk-pixbuf-${VERSION}.tar.xz"
CHECKSUM="4a62f339cb1424693fba9bb7ffef8150"
DEPS="glib libjpeg-turbo libpng shared-mime-info libtiff"
FLAGS="32bit test"

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

	meson --prefix=/usr --buildtype=release --wrap-mode=nofallback -Dman=false ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
}

_post_install()
{
	gdk-pixbuf-query-loaders --update-cache
}

_test()
{
	ninja test
}

_build32()
{
	cd ..
	rm -r build
	mkdir build
	cd    build

	# libxslt will cause some errors, but they are harmless
	set +e

	meson --prefix=/usr \
		  --buildtype=release  \
		  --wrap-mode=nofallback    \
		  -Dman=false          \
		  ..

	ninja

	set -e
}

_install32()
{
	DESTDIR=$PWD/DESTDIR ninja install
	cp -Rv DESTDIR/usr/lib/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
