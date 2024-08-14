NAME="acl"
DESC="Utilities for administer Access Control Lists"
VERSION="2.3.2"
SOURCE="https://download.savannah.gnu.org/releases/acl/acl-${VERSION}.tar.xz"
CHECKSUM="590765dee95907dbc3c856f7255bd669"
DEPS=""
FLAGS="32bit important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static  \
            --docdir=/usr/share/doc/acl-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	make distclean

	CC="gcc -m32" ./configure \
		--prefix=$FAKEROOT/$NAME/usr \
		--disable-static      \
		--libdir=/usr/lib32   \
		--libexecdir=/usr/lib32   \
		--host=i686-pc-linux-gnu

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
