# shellcheck disable=SC2034
NAME="lazygit"
DESC="Simple terminal UI for git commands"
VERSION="0.41.0"
SOURCE="https://github.com/jesseduffield/lazygit/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="29b9d7ed08aec8f45105037ed1cece24"
DEPS="go"
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	make
}

_install()
{
	cp -vf "$PWD/lazygit" "$FAKEROOT/$NAME/usr/bin/lazygit"
}
