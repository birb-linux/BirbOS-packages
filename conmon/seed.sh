NAME="conmon"
DESC="An OCI container runtime monitor"
VERSION="2.1.8"
SOURCE="https://github.com/containers/conmon/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="753a2d554c6b5c55c93f069a20d9ebf9"
DEPS="libseccomp pkg-config runc"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make PREFIX=/usr -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
