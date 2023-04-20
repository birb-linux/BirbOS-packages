NAME="expat"
DESC="Stream oriented C library for parsing XML"
VERSION="2.5.0"
SOURCE="https://prdownloads.sourceforge.net/expat/expat-${VERSION}.tar.xz"
CHECKSUM="ac6677b6d1b95d209ab697ce8b688704"
DEPS=""
FLAGS="32bit test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --disable-static \
            --docdir=/usr/share/doc/expat-${VERSION}

	make -j$(nproc)
}

_install()
{
	make install

	# Install the documentation
	install -v -m644 doc/*.{html,css} $FAKEROOT/$NAME/usr/share/doc/expat-${VERSION}
}

# If the package has any tests, run them here
# To enable this function, specify the 'test' flag
#
# Also, birb needs to be run with special arguments to run tests
# when installing packages
_test()
{
	make -j$(nproc) check
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	sed -e "/^am__append_1/ s/doc//" -i Makefile
	make clean

	CC="gcc -m32" ./configure \
		--prefix=$FAKEROOT/$NAME/usr \
		--disable-static     \
		--libdir=/usr/lib32  \
		--host=i686-pc-linux-gnu

	make -j$(nproc)
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
