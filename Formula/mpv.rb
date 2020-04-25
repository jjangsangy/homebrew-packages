class Mpv < Formula
  desc "Media player based on MPlayer and mplayer2"
  homepage "https://mpv.io"
  head "https://github.com/mpv-player/mpv.git"

  stable do
    url "https://github.com/mpv-player/mpv/archive/v0.32.0.tar.gz"
    sha256 "9163f64832226d22e24bbc4874ebd6ac02372cd717bef15c28a0aa858c5fe592"
    version "0.32.0"
  end

  option "with-app", "Build standalone mpv app"
  option "with-dav1d", "Build with support for av1 decoding"

  depends_on "dav1d" => :optional

  depends_on "docutils" => :build
  depends_on "pkg-config" => :build
  depends_on "python" => :build
  depends_on :xcode => :build
  depends_on :macos => :yosemite

  depends_on "jjangsangy/packages/ffmpeg"
  depends_on "jpeg"
  depends_on "libarchive"
  depends_on "libass"
  depends_on "little-cms2"
  depends_on "lua@5.1"
  depends_on "sdl2"

  depends_on "mujs"
  depends_on "uchardet"
  depends_on "vapoursynth"
  depends_on "youtube-dl"


  def install
    # LANG is unset by default on macOS and causes issues when calling getlocale
    # or getdefaultlocale in docutils. Force the default c/posix locale since
    # that's good enough for building the manpage.
    ENV["LC_ALL"] = "C"

    args = %W[
      --prefix=#{prefix}
      --enable-html-build
      --enable-javascript
      --enable-jpeg
      --enable-lgpl
      --enable-libarchive
      --enable-libmpv-shared
      --enable-lua
      --enable-uchardet
      --enable-sdl2
      --confdir=#{etc}/mpv
      --datadir=#{pkgshare}
      --mandir=#{man}
      --docdir=#{doc}
      --zshdir=#{zsh_completion}
      --lua=51deb
    ]

    args << "--enable-clang-database" if ENV.cc == :clang

    system "python3", "bootstrap.py"
    system "python3", "waf", "configure", *args
    system "python3", "waf", "install"

    if build.with? "app"
      system "python3", "./TOOLS/osxbundle.py", "build/mpv"
      cp bin/"mpv", "build/mpv.app/Contents/MacOS/mpv"
      prefix.install "build/mpv.app"
    end
  end

  test do
    system bin/"mpv", "--ao=null", test_fixtures("test.wav")
  end
end