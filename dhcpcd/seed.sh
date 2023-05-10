NAME="dhcpcd"
DESC="Implementation of the DHCP client specified in RFC2131"
VERSION="9.4.1"
SOURCE="https://roy.marples.name/downloads/dhcpcd/dhcpcd-${VERSION}.tar.xz"
CHECKSUM="2b2f46648bc96979f96127f0e0e07d9b"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix a runtime error
	sed '/Deny everything else/i SECCOMP_ALLOW(__NR_getrandom),' \
		-i src/privsep-linux.c

	./configure --prefix=$FAKEROOT/$NAME/usr \
            --sysconfdir=/etc            \
            --libexecdir=$FAKEROOT/$NAME/usr/lib/dhcpcd \
            --dbdir=/var/lib/dhcpcd      \
            --runstatedir=/run           \
            --disable-privsep

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	make -j${MAKEOPTS} test
}
