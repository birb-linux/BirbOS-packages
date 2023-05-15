NAME="xorg-server"
DESC="The core of the X Window system"
VERSION="21.1.7"
SOURCE="https://www.x.org/pub/individual/xserver/xorg-server-${VERSION}.tar.xz"
CHECKSUM="277a842f1e223820a31a9bd7887d2aab"
DEPS="libxcvt pixman font-util xkeyboard-config elogind polkit"
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

	meson --prefix=$XORG_PREFIX \
		  --localstatedir=/var  \
		  -Dsuid_wrapper=true   \
		  -Dxkb_output_dir=/var/lib/xkb

	ninja
}

_install()
{
	ninja install &&
	mkdir -pv /etc/X11/xorg.conf.d
	cat >> /etc/sysconfig/createfiles << "EOF"
/tmp/.ICE-unix dir 1777 root root
/tmp/.X11-unix dir 1777 root root
EOF
}
