NAME="rsync"
DESC="Utility useful for synchronizing large file archives over a network"
VERSION="3.2.7"
SOURCE="https://www.samba.org/ftp/rsync/src/rsync-${VERSION}.tar.gz"
CHECKSUM="f216f350ef56b9ba61bc313cb6ec2ed6"
DEPS="popt"
FLAGS="test"

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	# Make sure that the rsync daemon runs as an unprivileged user
	groupadd -g 48 rsyncd &&
	useradd -c "rsyncd Daemon" -m -d /home/rsync -g rsyncd \
		-s /bin/false -u 48 rsyncd

	./configure --prefix=/usr \
            --disable-lz4     \
            --disable-xxhash  \
            --without-included-zlib

	make -j${BUILD_JOBS}
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install

	# Install the documentation
	install -v -m755 -d          $FAKEROOT/$NAME/usr/share/doc/rsync-${VERSION}/api
}

_test()
{
	make -j${BUILD_JOBS} check
}
