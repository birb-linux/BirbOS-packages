NAME="portaudio"
DESC="Audio I/O library"
VERSION="v190700_20210406"
SOURCE="https://files.portaudio.com/archives/pa_stable_${VERSION}.tgz"
CHECKSUM="ad319249932c6794b551d954b8844402"
DEPS="alsa-lib alsa-oss"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}
}

_build()
{
	./configure --prefix=/usr --enable-cxx
	make -j1
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
