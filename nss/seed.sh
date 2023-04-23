NAME="nss"
DESC="A set of libraries designed to support cross-platform development of security-enabled client and server applications"
VERSION="3.88.1"
SOURCE="https://archive.mozilla.org/pub/security/nss/releases/NSS_$(echo $VERSION | sed 's/\./_/g')_RTM/src/nss-${VERSION}.tar.gz"
CHECKSUM="7ca8ff8ed672d82290c3122f38708579"
DEPS="nspr zlib p11-kit sqlite"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Add some LFS patch
	patch -Np1 -i $PKG_PATH/nss-3.88.1-standalone-1.patch

	cd nss

	make BUILD_OPT=1                  \
	  NSPR_INCLUDE_DIR=/usr/include/nspr  \
	  USE_SYSTEM_ZLIB=1                   \
	  ZLIB_LIBS=-lz                       \
	  NSS_ENABLE_WERROR=0                 \
	  $([ $(uname -m) = x86_64 ] && echo USE_64=1) \
	  $([ -f /usr/include/sqlite3.h ] && echo NSS_USE_SYSTEM_SQLITE=1)
}

_install()
{
	cd ../dist

	install -v -m755 Linux*/lib/*.so              $FAKEROOT/$NAME/usr/lib
	install -v -m644 Linux*/lib/{*.chk,libcrmf.a} $FAKEROOT/$NAME/usr/lib

	install -v -m755 -d                           $FAKEROOT/$NAME/usr/include/nss
	cp -v -RL {public,private}/nss/*              $FAKEROOT/$NAME/usr/include/nss
	chmod -v 644                                  $FAKEROOT/$NAME/usr/include/nss/*

	install -v -m755 Linux*/bin/{certutil,nss-config,pk12util} $FAKEROOT/$NAME/usr/bin
	install -v -m644 Linux*/lib/pkgconfig/nss.pc  $FAKEROOT/$NAME/usr/lib/pkgconfig
}
