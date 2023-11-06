NAME="dwm"
DESC="Dynamic tiling window manager"
VERSION="2.1.0"
SOURCE="https://github.com/Toasterbirb/dwm/archive/refs/tags/${VERSION}.tar.gz"
CHECKSUM="37d9b678c0d8aae1d3841718efb9eb2b"
DEPS="dmenu xorg-apps xorg-libs xorg-server pkg-config ncurses fontconfig mononoki xf86-input-libinput xf86-video-fbdev"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# If the system configs exist, build against them
	if [ -f /etc/dwm/config.h ] && [ -f /etc/dwm/theme.h ]
	then
		make SETTINGS="-DSYSTEM_CONFIG" -j${BUILD_JOBS}
	else
		# Do a normal build
		make -j${BUILD_JOBS}

		# Copy the config files over if they cant be found in /etc
		mkdir -p /etc/dwm
		for i in config.h theme.h
		do
			[ ! -f /etc/dwm/$i ] && mv $i /etc/dwm/$i
		done
	fi
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/usr install
}
