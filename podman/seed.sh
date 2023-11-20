NAME="podman"
DESC="A tool for managing OCI containers and pods with Docker-compatible CLI"
VERSION="4.7.2"
SOURCE="https://github.com/containers/podman/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="4b78f4b222e5d6e9eaaf3c74ef91e973"
DEPS="gpgme lvm2 libseccomp go iptables conmon runc"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make BUILDTAGS="seccomp exclude_graphdriver_btrfs" PREFIX=/usr
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
