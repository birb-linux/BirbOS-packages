NAME="bash"
DESC="Bourne-Again Shell"
VERSION="5.2.21"
SOURCE="https://ftp.gnu.org/gnu/bash/bash-${VERSION}.tar.gz"
CHECKSUM="ad5b38410e3bf0e9bcc20e2765f5e3f9"
DEPS="readline"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr             \
            --without-bash-malloc     \
            --with-installed-readline \
            --docdir=/usr/share/doc/bash-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}

_test()
{
	chown -Rv tester .
	su -s /usr/bin/expect tester << EOF
set timeout -1
spawn make tests
expect eof
lassign [wait] _ _ _ value
exit $value
EOF
}
