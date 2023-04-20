NAME="less"
DESC="Text file viewer / pager"
VERSION="608"
SOURCE="https://www.greenwoodsoftware.com/less/less-${VERSION}.tar.gz"
CHECKSUM="1cdec714569d830a68f4cff11203cdba"
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

	make -j$(nproc)
}

_install()
{
	make install
}
