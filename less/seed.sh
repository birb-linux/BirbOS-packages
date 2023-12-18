NAME="less"
DESC="Text file viewer / pager"
VERSION="643"
SOURCE="https://www.greenwoodsoftware.com/less/less-${VERSION}.tar.gz"
CHECKSUM="cf05e2546a3729492b944b4874dd43dd"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=$FAKEROOT/$NAME/usr --sysconfdir=/etc

	make -j${BUILD_JOBS}
}

_install()
{
	make install
}
