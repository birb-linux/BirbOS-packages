NAME="alsa-utils"
DESC="Various utilities which are useful for controlling your sound card"
VERSION="1.2.8"
SOURCE="https://www.alsa-project.org/files/pub/utils/alsa-utils-${VERSION}.tar.bz2"
CHECKSUM="51175f5cd413daf7009a80684c65113d"
DEPS="alsa-lib ncurses"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --disable-alsaconf \
			--prefix=$FAKEROOT/$NAME/usr \
            --disable-bat   \
            --disable-xmlto \
            --with-curses=ncursesw

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
