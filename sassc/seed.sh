NAME="sassc"
DESC="SassC is a wrapper around libsass, a CSS pre-processor language"
VERSION="3.6.2"
SOURCE="https://github.com/sass/sassc/archive/${VERSION}/sassc-${VERSION}.tar.gz"
CHECKSUM="4c3b06ce2979f2a9f0a35093e501d8bb"
DEPS="wget"
FLAGS=""

LIBSASS_VERSION="3.6.5"
LIBSASS_CHECKSUM="c49765b9b3824dcd4a7423225ca28bad"

_setup()
{
	wget https://github.com/sass/libsass/archive/${LIBSASS_VERSION}/libsass-${LIBSASS_VERSION}.tar.gz
	MD5SUM="$(md5sum ./libsass-${LIBSASS_VERSION} | cut -d' ' -f1)"
	[ "$MD5SUM" != "$LIBSASS_CHECKSUM" ] && println ERROR "Checksum error with libsass" && exit 1

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}

	tar -xf ../libsass-${LIBSASS_VERSION}.tar.gz
	pushd libsass-${LIBSASS_VERSION}
}

_build()
{
	autoreconf -fi

	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static
	make -j${MAKEOPTS}
}

_install()
{
	make install
	popd

	# Also build + install the command line wrapper
	autoreconf -fi

	./configure --prefix=$FAKEROOT/$NAME/usr
	make -j${MAKEOPTS}
	make install
}
