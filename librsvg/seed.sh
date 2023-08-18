NAME="librsvg"
DESC="Library and tools used to manipulate, convert and view Scalable Vector Graphic (SVG) images"
VERSION="2.54.5"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gnome.org/sources/librsvg/${SHORT_VERSION}/librsvg-${VERSION}.tar.xz"
CHECKSUM="eb56ffb37a7db48491177eb9bd135cb5"
DEPS="cairo gdk-pixbuf pango rustc gobject-introspection"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/librsvg-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_post_install()
{
	gdk-pixbuf-query-loaders --update-cache
}
