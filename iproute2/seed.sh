NAME="iproute2"
DESC="IPV4-based networking utilities"
VERSION="6.8.0"
SOURCE="https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-${VERSION}.tar.xz"
CHECKSUM="9d6ea453986900d98e3b6bcb868815cd"
DEPS=""
FLAGS="important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Disable arpd docs
	sed -i /ARPD/d Makefile
	rm -fv man/man8/arpd.8

	make -j${BUILD_JOBS} NETNS_RUN_DIR=/run/netns
}

_install()
{
	make SBINDIR=$FAKEROOT/$NAME/sbin install

	# Install the documentation
	mkdir -pv             $FAKEROOT/$NAME/usr/share/doc/iproute2-${VERSION}
	cp -v COPYING README* $FAKEROOT/$NAME/usr/share/doc/iproute2-${VERSION}
}
