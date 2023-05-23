NAME="uri"
DESC="Perl module implements the URI class"
VERSION="5.17"
SOURCE="https://www.cpan.org/authors/id/O/OA/OALDERS/URI-${VERSION}.tar.gz"
CHECKSUM="63675c429cfb1df73d7d21a9302e1000"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd URI-${VERSION}
}

_build()
{
	perl Makefile.PL
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
