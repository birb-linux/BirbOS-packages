NAME="pandoc"
DESC="Universal markup converter"
VERSION="3.1.8"
SOURCE="https://github.com/jgm/pandoc/releases/download/${VERSION}/pandoc-${VERSION}-linux-amd64.tar.gz"
CHECKSUM="07f8f3ba332aee9efba933a3f3fd5f15"
DEPS=""
FLAGS="proprietary"

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
	# Remove the existing fakeroot /usr directory contents
	rm -r "${FAKEROOT:?}/$NAME"/usr/*

	mv ./* $FAKEROOT/$NAME/usr/
}
