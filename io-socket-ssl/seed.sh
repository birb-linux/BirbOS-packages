NAME="io-socket-ssl"
DESC="Wrapper interfaces for IO::Socket that provides secure defaults whenever possible"
VERSION="2.081"
SOURCE="https://www.cpan.org/authors/id/S/SU/SULLR/IO-Socket-SSL-${VERSION}.tar.gz"
CHECKSUM="980e8e6816fadd86e875550b1d6ab0a2"
DEPS="make-ca net-ssleay uri"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd IO-Socket-SSL-${VERSION}
}

_build()
{
	yes | perl Makefile.PL
	make
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/ install

	PERL_VERSION="$(perl --version | awk '/version/ {print $9}' | sed 's/[()v]//g' | grep -o "^[0-9]*\.[0-9]*")"

	# Avoid overwriting any existing perllocal files. The file
	# isn't needed in BirbOS
	rm -v $FAKEROOT/$NAME/usr/lib/perl5/${PERL_VERSION}/core_perl/perllocal.pod

	# Move the man files to their correct places
	# and remove the unnecessary nested fakeroot
	mv -v $FAKEROOT/$NAME/$FAKEROOT/perl/usr/share/man/man3 $FAKEROOT/$NAME/usr/share/man/
	rm -rv $FAKEROOT/$NAME/$FAKEROOT/perl
}

_test()
{
	make test
}
