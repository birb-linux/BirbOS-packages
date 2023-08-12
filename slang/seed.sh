NAME="slang"
DESC="Interpreted language that may be embedded into an application to make the application extensible"
VERSION="2.3.3"
SOURCE="https://www.jedsoft.org/releases/slang/slang-${VERSION}.tar.bz2"
CHECKSUM="69015c8300088373eb65ffcc6ed4db8c"
DEPS="libpng pcre oniguruma"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr \
            --sysconfdir=/etc \
            --with-readline=gnu

	make -j1
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME \
		 install_doc_dir=/usr/share/doc/slang-${VERSION}   \
		 SLSH_DOC_DIR=/usr/share/doc/slang-${VERSION}/slsh \
		 install &&

	chmod -v 755 $FAKEROOT/$NAME/usr/lib/slang/v2/modules/*.so
}

_test()
{
	make check
}
