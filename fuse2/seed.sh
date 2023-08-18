NAME="fuse2"
DESC="Old legacy FUSE libraries/programs needed for AppImage support"
VERSION="2.9.9"
SOURCE="https://github.com/libfuse/libfuse/releases/download/fuse-${VERSION}/fuse-${VERSION}.tar.gz"
CHECKSUM="8000410aadc9231fd48495f7642f3312"
DEPS="fuse"
FLAGS=""

_setup()
{
	kernel_check "CONFIG_FUSE_FS"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd fuse-${VERSION}
}

_build()
{
	# Apply a patch that should fix a bug related to glibc
	patch -Np1 -i $PKG_PATH/glibc_bug_fix.patch

	# Use a newer version of aclocal
	ACLOCAL_VERSION="$(aclocal --version | head -n1 | awk '{print $4}' | awk -F'.' '{print $1 "." $2}')"
	sed -i "s/am__api_version='1.15'/am__api_version='$ACLOCAL_VERSION'/" ./configure

	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	# Install libfuse
	install -v -m755 ./lib/.libs/libfuse.so.${VERSION} $FAKEROOT/$NAME/usr/lib
	ln -sfr $FAKEROOT/$NAME/usr/lib/libfuse.so.${VERSION} $FAKEROOT/$NAME/usr/lib/libfuse.so.2

	# Set setuid bit to fusermount so that it works with AppImages
	chmod u+s ./util/fusermount

	# Install fusermount
	cp -v ./util/fusermount $FAKEROOT/$NAME/usr/bin/
}
