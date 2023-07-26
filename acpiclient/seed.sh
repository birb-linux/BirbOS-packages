NAME="acpiclient"
DESC="Display information about ACPI devices"
VERSION="1.7"
SOURCE="https://sourceforge.net/projects/acpiclient/files/acpiclient/${VERSION}/acpi-${VERSION}.tar.gz"
CHECKSUM="b52ce4ca39bbf7000a1c2de8879f1dcb"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
