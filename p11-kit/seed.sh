NAME="p11-kit"
DESC="The p11-kit package provides a way to load and enumerate PKCS #11 modules"
VERSION="0.24.1"
SOURCE="https://github.com/p11-glue/p11-kit/releases/download/${VERSION}/p11-kit-${VERSION}.tar.xz"
CHECKSUM="67b2539bdca6b4bedaeecc12864d2796"
DEPS="libtasn1"
FLAGS="test important"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Prepare the distribution specific anchor hook
	sed '20,$ d' -i trust/trust-extract-compat
	cat >> trust/trust-extract-compat << "EOF"
# Copy existing anchor modifications to /etc/ssl/local
/usr/libexec/make-ca/copy-trust-modifications

# Update trust stores
/usr/sbin/make-ca -r
EOF


	mkdir p11-build
	cd    p11-build

	meson setup .. \
		  --prefix=$FAKEROOT/$NAME/usr \
		  --buildtype=release \
		  -Dtrust_paths=/etc/pki/anchors

	ninja
}

_install()
{
	ninja install
	ln -srfv $FAKEROOT/$NAME/usr/libexec/p11-kit/trust-extract-compat \
			$FAKEROOT/$NAME/usr/bin/update-ca-certificates

	# Use p11-kit trust module as a drop-in replacement for libnssckbi.so
	ln -sfv ./pkcs11/p11-kit-trust.so $FAKEROOT/$NAME/usr/lib/libnssckbi.so
}

_test()
{
	ninja test
}
