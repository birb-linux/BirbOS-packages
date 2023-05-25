NAME="bash-completion"
DESC="Programmable completion functions for bash"
VERSION="2.11"
SOURCE="https://github.com/scop/bash-completion/releases/download/${VERSION}/bash-completion-${VERSION}.tar.xz"
CHECKSUM="2514c6772d0de6254758b98c53f91861"
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
	DESTDIR=$FAKEROOT/$NAME make install

	# Move the profile.d script to the correct place
	mv $FAKEROOT/$NAME/usr/etc/profile.d $FAKEROOT/$NAME/etc/
}

_test()
{
	make -j${BUILD_JOBS} check
}
