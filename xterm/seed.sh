NAME="xterm"
DESC="Terminal emulator for the X Window System"
VERSION="379"
SOURCE="https://invisible-mirror.net/archives/xterm/xterm-${VERSION}.tgz"
CHECKSUM="5e98e6c74f344b211918bf75d0827831"
DEPS="xorg-apps dejavu"
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
		--with-app-defaults=$FAKEROOT/$NAME/etc/X11/app-defaults

	make -j${BUILD_JOBS}
}

_install()
{
	make install
	make install-ti

	cp -v *.desktop $FAKEROOT/$NAME/usr/share/applications/

	# Create a basic configuration file
	cat >> $FAKEROOT/$NAME/etc/X11/app-defaults/XTerm << "EOF"
*VT100*locale: true
*VT100*faceName: Monospace
*VT100*faceSize: 10
*backarrowKeyIsErase: true
*ptyInitialErase: true
EOF
}
