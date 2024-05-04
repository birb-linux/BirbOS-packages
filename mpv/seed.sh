NAME="mpv"
DESC="Command line video player"
VERSION="0.37.0"
SOURCE="https://github.com/mpv-player/mpv/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="54bd6864cc831f1fee6dee693a0421eb"
DEPS="xorg-libs pulseaudio ffmpeg zlib libass libjpeg-turbo uchardet libxpresent luajit meson libplacebo"
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
