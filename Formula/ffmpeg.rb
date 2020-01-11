class Ffmpeg < Formula
  desc "Play, record, convert, and stream audio and video"
  head "https://git.ffmpeg.org/ffmpeg.git"
  homepage "https://ffmpeg.org/"
  mirror "https://github.com/FFmpeg/FFmpeg.git"

  stable do
    url "https://ffmpeg.org/releases/ffmpeg-4.2.2.tar.xz"
    sha256 "cb754255ab0ee2ea5f66f8850e1bd6ad5cac1cd855d0a2f4990fb8c668b0d29c"
    version "4.2.2"
  end

  devel do
    url "https://github.com/FFmpeg/FFmpeg/archive/n4.3-dev.tar.gz"
    sha256 "253dd6a1922ed28533e402818f0eea5ed6b4fef22e9b7056c47fe0ad09fee3b4"
    version "4.3.0"

  end

  bottle do
    root_url "https://dl.bintray.com/sanghan/bottles-packages"
    rebuild 2
    sha256 "708f576e3a3eab10a90588ad8d6eae14e7905f772889513d0f9d96c6b66c06d2" => :mojave
  end

  unless OS.mac?
    option "with-librsvg", "Enable SVG files as inputs via librsvg"
  end

  option "with-chromaprint", "Enable the Chromaprint audio fingerprinting library"
  option "with-dav1d", "Enable AV1 decoding via libdav1d"
  option "with-decklinksdk", "Enable DeckLink support"
  option "with-fdk-aac", "Enable the Fraunhofer FDK AAC library"
  option "with-game-music-emu", "Enable Game Music Emu via libgme"
  option "with-gmp", "Enable gmp, needed for rtmp(t)e support if openssl or librtmp is not used"
  option "with-kvazaar", "Enable HEVC encoding via libkvazaar"
  option "with-libbluray", "Enable BluRay reading using libbluray"
  option "with-libbs2b", "Enable bs2b DSP library"
  option "with-libcaca", "Enable textual display using libcaca"
  option "with-libgcrypt", "Enable gcrypt, needed for rtmp(t)e support if openssl, librtmp or gmp is not used"
  option "with-libgsm", "Enable GSM de/encoding via libgsm"
  option "with-libmodplug", "Enable ModPlug via libmodplug"
  option "with-libsoxr", "Enable the soxr resample library"
  option "with-libssh", "Enable SFTP protocol via libssh"
  option "with-libvidstab", "Enable vid.stab support for video stabilization"
  option "with-libvmaf", "Enable libvmaf scoring library"
  option "with-libxml2", "Enable XML parsing using the C library libxml2, needed for dash demuxing support"
  option "with-opencore-amr", "Enable Opencore AMR format"
  option "with-openh264", "Enable H.264 encoding via OpenH264"
  option "with-openjpeg", "Enable JPEG 2000 de/encoding via OpenJPEG"
  option "with-rubberband", "Enable rubberband needed for rubberband filter"
  option "with-speex", "Enable Speex de/encoding via libspeex"
  option "with-srt", "Enable Haivision SRT protocol via libsrt"
  option "with-tesseract", "Enable Tesseract, needed for ocr filter"
  option "with-two-lame", "Enable MP2 encoding via libtwolame"
  option "with-wavpack", "Enable wavpack encoding via libwavpack"
  option "with-webp", "Enable using libwebp to encode WEBP images"
  option "with-xvid", "Enable Xvid encoding via xvidcore native MPEG-4/Xvid encoder exists"
  option "with-zeromq", "Enable using libzeromq to receive cmds sent through a libzeromq client"
  option "with-zimg", "Enable z.lib, needed for zscale filter"

  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "nasm" => :build
  depends_on "pkg-config" => :build
  depends_on "texi2html" => :build
  depends_on "yasm" => :build

  depends_on "aom"
  depends_on "fontconfig"
  depends_on "freetype"
  depends_on "frei0r"
  depends_on "lame"
  depends_on "libass"
  depends_on "libvorbis"
  depends_on "libvpx"
  depends_on "opus"
  depends_on "rtmpdump"
  depends_on "sdl2"
  depends_on "snappy"
  depends_on "theora"
  depends_on "x264"
  depends_on "x265"
  depends_on "xz"

  unless OS.mac?
    depends_on "zlib"
    depends_on "bzip2"
    depends_on "linuxbrew/xorg/libxv"
  end

  depends_on "gnutls" => :recommended

  depends_on "amiaopensource/amiaos/decklinksdk" => :optional
  depends_on "jjangsangy/packages/chromaprint" => :optional

  depends_on "dav1d" => :optional
  depends_on "fdk-aac" => :optional
  depends_on "game-music-emu" => :optional
  depends_on "gmp" => :optional
  depends_on "kvazaar" => :optional
  depends_on "libbluray" => :optional
  depends_on "libbs2b" => :optional
  depends_on "libcaca" => :optional
  depends_on "libgcrypt" => :optional
  depends_on "libgsm" => :optional
  depends_on "libmodplug" => :optional
  depends_on "librsvg" => :optional
  depends_on "libsoxr" => :optional
  depends_on "libssh" => :optional
  depends_on "libvidstab" => :optional
  depends_on "libvmaf" => :optional
  depends_on "libxml2" => :optional
  depends_on "opencore-amr" => :optional
  depends_on "openh264" => :optional
  depends_on "openjpeg" => :optional
  depends_on "rubberband" => :optional
  depends_on "speex" => :optional
  depends_on "srt" => :optional
  depends_on "tesseract" => :optional
  depends_on "two-lame" => :optional
  depends_on "wavpack" => :optional
  depends_on "webp" => :optional
  depends_on "xvid" => :optional
  depends_on "zeromq" => :optional
  depends_on "zimg" => :optional

  if build.with? "tesseract"
    depends_on "tesseract-lang" => :recommended
  end

  def install
    # Work around Xcode 11 clang bug
    # https://bitbucket.org/multicoreware/x265/issues/514/wrong-code-generated-on-macos-1015
    ENV.append_to_cflags "-fno-stack-check" if DevelopmentTools.clang_build_version >= 1010

    ENV.append("extra_libs", "-lpthread")
    ENV.append("extra_libs", "-lm")

    args = %W[
      --prefix=#{prefix}
      --extra-libs=#{ENV["extra_libs"]}
      --enable-hardcoded-tables
      --enable-nonfree
      --enable-gpl
      --enable-pthreads
      --disable-static
      --enable-shared
      --enable-version3
      --cc=#{ENV.cc}
      --host-cflags=#{ENV.cflags}
      --host-ldflags=#{ENV.ldflags}
      --enable-avresample
      --enable-ffplay
      --enable-frei0r
      --enable-libaom
      --enable-libass
      --enable-libfontconfig
      --enable-libfreetype
      --enable-libmp3lame
      --enable-libopus
      --enable-libsnappy
      --enable-libtheora
      --enable-libvorbis
      --enable-libvpx
      --enable-libx264
      --enable-libx265
      --enable-lzma
      --disable-indev=jack
      --disable-libjack
      --disable-doc
    ]

    if OS.mac?
      args << "--enable-opencl"
      args << "--enable-videotoolbox"
    end

    args << "--enable-chromaprint" if build.with? "chromaprint"
    args << "--enable-decklink" if build.with? "decklinksdk"
    args << "--enable-gcrypt" if build.with? "libgcrypt"
    args << "--enable-gmp" if build.with? "gmp"
    args << "--enable-gnutls" if !build.without? "gnutls"
    args << "--enable-libbluray" if build.with? "libbluray"
    args << "--enable-libbs2b" if build.with? "libbs2b"
    args << "--enable-libcaca" if build.with? "libcaca"
    args << "--enable-libdav1d" if build.with? "dav1d"
    args << "--enable-libfdk-aac" if build.with? "fdk-aac"
    args << "--enable-libgme" if build.with? "game-music-emu"
    args << "--enable-libgsm" if build.with? "libgsm"
    args << "--enable-libkvazaar" if build.with? "kvazaar"
    args << "--enable-libmodplug" if build.with? "libmodplug"
    args << "--enable-libopenh264" if build.with? "openh264"
    args << "--enable-librsvg" if build.with? "librsvg"
    args << "--enable-librubberband" if build.with? "rubberband"
    args << "--enable-libsoxr" if build.with? "libsoxr"
    args << "--enable-libspeex" if build.with? "speex"
    args << "--enable-libsrt" if build.with? "srt"
    args << "--enable-libssh" if build.with? "libssh"
    args << "--enable-libtesseract" if build.with? "tesseract"
    args << "--enable-libtwolame" if build.with? "two-lame"
    args << "--enable-libvidstab" if build.with? "libvidstab"
    args << "--enable-libvmaf" if build.with? "libvmaf"
    args << "--enable-libwavpack" if build.with? "wavpack"
    args << "--enable-libwebp" if build.with? "webp"
    args << "--enable-libxml2" if build.with? "libxml2"
    args << "--enable-libxvid" if build.with? "xvid"
    args << "--enable-libzimg" if build.with? "zimg"
    args << "--enable-libzmq" if build.with? "zeromq"

    if build.with? "openjpeg"
      args << "--enable-libopenjpeg"
      args << "--disable-decoder=jpeg2000"
      args << "--extra-cflags=" + `pkg-config --cflags libopenjp2`.chomp
    end

    if build.with? "opencore-amr"
      args << "--enable-libopencore-amrnb"
      args << "--enable-libopencore-amrwb"
    end

    system "./configure", *args
    system "make", "install"

    # Build and install additional FFmpeg tools
    system "make", "alltools"
    bin.install Dir["tools/*"].select { |f| File.executable? f }
    mv bin/"python", pkgshare/"python", :force => true
  end

  test do
    # Create an example mp4 file
    mp4out = testpath/"video.mp4"
    system bin/"ffmpeg", "-filter_complex", "testsrc=rate=1:duration=1", mp4out
    assert_predicate mp4out, :exist?
  end
end
