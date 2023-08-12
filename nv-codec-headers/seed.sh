NAME="nv-codec-headers"
DESC="FFmpeg version of headers required to interface with Nvidias codec APIs"
VERSION="12.0.16.0"
SOURCE="https://github.com/FFmpeg/nv-codec-headers/releases/download/n${VERSION}/nv-codec-headers-${VERSION}.tar.gz"
CHECKSUM="21c29fed4437a746ae0216fc91534588"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make PREFIX=/usr
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
