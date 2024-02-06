NAME="runc"
DESC="CLI tool for spawning and running containers according to the OCI specification"
VERSION="1.1.10"
SOURCE="https://github.com/opencontainers/runc/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="1a3c4081ad29cfaf8544edc70be81e0c"
DEPS="go libseccomp "
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make BUILDTAGS="seccomp" PREFIX=/usr
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
