NAME="dde"
DESC="Dynamic Desktop Environment"
VERSION="1.0.2"
SOURCE="https://github.com/Toasterbirb/dde/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="2f119f35cb6ea693c2729d81dbe39273"
DEPS="xorg-apps xorg-libs xorg-server pkg-config ncurses fontconfig mononoki xf86-input-libinput xf86-video-fbdev xinit"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd dde-${VERSION}
}

_build()
{
	SRC_ROOT=$(pwd)

	# Build everything
	for i in dmenu dwm dwmblocks slock st
	do
		cd $i
		CC=gcc make -j${BUILD_JOBS}
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
