NAME="libcap"
DESC="Userspace interface to the POSIX 1003.1e capabilities in Linux kernels (root privilege stuff)"
VERSION="2.68"
SOURCE="https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-${VERSION}.tar.xz"
CHECKSUM="ffb9e9c87704f92ac75201327841e753"
DEPS=""
FLAGS="32bit test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Prevent static libraries from being installed
	sed -i '/install -m.*STA/d' libcap/Makefile

	make -j${BUILD_JOBS} prefix=$FAKEROOT/$NAME/usr lib=lib
}

_install()
{
	make prefix=$FAKEROOT/$NAME/usr lib=lib install
}

# If the package has any tests, run them here
# To enable this function, specify the 'test' flag
#
# Also, birb needs to be run with special arguments to run tests
# when installing packages
_test()
{
	make -j${BUILD_JOBS} test
}

# These 32 bit functions get called only if the '32bit' flag is set
# Otherwise they are optional
_build32()
{
	make distclean

	make -j${BUILD_JOBS} CC="gcc -m32 -march=i686"
}

_install32()
{
	make CC="gcc -m32 -march=i686" lib=lib32 prefix=$PWD/DESTDIR/usr -C libcap install
	cp -Rv DESTDIR/usr/lib32/* $FAKEROOT/$NAME/usr/lib32
	sed -e "s|^libdir=.*|libdir=/usr/lib32|" -i $FAKEROOT/$NAME/usr/lib32/pkgconfig/lib{cap,psx}.pc
	chmod -v 755 $FAKEROOT/$NAME/usr/lib32/libcap.so.${VERSION}
	rm -rf DESTDIR
}
