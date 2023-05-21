NAME="efivar"
DESC="Tools and libraries for manipulating EFI variables"
VERSION="38"
SOURCE="https://github.com/rhboot/efivar/releases/download/${VERSION}/efivar-${VERSION}.tar.bz2"
CHECKSUM="243fdbc48440212695cb9c6e6fd0f44f"
DEPS="mandoc"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix an issue in the Makefile that would cause the package
	# to get rebuilt during installation
	sed '/prep :/a\\ttouch prep' -i src/Makefile

	make -j${BUILD_JOBS}
}

_install()
{
	make install DESTDIR=$FAKEROOT/$NAME LIBDIR=/usr/lib
}
