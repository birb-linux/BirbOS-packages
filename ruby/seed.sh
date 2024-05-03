NAME="ruby"
DESC="Ruby development environment"
VERSION="3.2.4"
SHORT_VERSION="$(short_version $VERSION)"
SOURCE="https://cache.ruby-lang.org/pub/ruby/${SHORT_VERSION}/ruby-${VERSION}.tar.xz"
CHECKSUM="7be29bd10b8e530d7117e57fb1c346be"
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
