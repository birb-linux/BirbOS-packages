NAME="libxshmfence"
DESC="Shared memory 'SyncFence' synchronization primitive"
VERSION="1.3.2"
SOURCE="https://www.x.org/archive//individual/lib/libxshmfence-${VERSION}.tar.xz"
CHECKSUM="faa74f7483074ce7d4349e6bdc237497"
DEPS="fontconfig libxcb elogind libx11"
FLAGS="32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd libxshmfence-${VERSION}
}

_build()
{
	./configure $XORG_CONFIG --docdir=$XORG_PREFIX/share/doc/$NAME-$VERSION
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_build32()
{
	make distclean

	LDFLAGS="-L/usr/lib32" CC="gcc -m32" ./configure \
		$XORG_CONFIG \
		--host=i686-pc-linux-gnu \
		--libdir=/usr/lib32

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
