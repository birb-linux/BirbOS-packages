NAME="mhash"
DESC="Library which provides a uniform interface to a large number of hash algorithms"
VERSION="0.9.9.9"
SOURCE="https://sourceforge.net/projects/mhash/files/mhash/${VERSION}/mhash-${VERSION}.tar.gz"
CHECKSUM="ee66b7d5947deb760aeff3f028e27d25"
DEPS="perl"
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
