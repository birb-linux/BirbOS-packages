NAME="xkeyboard-config"
DESC="Keyboard configuration database for the X Window System"
VERSION="2.38"
SOURCE="https://www.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-${VERSION}.tar.xz"
CHECKSUM="c89fb974e8f1ba14c64d1bcf3a0f8d11"
DEPS="xtrans libx11 libxext libfs libice libsm libxscrnsaver libxt libxmu libxpm libxaw libxfixes libxcomposite libxrender libxcursor libxdamage libfontenc libxfont2 libxft libxi libxinerama libxrandr libxres libxtst libxv libxvmc libxxf86dga libxxf86vm libdmx libpciaccess libxkbfile libxshmfence"
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

	meson --prefix=$XORG_PREFIX --buildtype=release ..
	ninja
}

_install()
{
	ninja install
}
