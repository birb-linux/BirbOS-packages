NAME="mandoc"
DESC="Utility for formatting manual pages"
VERSION="1.14.6"
SOURCE="https://mandoc.bsd.lv/snapshots/mandoc-${VERSION}.tar.gz"
CHECKSUM="f0adf24e8fdef5f3e332191f653e422a"
DEPS=""
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure

	# Only build the mandoc command to avoid conflicts
	make mandoc
}

_install()
{
	install -vm755 mandoc   $FAKEROOT/$NAME/usr/bin
	install -vm644 mandoc.1 $FAKEROOT/$NAME/usr/share/man/man1
}

_test()
{
	make regress
}
