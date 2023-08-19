NAME="gpm"
DESC="General Purpose Mouse daemon, contains a mouse server for the console and xterm"
VERSION="1.20.7"
SOURCE="https://anduin.linuxfromscratch.org/BLFS/gpm/gpm-${VERSION}.tar.bz2"
CHECKSUM="bf84143905a6a903dbd4d4b911a2a2b8"
DEPS=""
FLAGS=""

_setup()
{
	kernel_check "CONFIG_INPUT CONFIG_INPUT_MOUSEDEV"

	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	patch -Np1 -i $PKG_PATH/gpm-1.20.7-consolidated-1.patch

	./autogen.sh
	./configure --prefix=/usr --sysconfdir=/etc

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	install-info --dir-file=/usr/share/info/dir $FAKEROOT/$NAME/usr/share/info/gpm.info

	# Remove a static library
	rm -fv $FAKEROOT/$NAME/usr/lib/libgpm.a

	ln -sfv libgpm.so.2.1.0 $FAKEROOT/$NAME/usr/lib/libgpm.so
	install -v -m644 conf/gpm-root.conf $FAKEROOT/$NAME/etc

	# Install some documentation
	install -v -m755 -d $FAKEROOT/$NAME/usr/share/doc/gpm-${VERSION}/support
	install -v -m644    doc/support/*                     \
						$FAKEROOT/$NAME/usr/share/doc/gpm-${VERSION}/support
	install -v -m644    doc/{FAQ,HACK_GPM,README*}        \
						$FAKEROOT/$NAME/usr/share/doc/gpm-${VERSION}
}
