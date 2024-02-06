NAME="neovim"
DESC="Vim-fork focused on extensibility and usability"
VERSION="0.9.4"
SOURCE="https://github.com/neovim/neovim/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="3cffcc063c8c6c157356ac555f83418b"
DEPS="cmake unzip curl gettext"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	disable_lto

	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr" \
		CMAKE_BUILD_TYPE=Release \
		-j${BUILD_JOBS}
}

_install()
{
	make install
}
