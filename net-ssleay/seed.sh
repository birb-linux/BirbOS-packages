NAME="net-ssleay"
DESC="PERL extension for using OpenSSL"
VERSION="1.92"
SOURCE="https://cpan.metacpan.org/authors/id/C/CH/CHRISN/Net-SSLeay-${VERSION}.tar.gz"
CHECKSUM="9e928bc6f430a874a1a2185f84a0ae88"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd Net-SSLeay-${VERSION}
}

_build()
{
	yes '' | perl Makefile.PL
	make
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME PREFIX=/ install

	# Avoid overwriting any existing perllocal files. The file
	# isn't needed in BirbOS
	rm -v $FAKEROOT/$NAME/usr/lib/perl5/5.36/core_perl/perllocal.pod

	# Move the man files to their correct places
	# and remove the unnecessary nested fakeroot
	mv -v $FAKEROOT/$NAME/$FAKEROOT/perl/usr/share/man/man3 $FAKEROOT/$NAME/usr/share/man/
	rm -rv $FAKEROOT/$NAME/$FAKEROOT/perl
}
