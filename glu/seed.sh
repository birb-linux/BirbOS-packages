NAME="glu"
DESC="Mesa OpenGL Utility library"
VERSION="9.0.3"
SOURCE="ftp://ftp.freedesktop.org/pub/mesa/glu/glu-${VERSION}.tar.xz"
CHECKSUM="06a4fff9179a98ea32ef41b6d83f6b19"
DEPS="mesa meson ninja"
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

	meson --prefix=/usr -Dgl_provider=gl --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install

	# Remove a static library
	rm -vf $FAKEROOT/$NAME/usr/lib/libGLU.a
}
