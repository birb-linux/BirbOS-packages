NAME="bash"
DESC="Bourne-Again Shell"
VERSION="5.2.15"
SOURCE="https://ftp.gnu.org/gnu/bash/bash-${VERSION}.tar.gz"
CHECKSUM="4281bb43497f3905a308430a8d6a30a5"
DEPS="readline"
FLAGS="test"

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

	make -j$(nproc)
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
