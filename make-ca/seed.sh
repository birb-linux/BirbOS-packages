NAME="make-ca"
DESC="Certificate Authority (CA) certitiface store"
VERSION="1.12"
SOURCE="https://github.com/lfs-book/make-ca/releases/download/v${VERSION}/make-ca-${VERSION}.tar.xz"
CHECKSUM="67e0b911e73a859fc326171c5153d455"
DEPS="p11-kit libtasn1"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
	install -vdm755 $FAKEROOT/$NAME/etc/ssl/local
}
