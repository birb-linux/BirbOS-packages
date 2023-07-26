NAME="acpid"
DESC="Daemon for delivering ACPI events"
VERSION="2.0.34"
SOURCE="https://downloads.sourceforge.net/acpid2/acpid-${VERSION}.tar.xz"
CHECKSUM="988c2e3fd5ba0ea4492d3ba7273af295"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --docdir=/usr/share/doc/acpid-${VERSION}
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
