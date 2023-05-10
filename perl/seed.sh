NAME="perl"
DESC="Practical Extraction and Reporting Language"
VERSION="5.36.0"
MAJOR_VERSION="5.36"
SOURCE="https://www.cpan.org/src/5.0/perl-${VERSION}.tar.xz"
CHECKSUM="826e42da130011699172fd655e49cfa2"
DEPS="zlib"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Use the system installation of zlib
	export BUILD_ZLIB=False
	export BUILD_BZIP2=0

	sh Configure -des \
             -Dprefix=$FAKEROOT/$NAME/usr \
             -Dvendorprefix=/usr \
             -Dprivlib=/usr/lib/perl5/${MAJOR_VERSION}/core_perl      \
             -Darchlib=/usr/lib/perl5/${MAJOR_VERSION}/core_perl      \
             -Dsitelib=/usr/lib/perl5/${MAJOR_VERSION}/site_perl      \
             -Dsitearch=/usr/lib/perl5/${MAJOR_VERSION}/site_perl     \
             -Dvendorlib=/usr/lib/perl5/${MAJOR_VERSION}/vendor_perl  \
             -Dvendorarch=/usr/lib/perl5/${MAJOR_VERSION}/vendor_perl \
             -Dman1dir=$FAKEROOT/$NAME/usr/share/man/man1                \
             -Dman3dir=$FAKEROOT/$NAME/usr/share/man/man3                \
             -Dpager="/usr/bin/less -isR"                 \
             -Duseshrplib                                 \
             -Dusethreads

	make -j${MAKEOPTS}
}

_install()
{
	make install
	unset BUILD_ZLIB BUILD_BZIP2

	# Manually symlink the perl binary to avoid breaking stow
	# Without stow, birb won't be able to finish installing this packge
	echo "Manually overwriting the old perl binary to avoid breaking stow"
	ln -srfv $FAKEROOT/$NAME/usr/bin/perl /usr/bin/perl
}

_test()
{
	make -j${MAKEOPTS} test
}
