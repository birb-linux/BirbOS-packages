NAME="eudev"
DESC="Programs for dynamic creationg of device nodes"
VERSION="3.2.11"
SOURCE="https://github.com/eudev-project/eudev/releases/download/v${VERSION}/eudev-${VERSION}.tar.gz"
CHECKSUM="417ba948335736d4d81874fba47a30f7"
DEPS=""
FLAGS="test"
#FLAGS="test 32bit"

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
            --bindir=$FAKEROOT/$NAME/usr/sbin \
            --sysconfdir=/etc       \
            --enable-manpages       \
            --disable-static

	make -j$(nproc)

	# Create some directories that are needed for tests (and for the installation)
	mkdir -pv $FAKEROOT/$NAME/usr/lib/udev/rules.d
	mkdir -pv $FAKEROOT/$NAME/etc/udev/rules.d
}

_install()
{
	make install
}

_test()
{
	make -j$(nproc) check
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
#_build32()
#{
#	make distclean
#
#	CC="gcc -m32" \
#	./configure --host=i686-pc-linux-gnu       \
#				--prefix=$FAKEROOT/$NAME/usr   \
#				--bindir=$FAKEROOT/$NAME/usr/sbin \
#				--libdir=/usr/lib32            \
#				--sysconfdir=/etc              \
#				--disable-manpages             \
#				--disable-static
#
#	make -j$(nproc)
#}
#
#_install32()
#{
#	make DESTDIR=$PWD/DESTDIR install
#	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
#	rm -rf DESTDIR
#}
