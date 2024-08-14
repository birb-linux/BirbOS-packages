NAME="openssl"
DESC="Management tools and libraries relating to cryptography"
VERSION="3.3.0"
SOURCE="https://www.openssl.org/source/openssl-${VERSION}.tar.gz"
CHECKSUM="c8b063afbea85d867e161ecb8816cfa9"
DEPS="zlib perl"
FLAGS="test 32bit important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./config --prefix=$FAKEROOT/$NAME/usr \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic

	make -j${BUILD_JOBS}
}

_install()
{
	sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
	make -j${BUILD_JOBS} MANSUFFIX=ssl install

	# Add version to the documentation directory name
	mv -v $FAKEROOT/$NAME/usr/share/doc/openssl $FAKEROOT/$NAME/usr/share/doc/openssl-${VERSION}

	# Install some additional documentation
	cp -vfr doc/* $FAKEROOT/$NAME/usr/share/doc/openssl-${VERSION}
}

_test()
{
	make -j${BUILD_JOBS} test
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	make distclean

	CFLAGS="-m32 -march=i686 -Wall -O3" CXXFLAGS="$CFLAGS" \
	./config --prefix=$FAKEROOT/$NAME/usr \
			 --openssldir=/etc/ssl \
			 --libdir=lib32        \
			 shared                \
			 zlib-dynamic          \
			 linux-generic32

	make -j${BUILD_JOBS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/$FAKEROOT/$NAME/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
