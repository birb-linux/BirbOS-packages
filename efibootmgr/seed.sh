NAME="efibootmgr"
DESC="Tools and libraries for manipulating EFI variables"
VERSION="18"
SOURCE="https://github.com/rhboot/efibootmgr/archive/${VERSION}/efibootmgr-${VERSION}.tar.gz"
CHECKSUM="e170147da25e1d5f72721ffc46fe4e06"
DEPS="efivar popt"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${BUILD_JOBS} EFIDIR=BIRBOS EFI_LOADER=grubx64.efi
}

_install()
{
	make install DESTDIR=$FAKEROOT/$NAME EFIDIR=BIRBOS
}
