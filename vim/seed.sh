# shellcheck disable=SC2034
NAME="vim"
DESC="The best text editor created so far"
VERSION="9.0.1452"
SOURCE="https://anduin.linuxfromscratch.org/LFS/vim-${VERSION}.tar.gz"
CHECKSUM="dccf279f33a1df7e4e81941f38306de3"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf "$DISTFILES/$(basename $SOURCE)"
	cd "${NAME}-${VERSION}" || exit 1
}

_build()
{
	# Set the default vimrc location
	echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

	./configure --prefix=/usr

	make -j "${BUILD_JOBS}"
}

_install()
{
	make DESTDIR="$FAKEROOT/$NAME" install

	# Don't install xxd with the vim package, there will be a separate package for that
	rm -v "$FAKEROOT/$NAME/usr/bin/xxd"

	# Create a default configuration file
	cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set number
set incsearch
set relativenumber
set shiftwidth=4
set tabstop=4
set smartcase
set ignorecase
set softtabstop=0 noexpandtab
set updatetime=300
set shortmess+=c
set noswapfile
set termguicolors
colorscheme habamax


set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

map <Esc> :nohl<CR>

" End /etc/vimrc
EOF
}
