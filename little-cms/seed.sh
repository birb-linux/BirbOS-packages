NAME="little-cms"
DESC="A small-footprint color management engine, with special focus on accuracy and performance"
VERSION="2.14"
MAJOR_VERSION="$(echo $VERSION | cut -d'.' -f1)"
SOURCE="https://github.com/mm2/Little-CMS/releases/download/lcms${VERSION}/lcms${MAJOR_VERSION}-${VERSION}.tar.gz"
CHECKSUM="7f7baa3e605c961b9301135105ee9a34"
DEPS="libjpeg-turbo libtiff"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd lcms${MAJOR_VERSION}-${VERSION}
}

_build()
{
	# Apply an upstream fix that avoids an issue that breaks colord
	sed '/BufferSize < TagSize/,+1 s/goto Error/TagSize = BufferSize/' \
		-i src/cmsio0.c

	./configure --prefix=/usr --disable-static
	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}

_test()
{
	make -j${BUILD_JOBS} check
}
