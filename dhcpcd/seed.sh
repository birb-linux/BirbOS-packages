NAME="dhcpcd"
DESC="Implementation of the DHCP client specified in RFC2131"
VERSION="10.0.1"
SOURCE="https://github.com/NetworkConfiguration/dhcpcd/releases/download/v${VERSION}/dhcpcd-${VERSION}.tar.xz"
CHECKSUM="002d3c7bfa057248f23b2b2f33f02f5a"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
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
