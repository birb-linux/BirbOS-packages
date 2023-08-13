NAME="xdg-user-dirs"
DESC="Tool to help manage “well known” user directories like the desktop folder and the music folder"
VERSION="0.18"
SOURCE="https://user-dirs.freedesktop.org/releases/xdg-user-dirs-${VERSION}.tar.gz"
CHECKSUM="dc7decea7ffb58cd067eff1fe1798cae"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --sysconfdir=/etc
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
