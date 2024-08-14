NAME="iana-etc"
DESC="iana-etc provides data for network services and protocols"
VERSION="20240412"
SOURCE="https://github.com/Mic92/iana-etc/releases/download/${VERSION}/iana-etc-${VERSION}.tar.gz"
CHECKSUM="d53e2729bb4f3ef9f5cdc23a4bbb6739"
DEPS=""
FLAGS="important"

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
	# We only need to copy the files into place
	cp services protocols $FAKEROOT/$NAME/etc
}
