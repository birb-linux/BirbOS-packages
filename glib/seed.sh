NAME="glib"
DESC="Bundle of three low-level system libraries written in C"
VERSION="2.79.3"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/glib/${SHORT_VERSION}/glib-${VERSION}.tar.xz"
CHECKSUM="61cfd3de3de4344c60308416c2874b82"
DEPS="libxslt pcre2 meson ninja"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	# libxslt will cause some errors, but they are harmless
	set +e

	meson --prefix=$FAKEROOT/$NAME/usr \
		  --buildtype=release \
		  -Dman=false          \
		  ..

	ninja

	set -e
}

_install()
{
	ninja install

	mkdir -p $FAKEROOT/$NAME/usr/share/doc/glib-${VERSION}
	#cp -r ../docs/reference/{gio,glib,gobject} $FAKEROOT/$NAME/usr/share/doc/glib-${VERSION}
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
		  --buildtype=release \
		  -Dman=false          \
		  -Dtests=false \
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
