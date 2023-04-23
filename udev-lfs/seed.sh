NAME="udev-lfs"
DESC="Custom udev rules and support files useful in an LFS environment"
VERSION="20171102"
SOURCE="https://anduin.linuxfromscratch.org/LFS/udev-lfs-${VERSION}.tar.xz"
CHECKSUM="27cd82f9a61422e186b9d6759ddf1634"
DEPS="eudev"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)

	# The makefile assumes that we are not in the directory
	#cd ${NAME}-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME -f ./${NAME}-${VERSION}/Makefile.lfs install
}
