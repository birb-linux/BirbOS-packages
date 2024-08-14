# shellcheck disable=SC2034
NAME="slirp4netns"
DESC="User-mode networking for unprivileged network namespaces"
VERSION="1.3.0"
SOURCE="https://github.com/rootless-containers/slirp4netns/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="5c865eee3e800fdd078031cd81065c3f"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	./autogen.sh
	./configure --prefix=/usr
	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install
}
