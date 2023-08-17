NAME="xorg-server"
DESC="The core of the X Window system"
VERSION="21.1.8"
SOURCE="https://www.x.org/pub/individual/xserver/xorg-server-${VERSION}.tar.xz"
CHECKSUM="79a6eb04b1b17ad6c7aab46da73944e8"
DEPS="libxcvt pixman font-util xkeyboard-config elogind polkit libtirpc libepoxy libinput xcb-util-keysyms xcb-util-image xcb-util-renderutil xcb-util-wm"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir build
	cd    build

	meson --prefix=/usr                      \
		  --localstatedir=/var               \
		  -Dxkb_dir=/usr/share/X11/xkb       \
		  -Dmodule_dir=/usr/lib/xorg/modules \
		  -Dsuid_wrapper=true                \
		  -Dxephyr=true                      \
		  -Dxkb_output_dir=/var/lib/xkb

	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install &&
	mkdir -pv /etc/X11/xorg.conf.d
	cat >> /etc/sysconfig/createfiles << "EOF"
/tmp/.ICE-unix dir 1777 root root
/tmp/.X11-unix dir 1777 root root
EOF

	# Get rid of the input testing driver because it conflicts with libinput
	rm -r $FAKEROOT/$NAME/usr/lib/xorg/modules/input
}
