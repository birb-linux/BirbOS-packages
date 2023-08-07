NAME="gst-plugins-base"
DESC="Well-groomed and well-maintained collection of GStreamer plug-ins and elements"
VERSION="1.22.0"
SOURCE="https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-${VERSION}.tar.xz"
CHECKSUM="c559f23bb746bda732e85ba7b76c2074"
DEPS="gstreamer alsa-lib gobject-introspection iso-codes libgudev libjpeg-turbo libogg libpng libtheora libvorbis mesa pango wayland-protocols xorg-libs"
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
		   -Dpackage-origin=https://www.linuxfromscratch.org/blfs/view/11.3/ \
		   -Dpackage-name="GStreamer ${VERSION}"    \
		   --wrap-mode=nodownload
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
