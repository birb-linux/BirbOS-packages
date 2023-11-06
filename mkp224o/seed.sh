NAME="mkp224o"
DESC="Vanity address generator for tor onion v3 (ed25519) hidden services"
VERSION="1.6.1"
SOURCE="https://github.com/cathugger/mkp224o/releases/download/v${VERSION}/mkp224o-${VERSION}-src.tar.gz"
CHECKSUM="8f10237a04140106440c3e4173268aa1"
DEPS="libsodium"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --enable-amd64-51-30k --enable-intfilter=64
	make -j${BUILD_JOBS}
}

_install()
{
	install -v -m755 mkp224o $FAKEROOT/$NAME/usr/bin
}
