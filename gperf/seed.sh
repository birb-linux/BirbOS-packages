NAME="gperf"
DESC="Program for generating a perfect hash function from a key set"
VERSION="3.1"
SOURCE="https://ftp.gnu.org/gnu/gperf/gperf-${VERSION}.tar.gz"
CHECKSUM="9e251c0a618ad0824b51117d5d9db87e"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --docdir=/usr/share/doc/gperf-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	make -j1 check
}
