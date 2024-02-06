NAME="tor"
DESC="The Onion Router"
VERSION="0.4.8.8"
SOURCE="https://dist.torproject.org/tor-${VERSION}.tar.gz"
CHECKSUM="3915a039b0889acd946223d299df0cfd"
DEPS="asciidoctor libseccomp zstd openssl"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	./configure --prefix=/usr --disable-unittests
	make -j${BUILD_JOBS}

	# Create an unprivileged user for tor to use
	if ! grep "tor:" /etc/passwd
	then
		groupadd -g 200 tor
		useradd -c 'tor user' 		\
				-d '/var/lib/tor' 	\
				-g tor 				\
				-s /bin/false 		\
				-u 200 tor 			\
				-m
	fi
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install
}
