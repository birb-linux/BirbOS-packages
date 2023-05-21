NAME="libtool"
DESC="GNU generic library support script"
VERSION="2.4.7"
SOURCE="https://ftp.gnu.org/gnu/libtool/libtool-${VERSION}.tar.xz"
CHECKSUM="2fc0b6ddcd66a89ed6e45db28fa44232"
DEPS=""
FLAGS="32bit test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr

	make -j${BUILD_JOBS}
}

_install()
{
	make install

	# Remove a useless static library
	rm -fv /usr/lib/libltdl.a
}

_test()
{
	make -j${BUILD_JOBS} -k check
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	make distclean

	CC="gcc -m32" ./configure \
		--host=i686-pc-linux-gnu \
		--prefix=$FAKEROOT/$NAME/usr \
		--libdir=/usr/lib32

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
