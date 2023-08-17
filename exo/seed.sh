NAME="exo"
DESC="Support library used in the Xfce desktop with some helper applications included"
VERSION="4.18.0"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://archive.xfce.org/src/xfce/exo/${SHORT_VERSION}/exo-${VERSION}.tar.bz2"
CHECKSUM="9d0be4e885eaf991e12dbc14d3fc628d"
DEPS="gtk+ libxfce4ui libxfce4util"
FLAGS="test"

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

_test()
{
	make -j${BUILD_JOBS} check
}
