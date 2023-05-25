NAME="iso-codes"
DESC="A list of country, language and currency names and it is used as a central database for accessing this data"
VERSION="4.15.0"
SOURCE="http://ftp.debian.org/debian/pool/main/i/iso-codes/iso-codes_${VERSION}.orig.tar.xz"
CHECKSUM="e7f0063a5e3f6426ac55c4726e7dd3a1"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr
	make -j${BUILD_JOBS}
}

_install()
{
	# Update symlinks if reinstalling the package
	if [ -f /usr/share/iso-codes ]
	then
		sed -i '/^LN_S/s/s/sfvn/' */Makefile
	fi

	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} check
}
