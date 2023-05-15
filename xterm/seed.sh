NAME="xterm"
DESC="Terminal emulator for the X Window System"
VERSION="379"
SOURCE="https://invisible-mirror.net/archives/xterm/xterm-${VERSION}.tgz"
CHECKSUM="5e98e6c74f344b211918bf75d0827831"
DEPS="iceauth luit mkfontscale sessreg setxkbmap smproxy x11perf xauth xbacklight xcmsdb xcursorgen xdpyinfo xdriinfo xev xgamma xhost xinput xkbcomp xkbevd xkbutils xkill xlsatoms xlsclients xmessage xmodmap xpr xprop xrandr xrdb xrefresh xset xsetroot xvinfo xwd xwininfo xwud dejavu"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i '/v0/{n;s/new:/new:kb=^?:/}' termcap
	printf '\tkbs=\\177,\n' >> terminfo

	TERMINFO=/usr/share/terminfo \
	./configure $XORG_CONFIG     \
		--with-app-defaults=/etc/X11/app-defaults

	make -j${MAKEOPTS}
}

_install()
{
	make install
	make install-ti

	cp -v *.desktop $FAKEROOT/$NAME/usr/share/applications/
}
