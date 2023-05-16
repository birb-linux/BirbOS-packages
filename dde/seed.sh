NAME="dde"
DESC="Dynamic Desktop Environment"
VERSION="1.0.0"
SOURCE="https://github.com/Toasterbirb/dde/releases/download/${VERSION}/dde-${VERSION}.tar.gz"
CHECKSUM="8434490227e7d0614b3711b350b6a62f"
DEPS="xorg-libs pkg-config ncurses fontconfig mononoki"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd dde
}

_build()
{
	SRC_ROOT=$(pwd)

	# Build everything
	for i in dmenu dwm dwmblocks slock st
	do
		cd $i
		CC=gcc make -j${MAKEOPTS}
		cd $SRC_ROOT
	done
}

_install()
{
	# Install everything
	for i in dmenu dwm dwmblocks slock st
	do
		cd $i
		CC=gcc make PREFIX=$FAKEROOT/$NAME/usr install
		cd $SRC_ROOT
	done
}
