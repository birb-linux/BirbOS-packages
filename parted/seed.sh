NAME="parted"
DESC="Disk partitioning and partition resizing tool"
VERSION="3.6"
SOURCE="https://ftp.gnu.org/gnu/parted/parted-${VERSION}.tar.xz"
CHECKSUM="93d2d8f22baebc5eb65b85da05a79e4e"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# TODO: Get rid of the --disable-device-mapper option here when LVM2 has been packaged
	./configure --prefix=/usr --disable-device-mapper --disable-static
	make -j${BUILD_JOBS}

	make -C doc html
	makeinfo --html      -o doc/html       doc/parted.texi
	makeinfo --plaintext -o doc/parted.txt doc/parted.texi
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	install -v -m755 -d $FAKEROOT/$NAME/usr/share/doc/parted-${VERSION}/html
	install -v -m644    doc/html/* \
						$FAKEROOT/$NAME/usr/share/doc/parted-${VERSION}/html
	install -v -m644    doc/{FAT,API,parted.{txt,html}} \
						$FAKEROOT/$NAME/usr/share/doc/parted-${VERSION}
}
