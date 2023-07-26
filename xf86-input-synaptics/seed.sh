NAME="xf86-input-synaptics"
DESC="SDK for Synaptics touchpads, Xorg input Driver and support programs"
VERSION="1.9.2"
SOURCE="https://www.x.org/pub/individual/driver/xf86-input-synaptics-${VERSION}.tar.xz"
CHECKSUM="3b95e7baf4428b114e9910f999e96601"
DEPS="libevdev xorg-server"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --sysconfdir=/etc \
		--localstatedir=/var --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
