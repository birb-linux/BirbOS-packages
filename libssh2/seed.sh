NAME="libssh2"
DESC="Client-side C library implementing the SSH2 protocol"
VERSION="1.11.0"
SOURCE="https://www.libssh2.org/download/libssh2-${VERSION}.tar.gz"
CHECKSUM="a01d543fd891ca48fe47726540d50b17"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Fix an incompatibility issue with recent OpenSSH versions
	patch -Np1 -i $PKG_PATH/libssh2-1.11.0-security_fixes-1.patch

	./configure --prefix=$FAKEROOT/$NAME/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
