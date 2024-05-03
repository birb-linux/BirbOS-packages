NAME="openssh"
DESC="SSH clients and the sshd daemon"
VERSION="9.7p1"
SOURCE="https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-${VERSION}.tar.gz"
CHECKSUM="1100f170ca1bc669038ca3743e074094"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	disable_lto

	# Create a separate sshd user and files
	install  -v -m700 -d $FAKEROOT/$NAME/var/lib/sshd
	chown    -v root:sys $FAKEROOT/$NAME/var/lib/sshd

	if [ -z "$(grep "sshd:" /etc/passwd)" ]
	then
		groupadd -g 50 sshd
		useradd  -c 'sshd PrivSep' \
				 -d /var/lib/sshd  \
				 -g sshd           \
				 -s /bin/false     \
				 -u 50 sshd
	fi

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
