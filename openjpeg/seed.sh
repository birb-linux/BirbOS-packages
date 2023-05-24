NAME="openjpeg"
DESC="Open-source implementation of the JPEG-2000 standard"
VERSION="2.5.0"
SOURCE="https://github.com/uclouvain/openjpeg/archive/v${VERSION}/openjpeg-${VERSION}.tar.gz"
CHECKSUM="5cbb822a1203dd75b85639da4f4ecaab"
DEPS="cmake"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	mkdir -v build
	cd       build

	cmake -DCMAKE_BUILD_TYPE=Release \
		  -DCMAKE_INSTALL_PREFIX=/usr \
		  -DBUILD_STATIC_LIBS=OFF ..

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	pushd ../doc &&
	  for man in man/man?/* ; do
		  install -v -D -m 644 $man $FAKEROOT/$NAME/usr/share/$man
	  done
	popd
}
