NAME="screen"
DESC="Terminal multiplexor"
VERSION="4.9.0"
SOURCE="https://ftp.gnu.org/gnu/screen/screen-${VERSION}.tar.gz"
CHECKSUM="b1ef8ed89134d335e614016634982b6d"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sh autogen.sh
	./configure --prefix=/usr                     \
				--infodir=/usr/share/info         \
				--mandir=/usr/share/man           \
				--with-socket-dir=/run/screen     \
				--with-pty-group=5                \
				--with-sys-screenrc=/etc/screenrc

	# Fix documentation and configuration related file paths
	sed -i -e "s%/usr/local/etc/screenrc%/etc/screenrc%" {etc,doc}/* &&

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
	install -m 644 etc/etcscreenrc $FAKEROOT/$NAME/etc/screenrc
}
