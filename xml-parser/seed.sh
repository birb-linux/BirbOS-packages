NAME="xml-parser"
DESC="XML::Parser module is a Perl interface to James Clark's XML parser, Expat"
VERSION="2.46"
SOURCE="https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-${VERSION}.tar.gz"
CHECKSUM="80bb18a8e6240fcf7ec2f7b57601c170"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd XML-Parser-${VERSION}
}

_build()
{
	perl Makefile.PL

	make -j${MAKEOPTS}
}

_install()
{
	make install
}

_test()
{
	make test
}
