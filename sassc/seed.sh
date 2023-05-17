NAME="sassc"
DESC="SassC is a wrapper around libsass, a CSS pre-processor language"
VERSION="3.6.2"
SOURCE="https://github.com/sass/sassc/archive/${VERSION}/sassc-${VERSION}.tar.gz"
CHECKSUM="4c3b06ce2979f2a9f0a35093e501d8bb"
DEPS="libsass"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	autoreconf -fi

	./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${MAKEOPTS}
}

_install()
{
	make install
}
