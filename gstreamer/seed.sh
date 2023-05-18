NAME="gstreamer"
DESC="Streaming media framework"
VERSION="1.22.0"
SOURCE="https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-${VERSION}.tar.xz"
CHECKSUM="fb69587308e03e15c1b9a026a7b591d6"
DEPS="glib gobject-introspection"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson  --prefix=/usr       \
		   --buildtype=release \
		   -Dgst_debug=false   \
		   -Dpackage-name="GStreamer ${VERSION}" &&
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
