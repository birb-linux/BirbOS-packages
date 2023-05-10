NAME="dbus-daemon"
DESC="blfs-bootscript for launching dbus during boot"
VERSION="20230101"
SOURCE="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-${VERSION}.tar.xz"
CHECKSUM="05d7f58fdcdcd0dcedd81086589222b9"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd blfs-bootscripts-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install-dbus
}
