NAME="fcron-bootscript"
DESC="blfs-bootscript for launching fcron during boot"
VERSION="20230101"
SOURCE="https://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-${VERSION}.tar.xz"
CHECKSUM="05d7f58fdcdcd0dcedd81086589222b9"
DEPS="fcron"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd blfs-bootscripts-${VERSION}
}

_build()
{
	printf ""
}

_install()
{
	make DESTDIR=$FAKEROOT/$NAME install-fcron
}

_post_install()
{
	# Start fcron and generate the /var/spool/fcron/systab file
	set +e
	mkdir -p /var/spool/fcron
	/etc/rc.d/init.d/fcron start
	fcrontab -z -u systab
	set -e

	echo "If the command above fails for whatever reason, make sure that"
	echo "fcron starts properly during boot. If not, make sure that fcron"
	echo "was installed correctly"
}
