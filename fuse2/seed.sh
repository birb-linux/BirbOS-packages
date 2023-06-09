NAME="fuse2"
DESC="FUSE (Filesystem in Userspace) is a simple interface for userspace programs to export a virtual filesystem to the Linux kernel"
VERSION="2.9.8"
SOURCE="https://github.com/libfuse/libfuse/releases/download/fuse-${VERSION}/fuse-${VERSION}.tar.gz"
CHECKSUM="f365e848a82504edb0b7a33df790ca78"
DEPS=""
FLAGS=""

_setup()
{
	kernel_check "CONFIG_FUSE_FS"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd fuse-${VERSION}
}

_build()
{
	mkdir build &&
	cd    build &&

	../configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
	chmod u+s $FAKEROOT/$NAME/usr/bin/fusermount3

	cd ..
	install -v -m755 -d $FAKEROOT/$NAME/usr/share/doc/fuse-${VERSION}
	install -v -m644    doc/{README.NFS,kernel.txt} \
						$FAKEROOT/$NAME/usr/share/doc/fuse-${VERSION}
	cp -Rv doc/html     $FAKEROOT/$NAME/usr/share/doc/fuse-${VERSION}
}
