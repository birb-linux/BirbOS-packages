NAME="e2fsprogs"
DESC="Utilities for handling ext filesystems"
VERSION="1.47.0"
SOURCE="https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v${VERSION}/e2fsprogs-${VERSION}.tar.gz"
CHECKSUM="6b4f18a33873623041857b4963641ee9"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir -v build
	cd       build

	../configure --prefix=$FAKEROOT/$NAME/usr \
             --sysconfdir=/etc       \
             --enable-elf-shlibs     \
             --disable-libblkid      \
             --disable-libuuid       \
             --disable-uuidd         \
             --disable-fsck

	make -j$(nproc)
}

_install()
{
	make install

	# Remove static libraries
	rm -fv $FAKEROOT/$NAME/usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
}

_test()
{
	make check
}
