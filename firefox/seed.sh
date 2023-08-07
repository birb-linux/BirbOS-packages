NAME="firefox"
DESC="Stand-alone browser based on the Mozilla codebase"
VERSION="102.8.0"
SOURCE="https://archive.mozilla.org/pub/firefox/releases/${VERSION}esr/source/firefox-${VERSION}esr.source.tar.xz"
CHECKSUM="2f65e84943e97f6d56d7b07aa1ded135"
DEPS="autoconf cbindgen dbus-glib gtk+ libnotify llvm nodejs pulseaudio python3 startup-notification unzip yasm zip icu libevent libvpx libwebp nss nspr curl ffmpeg wget pixman zlib libpng"
FLAGS=""

_setup()
{
	tar -xf $DISTFILES/$(basename $SOURCE)
	cd ${NAME}-${VERSION}
}

_build()
{
	disable_lto

	# Configure the build
	cat > mozconfig << "EOF"
# If you have a multicore machine, all cores will be used by default.

# If you have installed (or will install) wireless-tools, and you wish
# to use geolocation web services, comment out this line
ac_add_options --disable-necko-wifi

# API Keys for geolocation APIs - necko-wifi (above) is required for MLS
# Uncomment the following line if you wish to use Mozilla Location Service
#ac_add_options --with-mozilla-api-keyfile=$PWD/mozilla-key

# Uncomment the following line if you wish to use Google's geolocation API
# (needed for use with saved maps with Google Maps)
#ac_add_options --with-google-location-service-api-keyfile=$PWD/google-key

# startup-notification is required since firefox-78

# Uncomment the following option if you have not installed PulseAudio and
# want to use alsa instead
#ac_add_options --enable-audio-backends=alsa

# Comment out following options if you have not installed
# recommended dependencies:
ac_add_options --with-system-icu
ac_add_options --with-system-libevent
ac_add_options --with-system-libvpx
ac_add_options --with-system-nspr
ac_add_options --with-system-nss
ac_add_options --with-system-webp

# Unlike with thunderbird, although using the gold linker can
# save four megabytes in the installed file it does not make
# the build faster.

# libdavid (av1 decoder) requires nasm. Uncomment this if nasm
# has not been installed. Do not uncomment this if you have
# ffmpeg-5 installed.
#ac_add_options --disable-av1

# You cannot distribute the binary if you do this
ac_add_options --enable-official-branding

# Stripping is now enabled by default.
# Uncomment these lines if you need to run a debugger:
#ac_add_options --disable-strip
#ac_add_options --disable-install-strip

# Disabling debug symbols makes the build much smaller and a little
# faster. Comment this if you need to run a debugger. Note: This is
# required for compilation on i686.
ac_add_options --disable-debug-symbols

# The elf-hack is reported to cause failed installs (after successful builds)
# on some machines. It is supposed to improve startup time and it shrinks
# libxul.so by a few MB - comment this if you know your machine is not affected.
ac_add_options --disable-elf-hack

# The BLFS editors recommend not changing anything below this line:
ac_add_options --prefix=<fakeroot>
ac_add_options --enable-application=browser
ac_add_options --disable-crashreporter
ac_add_options --disable-updater
# enabling the tests will use a lot more space and significantly
# increase the build time, for no obvious benefit.
ac_add_options --disable-tests

# The default level of optimization again produces a working build with gcc.
ac_add_options --enable-optimize

ac_add_options --enable-system-ffi
ac_add_options --enable-system-pixman

ac_add_options --with-system-jpeg
ac_add_options --with-system-png
ac_add_options --with-system-zlib

# Using sandboxed wasm libraries has been moved to all builds instead
# of only mozilla automation builds. It requires extra llvm packages
# and was reported to seriously slow the build. Disable it.
ac_add_options --without-wasm-sandboxed-libraries

# The following option unsets Telemetry Reporting. With the Addons Fiasco,
# Mozilla was found to be collecting user's data, including saved passwords and
# web form data, without users consent. Mozilla was also found shipping updates
# to systems without the user's knowledge or permission.
# As a result of this, use the following command to permanently disable
# telemetry reporting in Firefox.
unset MOZ_TELEMETRY_REPORTING

mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/firefox-build-dir
EOF

	sed -i "s|<fakeroot>|$FAKEROOT/$NAME/usr|" mozconfig

	# Fix an issue with cbindgen
	sed -i '/ROOT_CLIP_CHAIN/d' gfx/webrender_bindings/webrender_ffi.h

	# Make sure that /dev/shm is mounted
	mountpoint -q /dev/shm || mount -t tmpfs devshm /dev/shm

	# Start compiling
	export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=none
	export MOZBUILD_STATE_PATH=${PWD}/mozbuild
	./mach configure
	./mach build
}

_install()
{
	MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=none ./mach install

	# Clear the env variables
	unset MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE MOZBUILD_STATE_PATH

	# Fix a symbolic link
	rm $FAKEROOT/$NAME/usr/bin/firefox
	ln -srv $FAKEROOT/$NAME/usr/lib/firefox/firefox $FAKEROOT/$NAME/usr/bin/firefox
}
