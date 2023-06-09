NAME="ruby"
DESC="Ruby development environment"
VERSION="3.2.1"
SHORT_VERSION="$(echo $VERSION | awk -F'.' '{print $1 "." $2}')"
SOURCE="https://cache.ruby-lang.org/pub/ruby/${SHORT_VERSION}/ruby-${VERSION}.tar.xz"
CHECKSUM="23617540ad13c57ed8dd9d4ed32192a5"
DEPS="libyaml"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr      \
            --enable-shared    \
            --without-valgrind \
            --docdir=/usr/share/doc/ruby-${VERSION}

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Avoid birb takeover with the ruby bin directory
	mkdir -p /usr/lib/ruby/gems/3.2.0/bin
}
