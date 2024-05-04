NAME="kbd"
DESC="Key-table files, console fonts and keyboard utilities"
VERSION="2.6.4"
SOURCE="https://www.kernel.org/pub/linux/utils/kbd/kbd-${VERSION}.tar.xz"
CHECKSUM="e2fd7adccf6b1e98eb1ae8d5a1ce5762"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Remove the redundant resizecons programs
	sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
	sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

	# Build kbd without vlock
	./configure --prefix=$FAKEROOT/$NAME/usr --disable-vlock

	make -j${BUILD_JOBS}
}

_install()
{
	make install

	# Install the documentation
	mkdir -pv           $FAKEROOT/$NAME/usr/share/doc/kbd-${VERSION}
	cp -R -v docs/doc/* $FAKEROOT/$NAME/usr/share/doc/kbd-${VERSION}
}

_test()
{
	make -j${BUILD_JOBS} check
}
