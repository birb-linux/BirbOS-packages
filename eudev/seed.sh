NAME="eudev"
DESC="Programs for dynamic creationg of device nodes"
VERSION="3.2.11"
SOURCE="https://github.com/eudev-project/eudev/releases/download/v${VERSION}/eudev-${VERSION}.tar.gz"
CHECKSUM="417ba948335736d4d81874fba47a30f7"
DEPS=""
FLAGS="test"
FLAGS="test 32bit"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix the location of udev rules in the .pc file
	sed -i '/udevdir/a udev_dir=${udevdir}' src/udev/udev.pc.in

	./configure --prefix=$FAKEROOT/$NAME/usr \
            --bindir=$FAKEROOT/$NAME/sbin \
            --sysconfdir=/etc       \
            --enable-manpages       \
            --disable-static

	make -j${MAKEOPTS}

	# Create some directories that are needed for tests (and for the installation)
	mkdir -pv $FAKEROOT/$NAME/usr/lib/udev/rules.d
	mkdir -pv $FAKEROOT/$NAME/etc/udev/rules.d
}

_install()
{
	make install

	# Fix a symlink
	ln -srfv $FAKEROOT/$NAME/sbin/udevadm $FAKEROOT/$NAME/usr/sbin/udevadm

	# Add symlink for /sbin/udevd
	ln -srfv $FAKEROOT/$NAME/usr/sbin/udevd $FAKEROOT/$NAME/sbin/udevd
}

_test()
{
	make -j${MAKEOPTS} check
}

_build32()
{
	make distclean

	LDFLAGS="-L/usr/lib32" CC="gcc -m32" \
	./configure --host=i686-pc-linux-gnu       \
				--prefix=$FAKEROOT/$NAME/usr   \
				--bindir=$FAKEROOT/$NAME/usr/sbin \
				--libdir=/usr/lib32            \
				--sysconfdir=/etc              \
				--disable-manpages             \
				--disable-static

	make -j${MAKEOPTS}
}

_install32()
{
	make DESTDIR=$PWD/DESTDIR install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	rm -rf DESTDIR
}
