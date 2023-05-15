NAME="libtirpc"
DESC="Libraries that support programs that use the Remote Procedure Call (RPC) API"
VERSION="1.3.3"
SOURCE="https://downloads.sourceforge.net/libtirpc/libtirpc-${VERSION}.tar.bz2"
CHECKSUM="bacdad5c27dcf6e2830b3e26a1c8ed3f"
DEPS=""
FLAGS=""

# TODO: When updating this package, remember to also update rpcbind

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --sysconfdir=/etc \
            --disable-static  \
            --disable-gssapi

	make -j${MAKEOPTS}
}

_install()
{
	make install
}
