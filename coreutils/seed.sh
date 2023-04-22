NAME="coreutils"
DESC="Basic utility programs needed by every operating system"
VERSION="9.2"
SOURCE="https://ftp.gnu.org/gnu/coreutils/coreutils-${VERSION}.tar.xz"
CHECKSUM="4a8a5097d8d7315ccfd6be7eafc8c862"
DEPS=""
FLAGS="important test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix a bug in checksum utilities causing failed checks not reported correctly
	sed '/if ( ! match/s/ed_checksums//' -i src/digest.c

	autoreconf -fiv
	FORCE_UNSAFE_CONFIGURE=1 ./configure \
				--prefix=$FAKEROOT/$NAME/usr \
				--enable-no-install-program=kill,uptime

	make -j$(nproc)
}

_install()
{
	make install

	# Move programs to their correct locations
	mv -v $FAKEROOT/$NAME/usr/bin/chroot $FAKEROOT/$NAME/usr/sbin
	mv -v $FAKEROOT/$NAME/usr/share/man/man1/chroot.1 $FAKEROOT/$NAME/usr/share/man/man8/chroot.8
	sed -i 's/"1"/"8"/' $FAKEROOT/$NAME/usr/share/man/man8/chroot.8

	# Copy a few coreutils to /usr/local/bin to avoid breaking the system
	# during the installation
	cp -v /bin/{rm,ls,ln,env,cut} /usr/local/bin/
}

_test()
{
	make NON_ROOT_USERNAME=tester check-root

	# Create a dummy group needed for the non-root tests
	echo "dummy:x:102:tester" >> /etc/group
	chown -Rv tester .

	# One test might fail in the chroot env, so don't quit on errors
	set +e
	su tester -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check"
	set -e

	# Remove the temporary group
	sed -i '/dummy/d' /etc/group
}
