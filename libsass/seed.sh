NAME="libsass"
DESC="Library required for building SassC"
VERSION="3.6.5"
SOURCE="https://github.com/sass/libsass/archive/${VERSION}/libsass-${VERSION}.tar.gz"
CHECKSUM="c49765b9b3824dcd4a7423225ca28bad"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	autoreconf -fi

	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
