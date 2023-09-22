NAME="glu"
DESC="Mesa OpenGL Utility library"
VERSION="9.0.2"
SOURCE="ftp://ftp.freedesktop.org/pub/mesa/glu/glu-${VERSION}.tar.xz"
CHECKSUM="2b0f13fa5b949bfb3a995927c6e35125"
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
