NAME="dwm"
DESC="Dynamic tiling window manager"
VERSION="2.0.0"
SOURCE="https://github.com/Toasterbirb/dwm/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="57d367385f9653dbaedd1d1c5680ae76"
DEPS="dmenu xorg-apps xorg-libs xorg-server pkg-config ncurses fontconfig mononoki xf86-input-libinput xf86-video-fbdev"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
