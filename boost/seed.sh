NAME="boost"
DESC="Set of free peer-reviewed portable C++ source libraries"
VERSION="1.81.0"
ALT_VERSION="$(echo $VERSION | sed 's/\./_/g')"
SOURCE="https://boostorg.jfrog.io/artifactory/main/release/${VERSION}/source/boost_${ALT_VERSION}.tar.bz2"
CHECKSUM="3276c0637d1be8687740c550237ef999"
DEPS="which"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}_${ALT_VERSION}
}

_build()
{
	# Avoid breaking packages that use the phoenix module when compiling with gcc
	sed -i '/#include.*phoenix.*tuple.hpp.*/d' \
		boost/phoenix/stl.hpp

	./bootstrap.sh --prefix=$FAKEROOT/$NAME/usr --with-python=python3
	./b2 stage -j$(nproc) threading=multi link=shared
}

_install()
{
	./b2 install threading=multi link=shared
}
