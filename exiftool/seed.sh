NAME="exiftool"
DESC="Read, Write and Edit Meta Information in images, videos and other media"
VERSION="12.64"
SOURCE="https://exiftool.org/Image-ExifTool-${VERSION}.tar.gz"
CHECKSUM="09a45b9bfe4e1686a8e9437f19edc8d4"
DEPS="perl zlib libzip"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd Image-ExifTool-${VERSION}
}

_build()
{
	perl Makefile.PL
	make prefix=/usr
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME prefix=/usr install

	# Remove the perllocal file to avoid overwriting
	# the system file
	PERL_VERSION="$(birb_pkg_search perl | cut -d';' -f2 | awk -F'.' '{print $1 "." $2}')"
	rm $FAKEROOT/$NAME/usr/lib/perl5/$PERL_VERSION/core_perl/perllocal.pod

	# Move the directories to their correct places in the fakeroot
	mv -v $FAKEROOT/$NAME/$FAKEROOT/perl/usr/bin $FAKEROOT/$NAME/usr/
	mv -v $FAKEROOT/$NAME/$FAKEROOT/perl/usr/share/man/man1/* $FAKEROOT/$NAME/usr/share/man/man1/
	mv -v $FAKEROOT/$NAME/$FAKEROOT/perl/usr/share/man/man3/* $FAKEROOT/$NAME/usr/share/man/man3/
	rm -rv $FAKEROOT/$NAME/$FAKEROOT
}
