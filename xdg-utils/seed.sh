# shellcheck disable=SC2034
NAME="xdg-utils"
DESC="Set of command line tools that assist applications with a variety of desktop integration tasks"
VERSION="1.2.1"
SOURCE="https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/v${VERSION}/xdg-utils-v${VERSION}.tar.gz"
CHECKSUM="4c72585a98ba8f775cb9e72b066cc0df"
DEPS="xmlto links xorg-apps"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-v${VERSION}" || exit 1
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
