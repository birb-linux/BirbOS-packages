NAME="gpm-bootscript"
DESC="blfs-bootscript for launching gpm during startup"
VERSION="20230101"
SOURCE="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-${VERSION}.tar.xz"
CHECKSUM="05d7f58fdcdcd0dcedd81086589222b9"
DEPS="gpm"
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
	make DESTDIR=$FAKEROOT/$NAME install-gpm
}
