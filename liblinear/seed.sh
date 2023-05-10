NAME="liblinear"
DESC="Library for learning linear classifiers for large scale applications"
VERSION="245"
SOURCE="https://github.com/cjlin1/liblinear/archive/v${VERSION}/liblinear-${VERSION}.tar.gz"
CHECKSUM="6838c3414b9b685c12395f0b74806934"
DEPS=""
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	make -j${MAKEOPTS} lib
}

_install()
{
	install -vm644 linear.h $FAKEROOT/$NAME/usr/include/linear.h
	install -vm755 liblinear.so.5 $FAKEROOT/$NAME/usr/lib
	ln -sfv liblinear.so.5 $FAKEROOT/$NAME/usr/lib/liblinear.so
}
