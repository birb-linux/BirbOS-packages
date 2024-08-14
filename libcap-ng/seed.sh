# shellcheck disable=SC2034
NAME="libcap-ng"
DESC="Library for making programming with posix capabilities much easier"
VERSION="0.8.5"
SOURCE="https://people.redhat.com/sgrubb/libcap-ng/libcap-ng-${VERSION}.tar.gz"
CHECKSUM="3c280d902b902f28caf3990e018fcd31"
DEPS="python3"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	./configure --prefix=/usr
	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
