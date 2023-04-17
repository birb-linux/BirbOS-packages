NAME="iana-etc"
DESC="iana-etc provides data for network services and protocols"
VERSION="20230405"
SOURCE="https://github.com/Mic92/iana-etc/releases/download/${VERSION}/iana-etc-${VERSION}.tar.gz"
CHECKSUM="c8931836fa045c98b3a4eefdd911d54c"
DEPS=""
FLAGS=""

_setup()
{
	tar -xvf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	# We only need to copy the files into place
	cp services protocols $FAKEROOT/etc
}

_cleanup()
{
	rm -rv "$DISTFILES/iana-etc-${VERSION}"
}
