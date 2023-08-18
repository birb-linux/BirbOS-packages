NAME="mit-kerberos5"
DESC="Free implementation of Kerberos 5, a network authentication protocol"
VERSION="1.20.1"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://kerberos.org/dist/krb5/${SHORT_VERSION}/krb5-${VERSION}.tar.gz"
CHECKSUM="73f5780e7b587ccd8b8cfc10c965a686"
DEPS="ntp"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd krb5-${VERSION}
}

_build()
{
	cd src &&

	sed -i -e '/eq 0/{N;s/12 //}'    plugins/kdb/db2/libdb2/test/run.test
	sed -i '/t_kadm5.py/d'           lib/kadm5/Makefile.in

	# Make sure LTO is disabled
	export CFLAGS="$CFLAGS -fno-lto"

	./configure --prefix=/usr            \
				--sysconfdir=/etc        \
				--localstatedir=/var/lib \
				--runstatedir=/run       \
				--with-system-et         \
				--with-system-ss         \
				--with-system-verto=no   \
				--enable-dns-for-realm

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	install -v -dm755 $FAKEROOT/$NAME/usr/share/doc/krb5-${VERSION}
	cp -vfr ../doc/*  $FAKEROOT/$NAME/usr/share/doc/krb5-${VERSION}
}
