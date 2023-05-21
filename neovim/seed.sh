NAME="neovim"
DESC="Vim-fork focused on extensibility and usability"
VERSION="0.9.0"
SOURCE="https://github.com/neovim/neovim/archive/refs/tags/v${VERSION}.tar.gz"
CHECKSUM="86b762639f29ee92d37f8ec0f78b7074"
DEPS="cmake unzip curl gettext"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$FAKEROOT/$NAME/usr" \
		CMAKE_BUILD_TYPE=Release \
		-j${BUILD_JOBS}
}

_install()
{
	make install
}
