NAME="babl"
DESC="Dynamc, any to any, pixel format translation library"
VERSION="0.1.98"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://download.gimp.org/pub/babl/${SHORT_VERSION}/babl-${VERSION}.tar.xz"
CHECKSUM="0fd5f826e2ef14de04d978c203a3fe28"
DEPS="librsvg little-cms"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir bld
	cd    bld

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install

	install -v -m755 -d                         $FAKEROOT/$NAME/usr/share/gtk-doc/html/babl/graphics
	install -v -m644 docs/*.{css,html}          $FAKEROOT/$NAME/usr/share/gtk-doc/html/babl
	install -v -m644 docs/graphics/*.{html,svg} $FAKEROOT/$NAME/usr/share/gtk-doc/html/babl/graphics
}

_test()
{
	ninja test
}
