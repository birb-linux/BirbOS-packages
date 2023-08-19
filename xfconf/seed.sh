NAME="xfconf"
DESC="Configuration storage system for Xfce"
VERSION="4.18.0"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://archive.xfce.org/src/xfce/xfconf/${SHORT_VERSION}/xfconf-${VERSION}.tar.bz2"
CHECKSUM="efb7381405bc634306ed0d0cdf5aaffc"
DEPS="libxfce4util"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
