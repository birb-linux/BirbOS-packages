NAME="mpv"
DESC="Command line video player"
VERSION="0.36.0"
SOURCE="https://github.com/mpv-player/mpv/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="3ac8bb1fec1c09293a574e615446bb3b"
DEPS="xorg-libs pulseaudio ffmpeg zlib libass libjpeg-turbo uchardet libxpresent"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	meson setup --prefix=/usr -Dx11=enabled build
	meson compile -C build
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME meson install -C build
}
