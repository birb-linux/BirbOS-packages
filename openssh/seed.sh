NAME="openssh"
DESC="SSH clients and the sshd daemon"
VERSION="9.2p1"
SOURCE="https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${VERSION}.tar.gz"
CHECKSUM="f78b2acac4bb299629a8c58ddc3fac63"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Create a separate sshd user and files
	install  -v -m700 -d $FAKEROOT/$NAME/var/lib/sshd
	chown    -v root:sys $FAKEROOT/$NAME/var/lib/sshd

	groupadd -g 50 sshd
	useradd  -c 'sshd PrivSep' \
			 -d /var/lib/sshd  \
			 -g sshd           \
			 -s /bin/false     \
			 -u 50 sshd

	./configure --prefix=$FAKEROOT/$NAME/usr         \
            --sysconfdir=/etc/ssh                    \
            --with-privsep-path=/var/lib/sshd        \
            --with-default-path=/usr/bin             \
            --with-superuser-path=/usr/sbin:/usr/bin \
            --with-pid-dir=/run

	make -j${BUILD_JOBS}
}

_install()
{
	make install
	install -v -m755    contrib/ssh-copy-id $FAKEROOT/$NAME/usr/bin

	install -v -m644    contrib/ssh-copy-id.1 \
						$FAKEROOT/$NAME/usr/share/man/man1
	install -v -m755 -d $FAKEROOT/$NAME/usr/share/doc/openssh-${VERSION}
	install -v -m644    INSTALL LICENCE OVERVIEW README* \
						$FAKEROOT/$NAME/usr/share/doc/openssh-${VERSION}
}
