NAME="fuse"
DESC="FUSE (Filesystem in Userspace) is a simple interface for userspace programs to export a virtual filesystem to the Linux kernel"
VERSION="3.13.1"
SOURCE="https://github.com/libfuse/libfuse/releases/download/fuse-${VERSION}/fuse-${VERSION}.tar.xz"
CHECKSUM="f2830b775bcba2ab9cb94f2619c077a4"
DEPS=""
FLAGS=""

_setup()
{
	kernel_check "CONFIG_FUSE_FS"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	sed -i '/^udev/,$ s/^/#/' util/meson.build

	mkdir build &&
	cd    build &&

	meson --prefix=/usr --buildtype=release ..
	ninja
}

_install()
{
	DESTDIR=$FAKEROOT/$NAME ninja install
	chmod u+s $FAKEROOT/$NAME/usr/bin/fusermount3

	cd ..
	install -v -m755 -d $FAKEROOT/$NAME/usr/share/doc/fuse-${VERSION}
	install -v -m644    doc/{README.NFS,kernel.txt} \
						$FAKEROOT/$NAME/usr/share/doc/fuse-${VERSION}
	cp -Rv doc/html     $FAKEROOT/$NAME/usr/share/doc/fuse-${VERSION}
}
