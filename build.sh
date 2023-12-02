TARGET=x86_64-linux-gcc
DIR=/config/build/
set -e
sudo apt-get update
sudo apt-get install autoconf automake autopoint gettext libtool libtool-bin gperf subversion
sudo pip3 install meson
sudo apt-get install build-essential liblzma-dev libnuma-dev libssl-dev
sudo apt-get install libsamplerate-dev make nasm ninja-build patch tar yasm zlib1g-dev appstream
#sudo apt-get install gstreamer1.0-libav libappindicator-dev libdbus-glib-1-dev libglib2.0-dev libgtk-3-dev libnotify-dev
sudo apt-get install libavcodec-dev libva-dev libdrm-dev llvm clang

cd /config/build

git clone https://github.com/GNOME/libxml2.git xml && cd xml
./autogen.sh --without-python --disable-maintainer-mode --disable-shared --enable-static
make
sudo make install && cd $DIR

git clone https://github.com/madler/zlib.git zlib && cd zlib
./configure --static
make
sudo make install && cd $DIR

git clone https://github.com/libarchive/bzip2 bzip && cd bzip
mkdir build && cd build 
meson -Ddefault_library=static --prefix=/usr ..
ninja
sudo ninja install && cd $DIR

git clone https://gitlab.freedesktop.org/fontconfig/fontconfig.git font && cd font
./autogen.sh  --noconf
./configure --disable-docs --enable-libxml2 --enable-iconv --disable-shared --enable-static --sysconfdir=/etc --localstatedir=/var
make
sudo make install && cd $DIR

git clone https://gitlab.freedesktop.org/freetype/freetype free && cd free
sh autogen.sh
#./configure --without-harfbuzz  --disable-shared --enable-static
./configure --disable-shared --enable-static
make
sudo make install && cd $DIR

git clone https://github.com/fribidi/fribidi.git frib && cd frib
mkdir build && cd build
meson --prefix=/usr --buildtype=release --default-library=static -Dbin=false -Ddocs=false -Dtests=false ..
ninja
sudo ninja install && cd $DIR

git clone https://github.com/xiph/ogg.git ogg && cd ogg
./autogen.sh
./configure --disable-shared --enable-static --with-pic
make
sudo make install && cd $DIR

git clone https://github.com/xz-mirror/xz.git xz && cd xz
sh autogen.sh --no-po4a --no-doxygen
./configure --disable-symbol-versions --disable-shared --enable-static --with-pic
make
sudo make install && cd $DIR

git clone https://github.com/harfbuzz/harfbuzz.git buzz && cd buzz
./autogen.sh --disable-shared --enable-static --with-pic
make
sudo make install && cd $DIR

git clone https://github.com/libass/libass.git ass && cd ass
./autogen.sh
./configure --disable-shared --enable-static --with-pic
make
sudo make install && cd $DIR

git clone https://github.com/xiph/vorbis.git vorbis && cd vorbis
./autogen.sh
./configure --disable-shared --enable-static --disable-oggtest
make
sudo make install && cd $DIR

git clone https://github.com/xiph/opus.git opus && cd opus
./autogen.sh
./configure --disable-shared --enable-static --disable-extra-programs
make
sudo make install && cd $DIR

git clone https://github.com/xiph/speex.git speex && cd speex
./autogen.sh
./configure --disable-shared --enable-static
make
sudo make install && cd $DIR


git clone https://github.com/xiph/theora.git theora && cd theora
./autogen.sh
./configure --disable-shared --enable-static --with-pic --disable-examples --disable-oggtest --disable-vorbistest --disable-spec --disable-doc
make
sudo make install && cd $DIR

git clone https://github.com/mstorsjo/fdk-aac.git fdk && cd fdk
./autogen.sh
./configure --disable-shared --enable-static --with-pic --disable-example
make
sudo make install && cd $DIR
echo "cloning into lame"
SCRIPT_REPO="https://svn.code.sf.net/p/lame/svn/trunk/lame"
SCRIPT_REV="6525"
svn checkout "${SCRIPT_REPO}@${SCRIPT_REV}" lame && cd lame
autoreconf -i
./configure --disable-shared --enable-static --enable-nasm --disable-gtktest --disable-cpml --disable-frontend --disable-decoder
make
sudo make install && cd $DIR

git clone https://github.com/mirror/x264.git x264 && cd x264
./configure --disable-cli --enable-static --enable-pic --disable-lavf --disable-swscale
make
sudo make install && cd $DIR

git clone https://github.com/akheron/jansson jsson && cd jsson
autoreconf -i
./configure --enable-static
make
sudo make install && cd $DIR


git clone https://chromium.googlesource.com/webm/libvpx vpx && cd vpx
./configure --disable-shared --enable-static --enable-pic --disable-examples --disable-tools --disable-docs --disable-unit-tests --enable-vp9-highbitdepth --target="$TARGET"
make
sudo make install && cd $DIR

git clone https://github.com/libjpeg-turbo/libjpeg-turbo/ turbo && cd turbo
cmake -G"Unix Makefiles" CMAKE_INSTALL_PREFIX=/usr
make
sudo make install && cd $DIR

