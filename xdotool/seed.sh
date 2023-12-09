NAME="xdotool"
DESC="Fake keyboard/mouse input, window management, and more"
VERSION="3.20211022.1"
SOURCE="https://github.com/jordansissel/xdotool/releases/download/v${VERSION}/xdotool-${VERSION}.tar.gz"
CHECKSUM="9fd993a251a7c38b32381503544b0dd7"
DEPS="libxtst libx11 libxinerama libxkbcommon"
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
	make DESTDIR=$FAKEROOT/$NAME install
}
