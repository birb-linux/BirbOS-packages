# shellcheck disable=SC2034
NAME="scc"
DESC="Fast and accurate code counter with complexity calculations and COCOMO estimates"
VERSION="3.3.4"
SOURCE="https://github.com/boyter/scc/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="1b2bcd49fa2a2961803f78f5a5e53771"
DEPS="go"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	go build
}

_install()
{
	cp -vf "$PWD/scc" "$FAKEROOT/$NAME/usr/bin/scc"
}
