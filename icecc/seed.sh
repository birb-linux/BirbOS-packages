# shellcheck disable=SC2034
NAME="icecc"
DESC="Distributed compiler with a central scheduler to share build load"
VERSION="1.4.0"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://github.com/icecc/icecream/releases/download/${SHORT_VERSION}/icecc-${VERSION}.tar.gz"
CHECKSUM="369d4510168e21bd44e40fa9af08f5c3"
DEPS="asciidoctor libcap-ng lzo zstd libarchive"
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
