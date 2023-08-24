NAME="p7zip"
DESC="Unix command-line port of 7-Zip, a file archiver that archives with high compression ratios"
VERSION="17.05"
SOURCE="https://github.com/p7zip-project/p7zip/archive/v${VERSION}/p7zip-${VERSION}.tar.gz"
CHECKSUM="de921a08f37242a8eed8e4a758fbcb58"
DEPS=""
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Don't install compressed manual pages
	sed '/^gzip/d' -i install.sh

	make -j${BUILD_JOBS} all3
}

_install()
{
	make DEST_HOME=/usr 			\
		DEST_MAN=/usr/share/man 	\
		DEST_DIR=$FAKEROOT/$NAME 	\
     	DEST_SHARE_DOC=/usr/share/doc/p7zip-${VERSION} install
}

_test()
{
	make test
}
