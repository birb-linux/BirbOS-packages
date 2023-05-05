NAME="procps-ng"
DESC="Programs for monitoring processes"
VERSION="4.0.3"
SOURCE="https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-${VERSION}.tar.xz"
CHECKSUM="22b287bcd758831cbaf3356cd3054fe7"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr \
            --docdir=$FAKEROOT/$NAME/usr/share/doc/procps-ng-${VERSION} \
            --disable-static \
            --disable-kill

	make -j$(nproc)
}

_install()
{
	make install
}

_test()
{
	# Some tests are known to fail
	set +e
	make check
	set -e
}
