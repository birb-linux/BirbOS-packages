NAME="qalculate"
DESC="Multi-purpose CLI calculator and a library for the GUI versions of qalculate"
VERSION="4.8.0"
SOURCE="https://github.com/Qalculate/libqalculate/releases/download/v${VERSION}/libqalculate-${VERSION}.tar.gz"
CHECKSUM="736d47204c7b53b97ecf3737ba9204bc"
DEPS="gmp mpfr libxml2 icu gettext readline"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libqalculate-${VERSION}
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
